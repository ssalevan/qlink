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

public class LoadObservedGame extends AbstractAction {
	private byte[] _seats;
	private String _sCode;
	private int _iID;

	public LoadObservedGame(int id, String code, byte[] seats) {
		super("J3");
		_iID=id;
		_sCode=code;
		_seats=seats;
	}
	
	public byte[] getBytes() {
		byte[] b=getBytes(_sCode);
		byte[] data=new byte[10 + 3 + b.length +  _seats.length];
		data[10]=(byte)_iID;
		System.arraycopy(b,0,data,11,b.length);
		int pos=11+b.length;
		data[pos++]=(byte)0x90;
		data[pos++]=(byte)_seats.length;
		System.arraycopy(_seats,0,data,pos,_seats.length);
		// add 1 or 2 to seatnumbers
		for(int i=0;i<_seats.length;i++) {
			data[pos+i]++;
			if(data[pos+i]>=13)
				data[pos+i]++;
		}
		finalizeCmd(data);
		return data;
	}	

}
