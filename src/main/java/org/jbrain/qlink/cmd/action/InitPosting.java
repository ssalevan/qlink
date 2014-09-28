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

import java.text.SimpleDateFormat;
import java.util.Date;

public class InitPosting extends AbstractAction {
	String _sHandle;

	public InitPosting(String handle) {
		super("KH");
		_sHandle=handle;
	}

	public byte[] getBytes() {
		SimpleDateFormat sdf=new SimpleDateFormat("MM/dd");
		byte[] b1=getBytes(sdf.format(new Date()));
		byte[] b2=getBytes(_sHandle);
		byte[] data=new byte[12 + b1.length + b2.length];
		System.arraycopy(b1,0,data,10,b1.length);
		data[10+b1.length]=(byte)0x90;
		System.arraycopy(b2,0,data,11+b1.length,b2.length);
		data[data.length-1]=(byte)0x90;
		finalizeCmd(data);
		return data;
	}	
}
