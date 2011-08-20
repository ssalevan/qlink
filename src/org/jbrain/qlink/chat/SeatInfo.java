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


public class SeatInfo implements QSeat {
	private QHandle _handle;
	private int _iSeat;
	private ChatProfile _profile;
	private boolean _bGamePending;
	private boolean _bIgnore;
	private static ChatProfile _defProfile=new ChatProfile();
	
	public SeatInfo(QHandle handle) {
		this(handle,-1,_defProfile);
	}
	public SeatInfo(QHandle handle, int seat, ChatProfile profile) {
		_handle=handle;
		_iSeat=seat;
		_profile=profile;
		_bIgnore=false;
		_bGamePending=false;
	}

	/**
	 * @return
	 */
	public int getSeatID() {
		return _iSeat;
	}
	
	/**
	 * @return
	 */
	public QHandle getHandle() {
		return _handle;
	}
	
	void setGameStatus(boolean b) {
		_bGamePending=b;
	}
	
	/**
	 * @return
	 */
	public boolean isInGame() {
		return _bGamePending;
	}

	/**
	 * @return
	 */
	public ChatProfile getProfile() {
		return _profile;
	}

	/**
	 * @param b
	 */
	void setIgnore(boolean b) {
		_bIgnore=b;
	}
	
	public boolean isIgnored() {
		return _bIgnore;
	}
	
}
