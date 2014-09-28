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

public class RoomLine extends AbstractAction {

	private String _sName;
	private int _iNum;
	
	public RoomLine(String name, int num, boolean last) {
		super((last?"LD":"LM"));
		_iNum=num;
		_sName=name;
	}
	
	public byte[] getBytes() {
		byte[] b=getBytes(_sName);
		byte[] data=new byte[10+4 + 20];
		// fill with spaces.
		Arrays.fill(data, (byte)0x20);
		data[10]=(byte)_iNum;
		if(data[10]==0x0d)
			data[10]++;
		if(_iNum>=10)
			data[11]=(byte)((_iNum/10)+'0');
		data[12]=(byte)((_iNum%10)+'0');
		data[13]=(byte)0x90;
		int len=Math.min(b.length,20);
		System.arraycopy(b,0,data,14,len);
		finalizeCmd(data);
		return data;
	}	
}
