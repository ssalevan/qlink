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
	Created on Jul 23, 2005
	
 */
package org.jbrain.qlink.cmd.action;

import org.jbrain.qlink.cmd.CRCException;


public class ChangeAccessCode extends AbstractAction implements Action {
	public static final String ACTION_CHANGEACCESSCODE = "D3";
	private String _sCode;

	/**
	 * @param data
	 * @param start
	 * @param len
	 * @throws CRCException
	 */
	public ChangeAccessCode(String code) {
		super(ACTION_CHANGEACCESSCODE);
		if(code.length()!=4)
			throw new IllegalArgumentException("Code length != 4");
		_sCode=code;		
	}

	public byte[] getBytes() {
		byte[] b=getBytes(_sCode);
		byte[] data=new byte[10+4];
		System.arraycopy(b,0,data,10,4);
		finalizeCmd(data);
		return data;
	}

}
