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
	Created on Jul 28, 2005
	
 */
package org.jbrain.qlink.chat;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

import org.apache.log4j.Logger;
import org.jbrain.qlink.db.DBUtils;
import org.jbrain.qlink.text.TextFormatter;
import org.jbrain.qlink.user.QHandle;

class Question {
	private QHandle _handle;
	private String[] _question;
	
	public Question(QHandle handle, String[] question) {
		_handle=handle;
		_question=question;
	}

	/**
	 * @return
	 */
	public String[] getQuestion() {
		return _question;
	}

	/**
	 * @return
	 */
	public QHandle getHandle() {
		return _handle;
	}
	
}

class AuditoriumDelegate extends RoomDelegate {
	private static Logger _log=Logger.getLogger(AuditoriumDelegate.class);
	private static QHandle _qlink=new QHandle("Q-Link");
	private List _queue = Collections.synchronizedList(new ArrayList());
	private boolean _bAcceptingQuestions = false;
	private List _vRegList = new Vector();
	private AutoText _autoTalk;
	private Hashtable _htViewers = new Hashtable();
	private static final int ID_VIEWER=23;
 
	class AutoText extends Thread {
		//private String pad="                              ";
		private String _sKey;
		public AutoText(String key) {
			_sKey=key;
			//this.setDaemon(true);
			this.start();
		}
		
		public void run() {
		    Connection conn=null;
		    Statement stmt = null;
		    ResultSet rs = null;
		    
		    try {
		    	conn=DBUtils.getConnection();
		        stmt = conn.createStatement();
		        _log.debug("Reading auditorium text");
		    	rs=stmt.executeQuery("SELECT delay,text from auditorium_talk WHERE mnemonic LIKE '" + _sKey + "' order by sort_order");
		    	while(rs.next()) {
		    		output(_qlink,rs.getString("text"));
		    		try {
						Thread.sleep(rs.getInt("delay")*1000);
					} catch (InterruptedException e) {
						_log.debug("AutoText timer was interrupted");
					}
		    	}
		    } catch (SQLException e) {
		    	_log.error("SQL Exception",e);
		    } finally {
		    	DBUtils.close(rs);
		    	DBUtils.close(stmt);
		    	DBUtils.close(conn);
		    }
			
		}
	}
	
	public QSeat[] getSeatInfoList(QHandle handle) {
		// get list of speakers/moderators.
		QSeat[] seats=super.getSeatInfoList(handle);
		QSeat seat=(QSeat)_htViewers.get(handle.getKey());
		if(seat!=null) {
			QSeat[] seats2=new SeatInfo[seats.length+1];
			System.arraycopy(seats,0,seats2,0,seats.length);
			// need to put me in the list.
			seats2[seats.length]=seat;
			seats=seats2;
		}
		return seats;
	
	}

	
	
	/**
	 * @param name
	 */
	public AuditoriumDelegate(String name) {
		super(name,false,true);
	}
	
	public synchronized void queue(QHandle handle, String[] question) {
		_queue.add(new Question(handle,question));
		
		if(_vRegList.size()>0) {
			ArrayList alMsg=new ArrayList();
			privmsgQuestion(alMsg,_queue.size()-1);
			for(int i=0,size=_vRegList.size();i<size;i++) {
				sendSystemMessage(((QSeat)_vRegList.get(i)),alMsg);
			}
		}
	}
	
	public void leave(QHandle handle) {
		QSeat seat=getSeatInfo(handle);
		_vRegList.remove(seat);
		super.leave(handle);
	}
	
	private void output(QHandle handle,String text) {
	    TextFormatter tf =new TextFormatter(TextFormatter.FORMAT_PADDED,29);
	    List l;
	    String str;
	    String name=handle.toString();
	    StringBuffer sb=new StringBuffer();
	    
		tf.add(text);
		l=tf.getList();
		// spit out 3 lines as one chat text.
		for(int i=0,size=l.size();i<size;i++) {
			str=(String)l.get(i);
			_log.debug("appending: '" + str + "'");
			sb.append(str);
			if(i%3==2 || i+1==size) {
				// send the string.
				processEvent(new ChatEvent(this,-1,name,sb.toString()));
				name="";
				sb.setLength(0);
			} else {
				sb.append(" ");
			}
		}
	}
	
	/**
	 * @param user
	 * @param text
	 */
	protected void processCommand(SeatInfo seat, String text) {
		ArrayList alMsg=new ArrayList();
		String[] cmdline=text.split(" ");
		String cmd=cmdline[0].toLowerCase();
		StringBuffer sb=new StringBuffer();
		int pos=0;
		
		if(cmd.startsWith("sho") || cmd.startsWith("air")) {
			// show
			if(cmdline.length>1)
				pos=getNumber(cmdline[1]);
			if(pos>-1 && pos < _queue.size()) {
				_log.debug("Showing question: " + pos);
				Question q=(Question)_queue.remove(pos);
				for(int i=0,size=q.getQuestion().length;i<size;i++) {
					sb.append(q.getQuestion()[i]);
					sb.append(" ");
				}
				output(q.getHandle(),sb.toString());
				sb.setLength(0);
			}
		} else if(cmd.startsWith("get")) {
			// get
			if(cmdline.length>1)
				pos=getNumber(cmdline[1]);
			if(pos>-1 && pos < _queue.size()) {
				_log.debug("Retrieving question: " + pos);
				privmsgQuestion(alMsg,pos);
				sendSystemMessage(seat,alMsg);
			}
		} else if(cmd.startsWith("del") || cmd.startsWith("rem")) {
			// delete
			if(cmdline.length>1)
				pos=getNumber(cmdline[1]);
			if(pos>-1 && pos < _queue.size()) {
				_log.debug("Deleting question: " + pos);
				Question q=(Question)_queue.remove(pos);
				alMsg.add("Question " + pos + " deleted.");
				sendSystemMessage(seat,alMsg);
			}
		} else if(cmd.startsWith("lis")) {
			// list
			if(cmdline.length>1)
				pos=getNumber(cmdline[1]);
			if(pos>-1 && pos < _queue.size()) {
				_log.debug("Listing questions starting with: " + pos);
				int max=pos+4;
				for(;pos<_queue.size()&&pos<max;pos++)
					privmsgQuestion(alMsg,pos);
				sendSystemMessage(seat,alMsg);
			}
		} else if(cmd.startsWith("cou")) {
			// count
			_log.debug("Sending count of queued questions: " + _queue.size());
			alMsg.add("There are " + _queue.size() + " questions in the queue.");
			sendSystemMessage(seat,alMsg);
		} else if(cmd.startsWith("cle")) {
			// clear Q
			_log.debug("Clearing question queue");
			_queue.clear();
			alMsg.add("Queue now empty.");
			sendSystemMessage(seat,alMsg);
		} else if(cmd.startsWith("acc")){
			_log.debug("Accepting questions");
			_bAcceptingQuestions=true;
			processEvent(new QuestionStateEvent(this,QuestionStateEvent.ACCEPTING_QUESTIONS));
		} else if(cmd.startsWith("rej")){
			_log.debug("Rejecting questions");
			_bAcceptingQuestions=false;
			processEvent(new QuestionStateEvent(this,QuestionStateEvent.NOT_ACCEPTING_QUESTIONS));
		} else if(cmd.startsWith("reg")){
			_log.debug("Registering for notifications");
			_vRegList.add(seat);
		} else if(cmd.startsWith("unr")){
			_log.debug("De-Registering for notifications");
			_vRegList.remove(seat);
		} else if(cmd.startsWith("auto")){
			_log.debug("Starting autotext");
			if(cmdline.length>1) {
				_log.debug("Sending auto text: " + cmdline[1]);
				_autoTalk=new AutoText(cmdline[1]);
			} else {
				alMsg.add("no key specified");
				sendSystemMessage(seat,alMsg);
			}
		} else {
			super.processCommand(seat,text);
		}
		
		
		// execture command
	}

	/**
	 * @param pos
	 */
	private void privmsgQuestion(List l, int pos) {
		Question q=(Question)_queue.get(pos);
		l.add("Question#: " + pos + " from " + q.getHandle() + ":");
		for(int i=0,size=q.getQuestion().length;i<size;i++)
			l.add(q.getQuestion()[i]);
	}

	/**
	 * @return
	 */
	public boolean canTalk() {
		return _bAcceptingQuestions;
	}

	public String getInfo() {
		// we'll grab the speaker information here.
	    Connection conn=null;
	    Statement stmt = null;
	    ResultSet rs = null;
	    StringBuffer sb=new StringBuffer();
	    
	    try {
	    	conn=DBUtils.getConnection();
	        stmt = conn.createStatement();
	        _log.debug("Reading auditorium text");
	    	rs=stmt.executeQuery("SELECT text from auditorium_text WHERE start_date<now() AND end_date>now()");
	    	while(rs.next()) {
	    		sb.append(rs.getString("text"));
	    		sb.append("\n");
	    	}
	    } catch (SQLException e) {
	    	_log.error("SQL Exception",e);
	    } finally {
	    	DBUtils.close(rs);
	    	DBUtils.close(stmt);
	    	DBUtils.close(conn);
	    }
	    return sb.toString();
	}
	
	protected void processEvent(RoomEvent event) {
		if(event instanceof QuestionStateEvent)
			processQuestionStateEvent((QuestionStateEvent)event);
		else
			super.processEvent(event);
	}
	
	public synchronized void processQuestionStateEvent(QuestionStateEvent event) {
		if(event != null && _listeners.size() > 0) {
			if(event.getType()==QuestionStateEvent.ACCEPTING_QUESTIONS)
				for(int i=0,size=_listeners.size();i<size;i++) {
					((RoomEventListener)_listeners.get(i)).acceptingQuestions(event);
				}
			else
				for(int i=0,size=_listeners.size();i<size;i++) {
					((RoomEventListener)_listeners.get(i)).rejectingQuestions(event);
				}
		}
	}

	/**
	 * @param handle
	 */
	public QSeat addViewer(QHandle handle, ChatProfile profile) {
		QSeat seat=new SeatInfo(handle,ID_VIEWER,profile);
		_htViewers.put(handle.getKey(),seat);
		return seat;
	}
	
	public void removeViewer(QHandle handle) {
		_htViewers.remove(handle.getKey());
	}

	public ObservedGame observeGame(String handle) {
		return null;
	}
	

}
