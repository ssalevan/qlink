/*
	Copyright Jim Brain and Brain Innovations, 2005.

	This file is part of QLinkServer.

	QLinkServer is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	QLinkServer is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with QLinkServer; if not, write to the Free Software
	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

	@author Jim Brain
	Created on Jul 23, 2005
	
 */
package org.jbrain.qlink.state;

import java.io.*;
import java.lang.reflect.Constructor;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.jbrain.qlink.QSession;
import org.jbrain.qlink.cmd.action.*;
import org.jbrain.qlink.db.DBUtils;
import org.jbrain.qlink.io.EscapedInputStream;
import org.jbrain.qlink.text.TextFormatter;
import org.jbrain.qlink.user.AccountInfo;
import org.jbrain.qlink.user.AccountUpdateException;
import org.jbrain.qlink.user.UserManager;

public class DepartmentMenu extends AbstractMenuState {
	private static Logger _log=Logger.getLogger(DepartmentMenu.class);
	private InputStream _is;
	protected int _iCurrMenuID;
	protected int _iCurrMessageID;
	protected int _iNextMessageID;
	protected int _iCurrParentID;
	
	private List _lRefreshAccounts=null;
	private AccountInfo _refreshAccount=null;
	 
	public DepartmentMenu(QSession session) {
		super(session);
		session.enableOLMs(true);
	}
	
	public void activate() throws IOException {
		_session.send(new MC());
		super.activate();
		checkAccountRefresh();
}
	/* (non-Javadoc)
	 * @see org.jbrain.qlink.state.QState#execute(org.jbrain.qlink.cmd.Command)
	 */
	public boolean execute(Action a) throws IOException {
		boolean rc=false;
		QState state;
		
		if(a instanceof SelectMenuItem) {
			rc=true;
			int id=((SelectMenuItem)a).getID();
			selectItem(id);
			// wait until after the list is sent.
			if(_lRefreshAccounts!=null) {
	    		_session.send(new SendSYSOLM("System: Refreshing user name list"));
	    		refreshAccount();
			}
		} else if(a instanceof SelectFileDocumentation) {
			rc=true;
			int id=((SelectFileDocumentation)a).getID();
			_log.debug("Getting documentation for File ID: " + id);
			displayDBTextFile(id);
		} else if(a instanceof ListSearch) {
			rc=true;
			int id=((ListSearch)a).getID();
			int index=((ListSearch)a).getIndex();
			_log.debug("Received Search request with ID=" + id + " and index=" + index);
			//int bid=((MenuEntry)_alMenu.get(((ListSearch)a).getIndex())).getID();
			String q=((ListSearch)a).getQuery().replaceAll("'","\\\\'");
			selectMessageList(id,"AND (title LIKE '%" + q + "%' OR text LIKE '%" + q + "%')");
			clearLineCount();
			sendMessageList();
		} else if(a instanceof AbortDownload) {
			rc=true;
			_log.debug("Client aborted download, closing InputStream");
			if(_is!=null)
				_is.close();
		} else if(a instanceof DownloadFile) {
			rc=true;
			openStream(((DownloadFile)a).getID());
		} else if(a instanceof StartDownload) {
			rc=true;
			_log.debug("Client requested download data");
			byte[] b=new byte[116];
			int len=-1;
			for(int i=0;i<XMIT_BLOCKS_MAX && (len=_is.read(b))>0;i++) {
				_session.send(new TransmitData(b,len,i==XMIT_BLOCKS_MAX-1?TransmitData.SAVE:TransmitData.SEND));
			}
			if(len<0) {
				_log.debug("Download completed, closing stream and sending EOF to client.");
				_session.send(new TransmitData(b,0,TransmitData.END));
				_is.close();
			}
			
		} else if(a instanceof SelectDateReply) {
			rc=true;
			int id=((SelectDateReply)a).getID();
			Date date=((SelectDateReply)a).getDate();
			_log.debug("User requested next reply after " + date);
			// need to search for next reply, and send.
			id=selectDatedReply(id,date);
			displayMessage(id);
		} else if(a instanceof SelectList) {
			rc=true;
			int id=((SelectList)a).getID();
			selectMessageList(id,"");
			clearLineCount();
			sendMessageList();
		} else if(a instanceof GetMenuInfo) {
			rc=true;
			int id=((GetMenuInfo)a).getID();
			selectItem(id);
		} else if(a instanceof RequestItemPost) {
			rc=true;
			int id=((RequestItemPost)a).getID();
			int index=((RequestItemPost)a).getIndex();
			_log.debug("Received Post request with ID=" + id + " and index=" + index);
			int pid;
			int bid;
			if(id==_iCurrParentID) {
				_log.debug("User requests a new file comment");
				// file comments
				bid=pid=id;
			} else {
				if(id==_iCurrMessageID) {
					_log.debug("User requests a new reply");
					pid=_iCurrParentID;
					if(pid==0)
						pid=id;
				} else {
					_log.debug("User requests a new posting");
					 if(id!=_iCurrMenuID)
					 	selectMenu(id);
					 pid=0;
				}
				bid=((MenuEntry)_alMenu.get(index)).getID();
			}
			state=new PostMessage(_session,bid,pid,_iNextMessageID);
			state.activate();
		} else if(a instanceof ResumeService) {
			refreshAccount();
		}
		if(!rc)
			rc=super.execute(a);
		return rc;
	}
	
	/**
	 * @param id
	 */
	private void openStream(int id) throws IOException {
        Connection conn=null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
        	conn=DBUtils.getConnection();
            stmt = conn.createStatement();
            _log.debug("Selecting file " + id + " for download");
	        rs=stmt.executeQuery("SELECT filetype, LENGTH(data) as length,data from files where reference_id=" + id);
	        if(rs.next()) {
	        	// get our File length.
	        	int mid=rs.getInt("length");
	        	String type=rs.getString("filetype");
	        	// get binary stream
	        	_is=new EscapedInputStream(rs.getBinaryStream("data"));
	        	DBUtils.close(rs);
	        	_session.send(new InitDownload(mid,type));
	        } else {
    			_log.error("File not found.");
	        	// TODO What should we do if we do not find anything?
	        }
        } catch (SQLException e) {
        	_log.error("SQL Exception",e);
        	// TODO What should we do if we do not find anything?
        } finally {
        	DBUtils.close(rs);
        	DBUtils.close(stmt);
        	DBUtils.close(conn);
        }
	}

	/**
	 * @param id
	 * @param date
	 * @return
	 */
	private int selectDatedReply(int id, Date date) {
        Connection conn=null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try {
        	conn=DBUtils.getConnection();
            stmt = conn.createStatement();
            _log.debug("Searching for reply after " + date);
	        rs=stmt.executeQuery("SELECT message_id, parent_id from messages where reference_id=" + id);
	        if(rs.next()) {
	        	// get our message ID.
	        	int mid=rs.getInt("message_id");
	        	// this should be the same as _iParentID, but to be sure.
	        	int pid=rs.getInt("parent_id");
	        	if(pid!=_iCurrParentID)
	        		_log.error("Select Dated Reply id " + id + " has parent=" + pid + ", but current ParentID value=" + _iCurrParentID);
	        	DBUtils.close(rs);
	        	SimpleDateFormat sdf=new SimpleDateFormat("MM/dd/yyyy");
	        	// now, look for new replies.
		        rs=stmt.executeQuery("SELECT reference_id from messages where parent_id=" + pid + " AND message_id > " + mid + " AND date > '" + sdf.format(date) + " LIMIT 1");
		        if(rs.next()) {
		        	id= rs.getInt("reference_id");
		        } else {
		        	_log.error("We did not find any replies after this date");
		        	// TODO What should we do if we do not find anything?
	        	}
	        } else {
    			_log.error("Reply Dated search did not locate reply.");
	        	// TODO What should we do if we do not find anything?
	        }
        } catch (SQLException e) {
        	_log.error("SQL Exception",e);
        	// TODO What should we do if we do not find anything?
        } finally {
        	DBUtils.close(rs);
        	DBUtils.close(stmt);
        	DBUtils.close(conn);
        }
    	return id;
	}

	private void selectItem(int id) throws IOException {
        Connection conn=null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try {
        	conn=DBUtils.getConnection();
            stmt = conn.createStatement();
            _log.debug("Selecting Item: " + id);
	        rs=stmt.executeQuery("SELECT entry_type, cost, special FROM entry_types WHERE reference_id=" + id);
	        if(rs.next()) {
	        	int type=rs.getInt("entry_type");
	        	String cost=rs.getString("cost");
	        	if(rs.getString("special").equalsIgnoreCase("Y") && setHandler(id)) {
	        		return;
	        	} else { 
		        	switch(type) {
		        		case MenuItem.MENU:
		        			_log.debug("Item is a menu, sending new menu");
		        			selectMenu(id);
		        			sendMenu(id);
		        			break;
		        		case MenuItem.MESSAGE:
		        			_log.debug("Item is a message, display it");
		        			displayMessage(id);
		        			break;
		        		case MenuItem.TEXT:
		        		case MenuItem.MULTI_TEXT:
		        			_log.debug("Item is a file, display it");
		        			displayDBTextFile(id);
			        		break;
			        	case MenuItem.DOWNLOAD:
			        		_log.debug("Item is a download, display text");
			        		displayFileInfo(id);
			        		break;
		        		case MenuItem.GATEWAY:
		        			_log.debug("Item is a gateway, connect to it");
		        			connectToGateway(id);
			        		break;
			        	case MenuItem.CHAT:
		        			_log.debug("Item is a chat room, enter it");
			        		enterChat(id);
			        		break;
			        	default:
			    			_log.error("Item has unknown type (" + type + "), what should we do?");
			        		break;
		        	}
	        	}
	        } else {
    			_log.error("Item has no reference, what should we do?");
	        }
        } catch (SQLException e) {
        	_log.error("SQL Exception",e);
        	// big time error, send back error string and close connection
        } finally {
        	DBUtils.close(rs);
        	DBUtils.close(stmt);
        	DBUtils.close(conn);
        }
	}
	
	
	/**
	 * @param id
	 */
	private void enterChat(int id) throws IOException {
        Connection conn=null;
        Statement stmt = null;
        ResultSet rs = null;
        String room;
        int port;
        
        try {
        	conn=DBUtils.getConnection();
            stmt = conn.createStatement();
            _log.debug("Get room information for  Chat ID: " + id);
	        rs=stmt.executeQuery("SELECT room from vendor_rooms where reference_id=" + id);
	        if(rs.next()) {
	        	room=rs.getString("room");
	    		QState state=new SimpleChat(_session,room);
	    		state.activate();
	        } else {
        		_log.debug("Vendor room record does not exist.");
        		// TODO need to handle this.
	        }
        } catch (SQLException e) {
        	_log.error("SQL Exception",e);
        	// TODO do something better than this.
        	_session.terminate();
        } finally {
        	DBUtils.close(rs);
        	DBUtils.close(stmt);
        	DBUtils.close(conn);
        }
	}

	/**
	 * @param id
	 * @throws IOException
	 */
	protected void connectToGateway(int id) throws IOException {
        Connection conn=null;
        Statement stmt = null;
        ResultSet rs = null;
        String address;
        int port;
        
        try {
        	conn=DBUtils.getConnection();
            stmt = conn.createStatement();
            _log.debug("Get file information for  Gateway ID: " + id);
	        rs=stmt.executeQuery("SELECT address,port from gateways where gateway_id=" + id);
	        if(rs.next()) {
	        	address=rs.getString("address");
	        	port=rs.getInt("port");
	        	if(address==null || address.equals("")) {
	        		_log.debug("Gateway address is null or empty.");
	    			_session.send(new GatewayExit("Destination invalid"));
	        	} else {
	        		if (port==0)
	        			port=23;
					QState state=new GatewayState(_session,address,port);
					state.activate();
	        	}
	        } else {
        		_log.debug("Gateway record does not exist.");
    			_session.send(new GatewayExit("Destination invalid"));
	        }
        } catch (SQLException e) {
        	_log.error("SQL Exception",e);
			_session.send(new GatewayExit("Server error"));
        } finally {
        	DBUtils.close(rs);
        	DBUtils.close(stmt);
        	DBUtils.close(conn);
        }
		
	}

	
	/**
	 * @param id
	 */
	private boolean setHandler(int id) throws IOException {
        Connection conn=null;
        Statement stmt = null;
        ResultSet rs = null;
        QState state=null;
        
        try {
        	conn=DBUtils.getConnection();
            stmt = conn.createStatement();
            _log.debug("Selecting Special item: " + id);
	        rs=stmt.executeQuery("SELECT handler FROM reference_handlers WHERE reference_id=" + id);
    		if(rs.next()) {
    			String clazz=rs.getString("handler");
    			_log.debug("Found Handler: " + clazz);
    			try {
					Class c=Class.forName(clazz);
					Class signature[] = new Class[1];
					signature[0]=QSession.class;
					Constructor cons=c.getConstructor(signature);
					Object[] parms=new Object[1];
					parms[0]=_session;
					state=(QState)cons.newInstance(parms);
				} catch (Exception e) {
					_log.error("Cannot set code handler for id: " + id, e);
				}
    		}
    		if(state!=null) {
    			state.activate();
    			return true;
	        } else {
    			_log.error("handler is null");
	        }
        } catch (SQLException e) {
        	_log.error("SQL Exception",e);
        	// big time error, send back error string and close connection
        } finally {
        	DBUtils.close(rs);
        	DBUtils.close(stmt);
        	DBUtils.close(conn);
        }
        return false;
	}

	/**
	 * 
	 */
	
	private String pad="                 ";
	private void displayFileInfo(int id) throws IOException {
        Connection conn=null;
        Statement stmt = null;
        ResultSet rs = null;
        String name;
        
        /*
         * We may want to move the actual file description into a message, so the MessageID will be technically valid.
         */
        _iCurrMessageID=id;  // not really, but in PostItem, if this is not set, if thinks it is a new posting, but it is really a reply
        _iNextMessageID=0;
        try {
        	conn=DBUtils.getConnection();
            stmt = conn.createStatement();
            _log.debug("Get file information for FileID: " + id);
	        rs=stmt.executeQuery("SELECT name, filetype, description from files where reference_id=" + id);
	        if(rs.next()) {
	            TextFormatter tf=new TextFormatter(TextFormatter.FORMAT_NONE,39);
	            name=rs.getString("name");
	            tf.add("      " + name);
	            tf.add("     " + rs.getString("filetype"));
	        	String data=rs.getString("description");
	        	// temp testing
	        	rs=stmt.executeQuery("SELECT reference_id FROM messages WHERE parent_id=" + id + " LIMIT 1");
	        	if(rs.next()) {
	        		_iNextMessageID=rs.getInt("reference_id");
	        	}
	            _session.send(new InitDataSend(id,0,0,_iNextMessageID,0));
	            tf.add(data);
	            tf.add("\n <<   PRESS F7 FOR DOWNLOAD MENU    >> ");
	            _lText=tf.getList();
				clearLineCount();
	            sendSingleLines();
	        } else {
    			_log.error("Item has no reference, what should we do?");
	        }
        } catch (SQLException e) {
        	_log.error("SQL Exception",e);
        	// big time error, send back error string and close connection
        } finally {
        	DBUtils.close(rs);
        	DBUtils.close(stmt);
        	DBUtils.close(conn);
        }
	}

	/**
	 * @param id
	 */
	private void displayMessage(int id) throws IOException {
        Connection conn=null;
        Statement stmt = null;
        ResultSet rs = null;
        int next=0;
        int mid;
        int pid=0;
        int bid=0;
        int prev=0;
        TextFormatter tf=new TextFormatter(TextFormatter.FORMAT_NONE,39);
        
        _iCurrMessageID=id;
        _iNextMessageID=0;
        try {
        	conn=DBUtils.getConnection();
            stmt = conn.createStatement();
            _log.debug("Querying for message");
            String text;
	        rs=stmt.executeQuery("SELECT base_id,parent_id, message_id,text FROM messages WHERE reference_id=" + id);
	        if(rs.next()) {
	        	text=rs.getString("text");
	        	bid=rs.getInt("base_id");
	        	mid=rs.getInt("message_id");
	        	pid=rs.getInt("parent_id");
	        	_iCurrParentID=pid;
	        	// are we a main message?
	        	if(pid==0)
	        		pid=id;
	        	DBUtils.close(rs);
	        	// are there any replies to either this message or it's parent?
	        	rs=stmt.executeQuery("SELECT reference_id FROM messages WHERE message_id>" + mid + " AND parent_id=" + pid + " LIMIT 1");
	        	if(rs.next()) {
	        		_iNextMessageID=rs.getInt("reference_id");
	        		_log.debug("Message ID: " + id + " has next message ID: " + _iNextMessageID);
	        	}
	        	if(bid==pid) {
	        		// only do this if it is a file comment.
	        		DBUtils.close(rs);
		        	rs=stmt.executeQuery("SELECT reference_id FROM messages WHERE message_id<" + mid + " AND parent_id=" + pid + " ORDER BY message_id DESC LIMIT 1");
		        	if(rs.next()) {
		        		prev=rs.getInt("reference_id");
		        		_log.debug("Message ID: " + id + " has previous message ID: " + prev);
		        	}
	        	}
	        } else {
				_log.error("Message ID invalid.");
				text="Message Not Found";
        	}
        	DBUtils.close(rs);
	        // init data area
        	if(bid==pid) {
        		// we are a file comment, as they have board ID same as parent id.
                _session.send(new InitDataSend(id,prev,_iNextMessageID));
        	} else {
        		_session.send(new InitDataSend(id,0,0,_iNextMessageID,0));
        	}
            tf.add(text);
            _lText=tf.getList();
			clearLineCount();
            sendSingleLines();
        } catch (SQLException e) {
        	_log.error("SQL Exception",e);
        	// big time error, send back error string and close connection
        } finally {
        	DBUtils.close(rs);
        	DBUtils.close(stmt);
        	DBUtils.close(conn);
        }
	}

	/**
	 * @param id
	 * @param url
	 */
	private void displayDBTextFile(int id) throws IOException {
        Connection conn=null;
        Statement stmt = null;
        ResultSet rs = null;
        boolean bData=false;
        
        try {
        	conn=DBUtils.getConnection();
            stmt = conn.createStatement();
            _log.debug("Querying for text file");
            String data;
            int prev=0,next=0;
	        rs=stmt.executeQuery("SELECT next_id,prev_id,data FROM articles WHERE article_id=" + id);
	        if(rs.next()) {
	        	prev=rs.getInt("prev_id");
	        	next=rs.getInt("next_id");
	        	data=rs.getString("data");
	        } else {
				_log.error("Article ID invalid.");
				data="File Not Found";
        	}
        	DBUtils.close(rs);
	        // init data area
            _session.send(new InitDataSend(id,prev,next));
            TextFormatter tf=new TextFormatter(TextFormatter.FORMAT_NONE,39);
            tf.add(data);
            if(next!=0)
            	tf.add("\n  <PRESS F7 AND SELECT \"GET NEXT ITEM\">");
            else
            	tf.add("\n            <PRESS F5 FOR MENU>");
            _lText=tf.getList();
			clearLineCount();
            sendSingleLines();
        } catch (SQLException e) {
        	_log.error("SQL Exception",e);
        	// big time error, send back error string and close connection
        	_session.terminate();
        } finally {
        	DBUtils.close(rs);
        	DBUtils.close(stmt);
        	DBUtils.close(conn);
        }
	}

	/**
	 * @throws IOException
	 * 
	 */
	private void selectMenu(int id) throws IOException {
		boolean rc=false;
        Connection conn=null;
        Statement stmt = null;
        ResultSet rs = null;
        boolean bData=false;
        int type=0;
        String cost;
        int refid;
        String title;
        int iCost=MenuItem.COST_NORMAL;
        MenuEntry m;
        
        _alMenu.clear();
		_iCurrMenuID=id;
        try {
        	conn=DBUtils.getConnection();
            stmt = conn.createStatement();
            _log.debug("Querying for menu");
	        rs=stmt.executeQuery("SELECT toc.reference_id,toc.title,entry_types.entry_type,entry_types.cost FROM toc,entry_types WHERE toc.reference_id=entry_types.reference_id and toc.menu_id=" + id + " AND toc.active='Y' ORDER by toc.sort_order");
	        while(rs.next()) {
	        	bData=true;
	        	type=rs.getInt("entry_types.entry_type");
	        	cost=rs.getString("entry_types.cost");
	        	refid=rs.getInt("toc.reference_id");
	        	title=rs.getString("toc.title");
	        	if(type!=MenuItem.HEADING)
	        		title="    " + title;
	        	if(cost.equals("PREMIUM")) {
	        		title=title+" (+)";
	        		iCost=MenuItem.COST_PREMIUM;
	        	} else if(cost.equals("NOCHARGE")) {
	        		iCost=MenuItem.COST_NO_CHARGE;
	        	}
	        	_alMenu.add(new MenuEntry(refid,title,type,iCost));
	        }
        	DBUtils.close(rs);
        } catch (SQLException e) {
        	_log.error("SQL Exception",e);
        	// big time error, send back error string and close connection
        } finally {
        	DBUtils.close(rs);
        	DBUtils.close(stmt);
        	DBUtils.close(conn);
        }
	}
	
	private void selectMessageList(int id, String query) {
        Connection conn=null;
        Statement stmt = null;
        ResultSet rs = null;
        int num=0;
        MessageEntry m;
        
        int prev=0;
        int next=0;
        int mid=0;
        int pid;
        String author=null;
        String title=null;
        String text=null;
        Date date=null;
        int replies=0;
        
        clearMessageList();
        try {
        	conn=DBUtils.getConnection();
            stmt = conn.createStatement();
            _log.debug("Selecting message list for message base " + id);
        	rs=stmt.executeQuery("SELECT reference_id,parent_id, title,author, date,replies from messages WHERE base_id=" + id + " " + query + " order by message_id");
        	while(rs.next()) {
        		pid=rs.getInt("parent_id");
    			mid=rs.getInt("reference_id");
        		if(pid!=0) {
        			m=(MessageEntry)_hmMessages.get(new Integer(pid));
        			if(m!= null)
        				m.addReplyID(mid);
        			else
        				_log.error("Reference ID: " + mid + "is an orphan?");
        			
        		} else {
	        		title=rs.getString("title");
	        		author=rs.getString("author");
	        		date=rs.getDate("date");
	        		m=new MessageEntry(mid,title,author, date);
	        		_alMessages.add(m);
	        		_hmMessages.put(new Integer(mid),m);
	        		num++;
        		}
        	}
            _log.debug(num + " message found in message base");
        } catch (SQLException e) {
        	_log.error("SQL Exception",e);
        } finally {
        	DBUtils.close(rs);
        	DBUtils.close(stmt);
        	DBUtils.close(conn);
        }
	}

	/**
	 * 
	 */
	private void refreshAccount() throws IOException {
		if(_refreshAccount!=null) {
			try {
				//update the account just refreshed.
				_refreshAccount.setRefresh(false);
				_refreshAccount=null;
			} catch (AccountUpdateException e) {
				_log.error("Update Exception",e);
				_session.terminate();
			}
		}
		if(_lRefreshAccounts!=null && _lRefreshAccounts.size()!=0) {
			DecimalFormat format=new DecimalFormat("0000000000");
			_refreshAccount=(AccountInfo)_lRefreshAccounts.remove(0);
			String account;
			_log.debug("Refreshing user name: " + _refreshAccount.getHandle());
			account=format.format(_refreshAccount.getAccountID());
			_session.send(new AddSubAccount(account,_refreshAccount.getHandle().toString()));
			if(_lRefreshAccounts.size()==0)
				_lRefreshAccounts=null;
		}
	}

	/**
	 * 
	 */
	private void checkAccountRefresh() throws IOException {
		AccountInfo info;
		
		_lRefreshAccounts=UserManager.getSubAccountsforUser(_session.getUserID());
		for(int i=_lRefreshAccounts.size()-1;i>-1;i--) {
			info=(AccountInfo)_lRefreshAccounts.get(i);
			if(!info.needsRefresh()) {
				_lRefreshAccounts.remove(i);
			}
		}
		if(_lRefreshAccounts.size()==0) {
			_lRefreshAccounts=null;
		}
	}
}
