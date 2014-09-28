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

public class AnonChatSend extends AbstractAction {
	private String _sText;
	private String _sHandle;

	public AnonChatSend(String handle, String text) {
		super("AB");
		_sHandle=handle;
		if(_sHandle.length()>10)
			_sHandle=handle.substring(0,10);
		_sText=text;
	}
	
	public byte[] getBytes() {
		byte[] b1=getBytes(_sHandle);
		byte[] b2=getBytes(_sText);
		byte[] data=new byte[11 + 10 + b2.length];
		// fill with spaces.
		Arrays.fill(data,(byte)0x20);
		System.arraycopy(b1,0,data,10,b1.length);
		data[20]=(byte)0x90;
		System.arraycopy(b2,0,data,21,b2.length);
		finalizeCmd(data);
		return data;
	}	
	
}
