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

import java.text.*;
import java.util.*;


public class LogoffAck extends AbstractAction {
	private Date _start;
	private Date _end;

	public LogoffAck(Date start, Date end) {
		super("LO");
		_start=start;
		_end=end;
	}

	public byte[] getBytes() {
		DateFormat df = new SimpleDateFormat("HH:mm:ss");
		String start=df.format(_start);
		String end=df.format(_end);
		byte[] b1=getBytes(start);
		byte[] b2=getBytes(end);
		int i=(int)(_end.getTime()-_start.getTime())/1000;
		String tz=new SimpleDateFormat("z").format(_start);
		byte[] b3=getBytes(tz);
		byte[] data=new byte[10 + 27];
		System.arraycopy(b1,0,data,10,8);
		System.arraycopy(b2,0,data,18,8);
		int h=i/(60*60);
		int m=(i-(h*60*60))/60;
		int s=i-((h*60*60)+(m*60));
		data[26]=(byte)(h/10+'0');
		data[27]=(byte)(h%10+'0');
		data[28]=':';
		data[29]=(byte)(m/10+'0');
		data[30]=(byte)(m%10+'0');
		data[31]=':';
		data[32]=(byte)(s/10+'0');
		data[33]=(byte)(s%10+'0');
		System.arraycopy(b3,0,data,34,3);
		finalizeCmd(data);
		return data;
	}	
	
}
