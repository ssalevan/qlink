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

public abstract class AbstractAddAccount extends AbstractAction {

	private String _sHandle;
	private String _sAccount;
	
	public AbstractAddAccount(String mnemonic, String account, String handle) {
		super(mnemonic);
		if(account==null || account.length()!=10)
			throw new IllegalArgumentException("Account length != 10");
		_sAccount=account;
		if(handle==null)
			throw new IllegalArgumentException("Handle is null");
		else if(handle.length()>10)
			throw new IllegalArgumentException("Handle length > 10");
		else if(handle.length()<1)
			throw new IllegalArgumentException("Handle length < 1");
		_sHandle=handle;
	}
	
	public byte[] getBytes() {
		byte[] b1=getBytes(_sAccount);
		byte[] b2=getBytes(_sHandle);
		byte[] data=new byte[10+10 + 10];
		Arrays.fill(data,(byte)0x20);
		System.arraycopy(b1,0,data,10,10);
		System.arraycopy(b2,0,data,20,b2.length);
		finalizeCmd(data);
		return data;
	}	
}
