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

import org.jbrain.qlink.cmd.CRCException;


public class Abstract2StringAction extends AbstractAction {
	protected String _sData1;
	protected String _sData2;
	
	public Abstract2StringAction(byte[] data, int start, int len) throws CRCException {
		super(data, start, len);
		// TODO we need to implement this better
		_sData1="";
		_sData2=getString(data,start+10,len-10);
	}

	public Abstract2StringAction(String mnemonic, String str1, String str2) {
		super(mnemonic);
		_sData1=str1;
		_sData2=str2;
	}
	
	public byte[] getBytes() {
		byte[] b1=getBytes(_sData1);
		byte[] b2=getBytes(_sData2);
		byte[] data=new byte[11 + b1.length + b2.length];
		System.arraycopy(b1,0,data,10,b1.length);
		data[10+b1.length]=(byte)0x90;
		System.arraycopy(b2,0,data,11+b1.length,b2.length);
		finalizeCmd(data);
		return data;
	}	

}
