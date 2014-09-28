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
	Created on Jul 22, 2005
	
 */
package org.jbrain.qlink.cmd.action;

public class PrepGame extends AbstractAction {
	private byte[] _seats;

	public PrepGame(byte[] seats) {
		super("GO");
		_seats=seats;
	}
	
	public byte[] getBytes() {
		byte[] data=new byte[11 + _seats.length];
		data[10]=(byte)_seats.length;
		System.arraycopy(_seats,0,data,11,_seats.length);
		// add 1 or 2 to seatnumbers
		for(int i=0;i<_seats.length;i++) {
			data[11+i]++;
			if(data[11+i]>=13)
				data[11+i]++;
		}
		finalizeCmd(data);
		return data;
	}	

}
