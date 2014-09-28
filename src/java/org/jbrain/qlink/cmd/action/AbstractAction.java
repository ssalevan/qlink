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
	Created on Jul 18, 2005
	
 */
package org.jbrain.qlink.cmd.action;

import java.io.UnsupportedEncodingException;

import org.jbrain.qlink.cmd.AbstractCommand;
import org.jbrain.qlink.cmd.CRCException;

// two bytes in payload are version/release
public abstract class AbstractAction extends AbstractCommand implements Action {
	private String _sAction;

	public static final byte CMD_ACTION=0x20;

	private static final String charSet="ISO-8859-1";

	public AbstractAction(byte[] data, int start, int len) throws CRCException {
		super(data, start, len);
		_sAction=getString(data,start+8,2);
	}
	
	/**
	 * @param action_login
	 * @param string
	 */
	public AbstractAction(String action) {
		super(CMD_ACTION);
		_sAction=action;
	}

	/**
	 * @param action
	 * @param str
	 * @return
	 */
	protected String getString(byte[] data, int i, int j) {
		try {
			return new String(data,i,j,charSet);
		} catch (UnsupportedEncodingException e) {
		}
		return new String(data,i,j);
	}
	
	protected byte[] getBytes(String str) {
		try {
			return str.getBytes(charSet);
		} catch (UnsupportedEncodingException e) {
		}
		return str.getBytes();
	}

	public String getAction() {
		return _sAction;
	}
	
	protected void finalizeCmd(byte[] data) {
		System.arraycopy(getBytes(_sAction),0,data,8,2);
		super.finalizeCmd(data);
	}
	
	public byte[] getBytes() {
		byte[] data=new byte[10];
		finalizeCmd(data);
		return data;
	}
	
	public String getName() {
		// cheesy, but it should work.
		return this.getClass().getConstructors()[0].getName() + "(" + _sAction + ")";
	}
	
}
