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


public class ZA extends AbstractAction {

	public static final String MNEMONIC = "ZA";
	private String _sDialog;
	private String _sResponse;
	/**
	 * @param data
	 * @param start
	 * @param len
	 * @throws CRCException
	 */
	public ZA(byte[] data, int start, int len) throws CRCException {
		super(data, start, len);
		_sDialog=getString(data,start+10,10);
		// need to clip @@@ chars
		_sResponse=getString(data,start+21,len-21);
		
	}
	
	public ZA() {
		super(MNEMONIC);
	}
	
	public String getResponse() {
		return _sResponse;
	}
}
