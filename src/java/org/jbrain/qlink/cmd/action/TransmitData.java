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
	Created on Aug 12, 2005
	
 */
package org.jbrain.qlink.cmd.action;

public class TransmitData extends AbstractAction {
	private byte[] _data;
	private int _iLen;
	public static final int SEND = 1;
	public static final int SAVE = 2;
	public static final int END = 3;

	
	public TransmitData(byte[] data,int len,int type) {
		super(type==SEND?"F7":type==SAVE?"F8":"F9");
		_data=data;
		_iLen=len;
	}
	
	public byte[] getBytes() {
		byte[] data;
		data=new byte[10 + _iLen];
		System.arraycopy(_data,0,data,10,_iLen);
		finalizeCmd(data);
		return data;
	}
	

}
