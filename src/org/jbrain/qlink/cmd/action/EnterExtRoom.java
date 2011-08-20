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

import java.util.Arrays;

import org.jbrain.qlink.cmd.action.fdo.FDOItemID;

public class EnterExtRoom extends AbstractAction {

	private FDOItemID _id;
	private int _iSeat;
	private String _sRoom;

	public EnterExtRoom(FDOItemID id, int seat,String room) {
		super("CI");
		_id=id;
		_iSeat=seat;
		_sRoom=room;
		if(id==null)
			throw new NullPointerException("Null ID");
		if(_sRoom==null)
			throw new NullPointerException("Null room name");
		if(_sRoom.length()>20)
			throw new IllegalArgumentException("QRoom name length > 20");
	}
	
	public EnterExtRoom(int id, int seat, String name) {
		this(new FDOItemID(id),seat,name);
	}

	public byte[] getBytes() {
		byte[] b=getBytes(_sRoom);
		byte[] data=new byte[10 + 27];
		Arrays.fill(data,(byte)0x20);
		data[10]=(byte)_id.getMSB();
		data[11]=(byte)_id.getSSB();
		data[12]=(byte)_id.getLSB();
		data[13]=0;
		data[14]=(byte)0x90;
		data[15]=(byte)_iSeat;
		if(data[15]>=0x0d)
			data[15]++;
		System.arraycopy(b,0,data,16,b.length);
		data[36]=0;
		finalizeCmd(data);
		return data;
	}	
}
