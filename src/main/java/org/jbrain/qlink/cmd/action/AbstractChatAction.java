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

import org.jbrain.qlink.cmd.CRCException;

public class AbstractChatAction extends AbstractAction {

	protected String _sData;
	protected int _iSeat;
	
	public AbstractChatAction(String mnemonic, int seat, String data) {
		super(mnemonic);
		_iSeat=seat;
		_sData=data;
	}
	
	public AbstractChatAction(byte[] data, int start, int len) throws CRCException {
		super(data,start,len);
		_iSeat=data[start+10]-1;
		if(_iSeat>=12)
			_iSeat--;
		
		_sData=getString(data,start+11,len-11);
	}
	
	public byte[] getBytes() {
		byte[] b=getBytes(_sData);
		byte[] data=new byte[10+1 + b.length];
		data[10]=(byte)(_iSeat+1);
		if(data[10]>=13)
			data[10]++;
		System.arraycopy(b,0,data,11,b.length);
		finalizeCmd(data);
		return data;
	}	
}
