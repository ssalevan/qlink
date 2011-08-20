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
	Created on Oct 7, 2005
	
 */
package org.jbrain.qlink.state;

import java.io.IOException;
import java.util.ArrayList;
import org.apache.log4j.Logger;
import org.jbrain.qlink.QSession;
import org.jbrain.qlink.chat.*;
import org.jbrain.qlink.cmd.action.*;

public class SimpleChat extends AbstractChatState {
	private static Logger _log=Logger.getLogger(SimpleChat.class);
	private QueuedChatEventListener _listener;
	private String _sRoom;
	private QState _intState;

	class QueuedChatEventListener implements RoomEventListener {
		private boolean _bSuspend=true;
		private ArrayList _alQueue=new ArrayList();

		/* (non-Javadoc)
		 * @see org.jbrain.qlink.chat.BasicRoomEventListener#eventOccurred(org.jbrain.qlink.chat.RoomEvent)
		 */
		public synchronized void suspend() {
			_bSuspend=true;
		}
		
		public synchronized void resume() {
			RoomEvent e;
			
			_bSuspend=false;
			while(_alQueue.size()>0) {
				e=(RoomEvent)_alQueue.remove(0);
				if(e instanceof ChatEvent)
					userSaid((ChatEvent)e);
				else if(e instanceof SystemMessageEvent)
					systemSent((SystemMessageEvent)e);
				else if(e instanceof JoinEvent && ((JoinEvent)e).getType()==JoinEvent.EVENT_JOIN)
					userJoined((JoinEvent)e);
				else if(e instanceof JoinEvent && ((JoinEvent)e).getType()==JoinEvent.EVENT_LEAVE)
					userLeft((JoinEvent)e);
				else if(e instanceof QuestionStateEvent && ((QuestionStateEvent)e).getType()==QuestionStateEvent.ACCEPTING_QUESTIONS)
					acceptingQuestions((QuestionStateEvent)e);
				else if(e instanceof QuestionStateEvent && ((QuestionStateEvent)e).getType()==QuestionStateEvent.NOT_ACCEPTING_QUESTIONS)
					rejectingQuestions((QuestionStateEvent)e);
			}
		}
		public void userSaid(ChatEvent event) {
			if(_bSuspend)
				_alQueue.add(event);
			else
				if(_log.isDebugEnabled())
					_log.debug("Sending " + event.getName() + "'s text: '" + event.getText() +"'");
				if(event.getSeatID()>-1) {
					_session.send(new ChatSend(event.getSeatID(),event.getText()));
				} else {
					_session.send(new AnonChatSend(event.getName(),event.getText()));
				}
			
		}

		public void userJoined(JoinEvent event) {
			if(_bSuspend)
				_alQueue.add(event);
			else {
				if(_log.isDebugEnabled())
					_log.debug(event.getName() + " enters room in seat " + event.getSeatID());
				_session.send(new CA(event.getSeatID(),event.getName()));
			}
			
		}

		public void userLeft(JoinEvent event) {
			if(_bSuspend)
				_alQueue.add(event);
			else {
				if(_log.isDebugEnabled())
					_log.debug(event.getName() + " leaves room and vacates seat " + event.getSeatID());
				_session.send(new CB(event.getSeatID(),event.getName()));
			}
		}

		public void systemSent(SystemMessageEvent event) {
			// send ourselves an OLM, as we requested it.
			String[] msg=event.getMessage();
			_session.sendOLM(msg);
			
		}

		public void acceptingQuestions(QuestionStateEvent event) {
			_session.send(new AcceptingQuestions());
		}

		public void rejectingQuestions(QuestionStateEvent event) {
			_session.send(new RejectingQuestions());
		}
	}

	/**
	 * @param session
	 */
	public SimpleChat(QSession session, String room) {
		super(session);
		_sRoom=room;
	}
	
	public void activate() throws IOException {
		QSeat[] seats;
		
		_intState=_session.getState();		
		super.activate();
		// enter room.
		_log.debug(_session.getHandle() + "joins " + _sRoom);
		// TODO what do we do if room is full?
		_room=_mgr.joinRoom(_sRoom, _session.getHandle(),getProfile(_session.getAccountInfo()), false);
		// create new listener.
		seats=addListener();
		showSeats(seats,false);
	}

	public boolean execute(Action a) throws IOException {
		boolean rc=false;

		if(a instanceof EnterMessageBoard) {
			_session.send(new MC());
			leaveRoom();
			_session.setState(_intState);
		}
		if(!rc)
			rc=super.execute(a);
		return rc;
	}
}
