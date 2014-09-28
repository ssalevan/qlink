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
	Created on Oct 13, 2005
	
 */
package org.jbrain.qlink.cmd.action.fdo;


public class FDOItemID {
	private int _iID;

	public FDOItemID(int id) {
		_iID=id;
		if((id&0xff0000) == 0x0d0000 || (id&0xff00) == 0x0d00 || (id&0xff) == 0x0d) {
			throw new IllegalArgumentException("ID has 0x0d in it");
		}
	}
	
	public int getID() {
		return _iID;
	}

	/**
	 * @return
	 */
	public byte getMSB() {
		return (byte)((_iID>>16) & 0xff);
	}

	/**
	 * @return
	 */
	public byte getSSB() {
		return (byte)((_iID>>8) & 0xff);
	}

	/**
	 * @return
	 */
	public byte getLSB() {
		return (byte)((_iID) & 0xff);
	}
	
	public boolean equals(Object o) {
		if(!(o instanceof FDOItemID))
			return false;
		return (((FDOItemID)o).getID()==_iID);
	}

}
