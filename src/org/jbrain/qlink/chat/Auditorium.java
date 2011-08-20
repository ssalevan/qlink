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

import org.jbrain.qlink.user.QHandle;

public class Auditorium extends AbstractRoom {

	public Auditorium(AuditoriumDelegate room, QHandle handle) {
		super(room,handle);		
}

	public void say(String[] text) {
		((AuditoriumDelegate)_room).queue(_handle,text);
	}

	public void say(String text) {
		String[] s=new String[1];
		s[0]=text;
		say(s);
	}
	
	/* (non-Javadoc)
	 * @see org.jbrain.qlink.chat.QRoom#createGame(java.lang.String, java.lang.String, boolean)
	 */
	public Game createGame(int id,String name, String type, boolean systemPickOrder) {
		return null;
	}

	/* (non-Javadoc)
	 * @see org.jbrain.qlink.chat.QRoom#getPendingGame()
	 */
	public Game getPendingGame() {
		return null;
	}

	/* (non-Javadoc)
	 * @see org.jbrain.qlink.chat.QRoom#getInfo()
	 */
	public String getInfo() {
		return _room.getInfo();
	}

	/* (non-Javadoc)
	 * @see org.jbrain.qlink.chat.QRoom#getSeatInfoList()
	 */
	public QSeat[] getSeatInfoList() {
		return _room.getSeatInfoList(_handle);
		
	}

	/**
	 * @return
	 */
	public boolean canTalk() {
		return _room.canTalk();
	}

	public void leave() {
		RoomManager.getRoomManager().leaveAuditorium(_handle);
		super.leave();
	}

	/* (non-Javadoc)
	 * @see org.jbrain.qlink.chat.QRoom#getExtSeatInfoList()
	 */
	public QSeat[] getExtSeatInfoList() {
		return _room.getSeatInfoList(_handle);
	}
}
