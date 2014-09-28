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

public class InitDataSend extends AbstractMenuItem {
	private int _iPrevious;
	private int _iNext; 
	private int _iFirst=0;
	private int _iLast=0;

	public InitDataSend(int curr, int prev, int next) {
		this(curr,prev,next,0,0);
	}
	
	public InitDataSend(int curr, int prev, int next, int first, int last) {
		super("KC",curr);
		_iPrevious=prev;
		_iNext=next;
		_iFirst=first;
		_iLast=last;
	}

	public byte[] getBytes() {
		byte[] data=new byte[10 + 20];
		Arrays.fill(data,(byte)0x40);
		encode(_iPrevious,data,10);
		encode(_iNext,data,14);
		encode(_iFirst,data,18);
		encode(_iLast,data,22);
		encode(_iID,data,26);
		finalizeCmd(data);
		return data;
	}	
	
}
