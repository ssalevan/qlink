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

public class InitDownload extends AbstractAction {
	private int _iSize;
	private String _sType;

	
	public InitDownload(int size, String type) {
		super("F6");
		_iSize=size;
		_sType=type;
	}
	
	public byte[] getBytes() {
		byte[] b1=getBytes(Integer.toString((_iSize+253)/254));
		byte[] b2=getBytes(_sType);
		byte[] data;
		data=new byte[10+2 + b1.length + b2.length];
		System.arraycopy(b1,0,data,10,b1.length);
		data[10+b1.length]=(byte)0x90;
		System.arraycopy(b2,0,data,11+b1.length,b2.length);
		data[data.length-1]=(byte)0x90;
		finalizeCmd(data);
		return data;
	}
	

}
