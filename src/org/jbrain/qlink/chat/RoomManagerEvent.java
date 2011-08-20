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
	Created on Oct 20, 2005
	
 */
package org.jbrain.qlink.chat;

import java.util.EventObject;


public class RoomManagerEvent extends EventObject {

	public static final int EVENT_ADD=1;
	public static final int EVENT_REMOVE=2;
	
	private QRoomDelegate _room;
	private int _iType;

	/**
	 * @param arg0
	 */
	public RoomManagerEvent(Object arg0, int type, QRoomDelegate room) {
		super(arg0);
		_room=room;
		_iType=type;
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
	public QRoomDelegate getRoom() {
		return _room;
	}

}
