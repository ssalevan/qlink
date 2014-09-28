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
	Created on Sep 30, 2005
	
 */
package org.jbrain.qlink.chat;

import java.util.HashMap;


public class ChatProfile {
	private HashMap _hmBoolean=new HashMap();
	private HashMap _hmString=new HashMap();
	private HashMap _hmNumeric=new HashMap();

	/**
	 * 
	 */
	public ChatProfile() {
		super();
	}
	
	public void setEntry(String entry,boolean b) {
		if(b) {
			_hmBoolean.put(entry,entry);
		} else {
			_hmBoolean.remove(entry);
		}
	}
	
	public void setEntry(String entry, int i) {
		_hmNumeric.put(entry,new Integer(i));
	}
	
	public void setEntry(String entry, String str) {
		if(str!=null && !str.equals(""))
			_hmString.put(entry,str);
		else
			_hmString.remove(entry);
	}
	
	public boolean isEnabled(String entry) {
		return _hmBoolean.containsKey(entry); 
	}
	
	//public int getIntPremission(String entry) {
		
	//}
	
	
	
	

}
