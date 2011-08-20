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
	Created on Jul 29, 2005
	
 */
package org.jbrain.qlink.cmd.action;


public class MenuDialogTextRequest extends AbstractDialogAction {

	/**
	 * @param mnemonic
	 * @param name
	 * @param text
	 */
	public MenuDialogTextRequest(String name, String text) {
		super("ZQ",name,text);
	}
	public byte[] getBytes() {
		int i=10;
		byte[] b1=getBytes(_sName);
		byte[] b2=getBytes("ello");
		byte[] b3=getBytes(_sText);
		byte[] data=new byte[10+2+4+4+1 + b1.length + b3.length];
		System.arraycopy(b1,0,data,i,b1.length);
		i+=b1.length;
		data[i++]=(byte)0x90;
		System.arraycopy(b2,0,data,i,4);
		i+=b2.length;
		data[i++]=(byte)0x90;
		System.arraycopy(b2,0,data,i,4);
		i+=b2.length;
		data[i++]=(byte)0x90;
		System.arraycopy(b3,0,data,i,b3.length);
		finalizeCmd(data);
		return data;
	}	
	
}
