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


public class RoomInfo {

	private String _sName;
	private int _iPopulation;
	private boolean _bPublic;

	/**
	 * @param name
	 * @param population
	 */
	public RoomInfo(String name, int pop, boolean bPublic) {
		_sName=name;
		_iPopulation=pop;
		_bPublic=bPublic;
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
	public int getPopulation() {
		return _iPopulation;
	}

	/**
	 * @return
	 */
	public boolean isPublicRoom() {
		return _bPublic;
	}

}
