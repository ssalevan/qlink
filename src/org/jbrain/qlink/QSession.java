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
	Created on Jul 25, 2005
	
 */
package org.jbrain.qlink;

import java.io.IOException;
import java.sql.Connection;
import java.text.DecimalFormat;
import java.util.*;


import org.apache.log4j.Logger;
import org.jbrain.qlink.cmd.action.Action;
import org.jbrain.qlink.cmd.action.SendOLM;
import org.jbrain.qlink.cmd.action.SendSYSOLM;
import org.jbrain.qlink.connection.*;
import org.jbrain.qlink.state.*;
import org.jbrain.qlink.user.AccountInfo;
import org.jbrain.qlink.user.QHandle;

public class QSession {
	private static Logger _log=Logger.getLogger(QSession.class);
	//private static Hashtable _htSessions = new Hashtable();
	private QConnection _link;
	private QState _state;
	private Connection _conn=null;
	private Date _startTime;
	private Hashtable _htOLMTable = new Hashtable();
	private int _iOLMID=0;
	private int _iOLMReadID=0;
	public static final String OLM_PREFIX = "OLM";
	private boolean _bOLMs;
	private QLinkServer _server;
	private Vector _listeners=new Vector();

	private ConnEventListener _linklistener = new ConnEventListener() {
		public void actionOccurred(ActionEvent event) {
			try {
				_log.debug(_state.getName()
					+ ": Executing "
					+ event.getAction().getName());
				_state.execute(event.getAction());
			} catch (IOException e) {
				// this means the connection died, so close down the server.
				_log.error("Link error detected, shutting down instance", e);
				terminate();
			} catch (RuntimeException e) {
				_log.error(
					"Runtime error encountered, shutting down instance",
					e);
				terminate();
			}
		}
	};
	private AccountInfo _account;

	public QSession(QLinkServer server, QConnection link) {
		_server=server;
		_link=link;
		_state=new Authentication(this);
		_link.addEventListener(_linklistener);
		// start receiving data
		_link.start();
		_startTime=new Date();
		
	}

	/**
	 * @return
	 */
	public QLinkServer getServer() {
		return _server;
	}
	
	public boolean send(Action a) {
		_log.debug("Dispatching Action: " + a.getName());
		try {
			_link.send(a);
			return true;
		} catch (IOException e) {
			// this means the connection died, so close down the server.
			_log.error("Link error detected, shutting down instance",e);
			terminate();
			return false;
		}
	}
	/**
	 * @param update
	 */
	public void setState(QState state) {
		_log.debug("Setting state to: " + state.getName());
		_state=state;
	}
	
	/**
	 * @param textActions
	 */
	public void send(Action[] actions) throws IOException {
		if(actions != null) {
			for(int i=0;i<actions.length;i++) {
				send(actions[i]);
			}
		}
	}

	/**
	 * @return
	 */
	public QState getState() {
		return _state;
	}

	/**
	 * 
	 */
	public synchronized void terminate() {
		_log.info("Terminating server instance");
		try {
			_link.removeEventListener(_linklistener);
			_state.terminate();
			_link.close();
		} catch (RuntimeException e) {
			_log.error("Encountered unchecked Exception",e);
		} finally {
			processEvent(new TerminationEvent(this));
			//_server.removeSession(this);
		}
		if(_htOLMTable.size()>0)
			_log.warn("Session closing with unread OLMs!");
	}

	/**
	 * @return
	 */
	public Date getStartTime() {
		return _startTime;
	}

	/**
	 * @param olm
	 */
	public void sendOLM(String[] olm) {
		String id;
		_log.debug("Preparing OLM for user:" + getHandle());
		synchronized(_htOLMTable) {
			DecimalFormat sdf=new DecimalFormat("0000000");
			id= OLM_PREFIX + sdf.format(_iOLMID++);
			_htOLMTable.put(id,olm);
		}
		// send ONOLM command.
		send(new SendOLM(id));
	}
	
	public String[] getOLM(String id) {
		return (String[])_htOLMTable.remove(id);
	}
	
	public void enableOLMs(boolean state) {
		_bOLMs=state;
	}
	
	/**
	 * @return
	 */
	public boolean canReceiveOLMs() {
		return _bOLMs;
	}

	/**
	 * @param user
	 * @return
	 */
	public void suspend() {
		_link.suspendLink();
	}
	
	public void resume() {
		_link.resumeLink();
	}

	public void setAccountInfo(AccountInfo account) {
		QHandle old=getHandle();
		
		_log.debug("User ID: " + account.getUserID());
		_log.debug("Account ID: " + account.getAccountID());
		_log.debug("Primary Account: " + account.isPrimaryAccount());
		_log.debug("Staff Account: " + account.isStaff());
		_log.debug("User Handle: " + account.getHandle());
		_account=account;

		processEvent(new UserNameChangeEvent(this,old,account.getHandle()));
	}

	/**
	 * @return
	 */
	public AccountInfo getAccountInfo() {
		return _account;
	}

	public int getUserID() {
		if(_account!=null)
			return _account.getUserID();
		return 0;
	}

	public int getAccountID() {
		if(_account!=null)
			return _account.getAccountID();
		return 0;
	}

	/**
	 * @return
	 */
	public QHandle getHandle() {
		if(_account!=null)
			return _account.getHandle();
		return null;
	}

	/**
	 * @return
	 */
	public boolean isStaff() {
		if(_account!=null)
			return _account.isStaff();
		return false;
	}

	/**
	 * @return
	 */
	public boolean isPrimaryAccount() {
		if(_account!=null)
			return _account.isPrimaryAccount();
		return false;
	}

	/**
	 * @return
	 */
	/**
	 * @param msg
	 */
	public void sendSYSOLM(String msg) {
		send(new SendSYSOLM(msg));
	}

	public void addEventListener(SessionEventListener listener) {
		_listeners.add(listener);
	}

	/**
	 * @return
	 */
	public String[] getOLM() {
		DecimalFormat sdf=new DecimalFormat("0000000");
		String id=sdf.format(_iOLMReadID++);
		String[] data=getOLM(OLM_PREFIX + id);
		return data;
	}

	public void removeEventListener(SessionEventListener listener) {
		if(_listeners.contains(listener)) {
			_listeners.remove(listener);
		}
	}
	
	protected void processEvent(SessionEvent event) {
		if(event instanceof StateChangeEvent)
			processStateChangeEvent((StateChangeEvent)event);
		else if(event instanceof UserNameChangeEvent)
			processUserNameChangeEvent((UserNameChangeEvent)event);
		else if(event instanceof TerminationEvent)
			processTerminationEvent((TerminationEvent)event);
	}

	protected void processUserNameChangeEvent(UserNameChangeEvent event) {
		if(event != null && _listeners.size() > 0) {
			for(int i=0,size=_listeners.size();i<size;i++) {
				((SessionEventListener)_listeners.get(i)).userNameChanged(event);
			}
		}
	}

	protected void processStateChangeEvent(StateChangeEvent event) {
		if(event != null && _listeners.size() > 0) {
			for(int i=0,size=_listeners.size();i<size;i++) {
				((SessionEventListener)_listeners.get(i)).stateChanged(event);
			}
		}
	}

	protected void processTerminationEvent(TerminationEvent event) {
		if(event != null && _listeners.size() > 0) {
			for(int i=0,size=_listeners.size();i<size;i++) {
				((SessionEventListener)_listeners.get(i)).sessionTerminated(event);
			}
		}
	}

}