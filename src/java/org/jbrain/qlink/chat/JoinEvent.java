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
package org.jbrain.qlink.chat;

import java.util.EventObject;

public class JoinEvent extends EventObject implements RoomEvent {
	public static final int EVENT_JOIN=1;
	public static final int EVENT_LEAVE=2;
	
	private int _iType;
	private int _seat;
	private String _name;

	public JoinEvent(QRoomDelegate obj, int type, int id, String name) {
		super(obj);
		_iType=type;
		_seat=id;
		_name=name;
	}
	
	public int getSeatID() {
		return _seat;
	}
	
	public String getName() {
		return _name;
	}
	
	public int getType() {
		return _iType;
	}

	public QRoomDelegate getRoom() {
		return (QRoomDelegate)getSource();
	}

}
