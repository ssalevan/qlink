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
package org.jbrain.qlink.user;


public class QHandle {
	private String _sHandle;
	private String _sKey;

	public QHandle(String handle) {
		if(handle==null || handle.equals("")) {
			_sHandle="";
			_sKey="";
		} else {
			// make sure first char is uppercase
			_sHandle=handle.substring(0,1).toUpperCase() + handle.substring(1);
			_sKey=handle.replaceAll(" ","").toLowerCase().trim();
		}
	}
	
	public boolean equals(Object o) {
		if(this==o)
			return true;
		if(o==null && _sKey.equals(""))
			return true;
		if(o instanceof QHandle && ((QHandle)o)._sKey.equals(_sKey)) {
			return true;
		} else if(o instanceof String) {
			return equals(new QHandle((String)o));
		}
		return false;
	}
	
	public String toString() {
		return _sHandle;
	}

	/**
	 * @return
	 */
	public String getKey() {
		return _sKey;
	}

}
