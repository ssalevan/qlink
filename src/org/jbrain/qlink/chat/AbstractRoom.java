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
	Created on Jul 27, 2005
	
 */
package org.jbrain.qlink.chat;

import java.util.ArrayList;

import org.jbrain.qlink.user.QHandle;

public abstract class AbstractRoom implements QRoom {

	protected QRoomDelegate _room;
	protected QHandle _handle;
	private ArrayList _listeners = new ArrayList();
	private RoomEventListener _listener = new RoomEventListener() {
		public void userSaid(ChatEvent event) {
			processEvent(event);
		}
		public void userJoined(JoinEvent event) {
			processEvent(event);
		}
		public void userLeft(JoinEvent event) {
			processEvent(event);
		}
		public void systemSent(SystemMessageEvent event) {
			processEvent(event);
		}
		public void acceptingQuestions(QuestionStateEvent event) {
			processEvent(event);
		}
		public void rejectingQuestions(QuestionStateEvent event) {
			processEvent(event);
		}
	};

	/**
	 * @param room
	 * @param handle
	 */
	public AbstractRoom(QRoomDelegate room, QHandle handle) {
		_room=room;
		_handle=handle;
		_room.addEventListener(_listener);
	}

	/**
	 * @return
	 */
	public String getName() {
		return _room.getName();
	}

	/**
	 * @return
	 */
	public int getPopulation() {
		return _room.getPopulation();
	}

	public synchronized void addEventListener(RoomEventListener listener) {
		_listeners.add(listener);
	}

	public synchronized void removeEventListener(RoomEventListener listener) {
		if(_listeners.contains(listener)) {
			_listeners.remove(listener);
		}
	}

	public ObservedGame observeGame(QHandle handle) {
		return _room.observeGame(handle);
	}

	public GameInfo[] getGameInfoList() {
		return _room.getGameInfoList();
	}

	public boolean isPublicRoom() {
		return _room.isPublicRoom();
	}

	/* (non-Javadoc)
	 * @see org.jbrain.qlink.chat.QRoom#getSeatInfo(java.lang.String)
	 */
	public QSeat getSeatInfo(QHandle handle) {
		return _room.getSeatInfo(handle);
	}

	public void leave() {
		_room.removeEventListener(_listener);
	}

	public abstract void say(String text);

	public abstract void say(String[] text);

	public boolean changeUserName(QHandle handle,ChatProfile profile) {
		boolean b=_room.changeUserName(_handle,handle,profile);
		if(b)
			_handle=handle;
		return b;
	}
	
	public boolean canTalk() {
		return _room.canTalk();
	}

	protected synchronized void processEvent(RoomEvent event) {
		if(event instanceof JoinEvent) 
			processJoinEvent((JoinEvent)event);
		else if(event instanceof ChatEvent) 
			processChatEvent((ChatEvent)event);
		else if(event instanceof SystemMessageEvent) 
			processSystemMessageEvent((SystemMessageEvent)event);
		else if(event instanceof QuestionStateEvent) 
			processQuestionStateEvent((QuestionStateEvent)event);
	}
	
	
	protected void processJoinEvent(JoinEvent event) {
		if(event != null && _listeners.size() > 0) {
			if(event.getType()==JoinEvent.EVENT_JOIN)
				for(int i=0,size=_listeners.size();i<size;i++) {
					((RoomEventListener)_listeners.get(i)).userJoined(event);
				}
			else
				for(int i=0,size=_listeners.size();i<size;i++) {
					((RoomEventListener)_listeners.get(i)).userLeft(event);
				}
		}
	}

	protected void processQuestionStateEvent(QuestionStateEvent event) {
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

	protected void processChatEvent(ChatEvent event) {
		if(event != null && _listeners.size() > 0) {
			for(int i=0,size=_listeners.size();i<size;i++) {
				((RoomEventListener)_listeners.get(i)).userSaid(event);
			}
		}
	}

	protected void processSystemMessageEvent(SystemMessageEvent event) {
		if(event.getName().equals("") || _handle.toString().equals(event.getName())) {
			if(event != null && _listeners.size() > 0) {
				for(int i=0,size=_listeners.size();i<size;i++) {
						((RoomEventListener)_listeners.get(i)).systemSent(event);
				}
			}
		}
	}
	
}
