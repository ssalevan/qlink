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
	Created on Sep 6, 2005
	
 */
package org.jbrain.qlink.chat;


public class GameInfo {
	private byte[] _seats;
	private String _sName;

	/**
	 * @param name
	 * @param playOrder
	 */
	public GameInfo(String name, byte[] playOrder) {
		_seats=new byte[playOrder.length];
		System.arraycopy(playOrder,0,_seats,0,_seats.length);
		_sName=name;
	}

	/**
	 * @return
	 */
	public String getName() {
		return _sName;
	}

	/**
	 * @return
	 */
	public byte[] getPlayOrder() {
		return _seats;
	}

}
