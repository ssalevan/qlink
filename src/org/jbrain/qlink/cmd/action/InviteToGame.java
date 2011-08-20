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

public class InviteToGame extends AbstractAction {
	private byte[] _seats;
	private int _iSeat;
	private boolean _bSystemPickOrder;
	private String _sName;
	private int _iID;

	public InviteToGame(boolean order, int seat, int id, String name, byte[] seats) {
		super("GP");
		_iSeat=seat;
		_iID=id;
		_bSystemPickOrder=order;
		_sName=name;
		_seats=seats;
	}
	
	public byte[] getBytes() {
		byte[] b1=getBytes(_sName);
		byte[] data=new byte[10 + 1 + 1 + 1 + b1.length + 2 + _seats.length];
		data[10]=(byte)(_bSystemPickOrder?0x31:0x30);
		data[11]=(byte)++_iSeat;
		if(data[11]>=13)
			data[11]++;
		// copy type
		data[12]=(byte)_iID;
		System.arraycopy(b1,0,data,13,b1.length);
		// copy name
		int pos=13+b1.length;
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
