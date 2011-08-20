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
import java.util.*;

import org.apache.log4j.Logger;
import org.jbrain.qlink.QSession;
import org.jbrain.qlink.cmd.action.*;

class MenuEntry {

	private int _iID;
	private String _sTitle;
	private int _iType;
	private int _iCost;

	/**
	 * @param refid
	 * @param title
	 * @param type
	 * @param cost
	 */
	public MenuEntry(int id, String title, int type, int cost) {
		_iID=id;
		_sTitle=title;
		_iType=type;
		_iCost=cost;
	}

	/**
	 * @return
	 */
	public int getType() {
		return _iType;
	}

	/**
	 * @return
	 */
	public String getTitle() {
		return _sTitle;
	}

	/**
	 * @return
	 */
	public int getID() {
		return _iID;
	}

	/**
	 * @return
	 */
	public int getCost() {
		return _iCost;
	}
	
}

class MessageEntry {
	private String _sTitle;
	private Date _date;
	private int _iReplies=0;
	private String _sAuthor;
	private int _iID;

	public MessageEntry(int id, String title, String author, Date date) {
		_iID=id;
		_sTitle=title;
		_date=date;
		_sAuthor=author;
	}

	/**
	 * @return
	 */
	public String getTitle() {
		return _sTitle;
	}

	/**
	 * @return
	 */
	public String getAuthor() {
		return _sAuthor;
	}

	/**
	 * @return
	 */
	public int getID() {
		return _iID;
	}

	/**
	 * @return
	 */
	public Date getDate() {
		return _date;
	}

	/**
	 * @param int1
	 */
	public void addReplyID(int id) {
		_iReplies++;
		
	}

	/**
	 * @return
	 */
	public int getReplies() {
		return _iReplies;
	}
}

public abstract class AbstractMenuState extends AbstractState {
	protected static Logger _log=Logger.getLogger(AbstractMenuState.class);
	protected static final int RESERVED_DATA_REF_ID_MIN=0x700000;
	protected static final int RESERVED_DATA_REF_ID_MAX=0x7fffff;
	protected static final int RESERVED_MENU_REF_ID_MIN=0x800000;
	protected static final int RESERVED_MENU_REF_ID_MAX=0x8fffff;
	protected static final int XMIT_BLOCKS_MAX=16;
	
	protected List _lText;
	private int _iLines;
	protected ArrayList _alMessages = new ArrayList();
	protected HashMap _hmMessages = new HashMap();
	protected ArrayList _alMenu = new ArrayList();
	private boolean _bSuperChat=false;
	
	public AbstractMenuState(QSession session) {
		super(session);
		session.enableOLMs(true);
	}
	
	public boolean execute(Action a) throws IOException {
		boolean rc=false;
		QState state;
		
		if(a instanceof EnterMessageBoard) {
			// seems strange that we get this and that we need to send ANOTHER MC back.
			_session.send(new MC());
			if(checkEmail())
				_session.send(new NewMail());
			rc=true;
		} else if(a instanceof EnterSuperChat) {
			_bSuperChat=true;
			rc=true;
		} else if(a instanceof EnterChat) {
			rc=true;
			if(_bSuperChat)
				state=new SuperChat(_session);
			else
				state=new Chat(_session);
			state.activate();
		} else if(a instanceof AbortSelectList) {
			clearMessageList();
		} else if(a instanceof SelectMoreList) {
			sendMessageList();
		} else if(a instanceof FileTextAck) {
			sendPackedLines();
		}
		if(!rc)
			rc=super.execute(a);
		return rc;
	}
	
	/**
	 * 
	 */
	protected void sendMenu(int id) throws IOException {
		int i=0,size=_alMenu.size();
		MenuEntry m;
		
		while(i<size) {
			m=(MenuEntry)_alMenu.get(i++);
		   	if(m.getType()==MenuItem.MESSAGE_BASE) 
		    		_session.send(new MenuItem(m.getID(),m.getTitle(),m.getID(),i== size && id>=10));
		    	else 
		    		_session.send(new MenuItem(m.getID(),m.getTitle(),m.getType(),m.getCost(),i==size && id>=10));
		}
		if(size==0) {
			_log.error("Menu ID invalid.");
			_session.send(new MenuItem(0,"Menu not available at this time.",MenuItem.HEADING,MenuItem.COST_NO_CHARGE,false));
		}
		if(id<10 || size==0) {
			_session.send(new MenuItem(422,"    Q-Link Post Office (+)",MenuItem.POST_OFFICE,MenuItem.COST_PREMIUM,false));
			_session.send(new MenuItem(0,"    Move to Another Q-Link Department",MenuItem.AREA_MENU,MenuItem.COST_NO_CHARGE,true));
		}
		
	}

	/**
	 * @throws IOException
	 * 
	 */
	protected void sendSingleLines() throws IOException {
		int i=0;
        while(i++<18 && _iLines+1<_lText.size()) {
    		_session.send(new FileText((String)_lText.get(_iLines++) + (char)0x7f,false));
        }
        if(_iLines+1<_lText.size()) {
    		_session.send(new FileTextPing((String)_lText.get(_iLines++) + (char)0x7f));
        } else {
    		_session.send(new FileText((String)_lText.get(_iLines++) + (char)0x7f,true));
        }
	}

	protected void sendPackedLines() throws IOException {
		int i=0;
		String line;
		StringBuffer sb=new StringBuffer();
		// we want to send up to 19 lines...
        while(i++<18 && _iLines+1<_lText.size()) {
        	line=(String)_lText.get(_iLines++);
        	if(sb.length() + 1 + line.length() > 117) {
        		// send packet.
        		_session.send(new FileText(sb.toString(),false));
        		sb.setLength(0);
        	}
        	// add line
    		sb.append(line);
    		sb.append((char)0x7f);
        }
        // we are guaranteed to have one more line to send, but may have data in buffer.
        if(sb.length()>0) {
        	// we have stored data, go ahead and send it.  We will only be sending 18 lines in this case.
    		_session.send(new FileTextPing(sb.toString()));
        } else if(_iLines+1<_lText.size()) {
    		_session.send(new FileTextPing((String)_lText.get(_iLines++) + (char)0x7f));
        } else {
    		_session.send(new FileText((String)_lText.get(_iLines++) + (char)0x7f,true));
        }
	}


	protected void sendMessageList() throws IOException {
		// we send these backwards from the List.
		int i=0;
		MessageEntry m;
		PostingItem line;
		
		int size=_alMessages.size();
		if(size==0)
			_session.send(new PostingItem("No News (is good news)", PostingItem.LAST));
		else {
			while(i<4 && _iLines<size-1) {
				i++;
				_iLines++;
				m=(MessageEntry)_alMessages.get(size-_iLines);
				_session.send(new PostingItem(m.getID(),m.getTitle(),m.getAuthor(),m.getReplies(),m.getDate(),PostingItem.NEXT));
			}
			_iLines++;
			m=(MessageEntry)_alMessages.get(size-_iLines);
			if(_iLines==size) {
				// after the ++ above, we should be at end.
				_session.send(new PostingItem(m.getID(),m.getTitle(),m.getAuthor(),m.getReplies(),m.getDate(),PostingItem.LAST));
				clearMessageList();
			} else {
				_session.send(new PostingItem(m.getID(),m.getTitle(),m.getAuthor(),m.getReplies(),m.getDate(),PostingItem.NEXT));
				_session.send(new PostingItem("Use RETURN to go on, F5 to cancel.",PostingItem.PAUSE));
			}
		}
		
	}

	
	protected void clearLineCount() {
		_iLines=0;
	}
	/**
	 * 
	 */
	protected void clearMessageList() {
		_hmMessages.clear();
		_alMessages.clear();
	}
	
}
