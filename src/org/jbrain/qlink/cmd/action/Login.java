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


public class Login extends AbstractAction {

	public static final String MNEMONIC = "DD";
	private String _sAccount;
	private String _sCode;

	/**
	 * @param data
	 * @param start
	 * @param len
	 * @throws CRCException
	 */
	public Login(byte[] data, int start, int len) throws CRCException {
		super(data, start, len);
		_sAccount=getString(data,start+10,10);
		_sCode=getString(data,start+20,4);
	}
	
	public String getAccount() {
		return _sAccount;
	}
	
	public String getCode() {
		return _sCode;
	}
	public Login(String account, String code) {
		super(MNEMONIC);
		_sAccount=account;
		_sCode=code;
	}
	
	public byte[] getBytes() {
		// TODO we ned to make sure account and code are 10 and 4
		byte[] b1=getBytes(_sAccount);
		byte[] b2=getBytes(_sCode);
		byte[] data=new byte[10+14];
		System.arraycopy(b1,0,data,10,10);
		System.arraycopy(b2,0,data,20,4);
		finalizeCmd(data);
		return data;
		
	}

}
