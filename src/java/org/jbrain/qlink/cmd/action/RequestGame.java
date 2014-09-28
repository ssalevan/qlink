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


public class RequestGame extends AbstractAction {
	public static final String MNEMONIC = "GI";
	private String _sName="";
	private boolean _bSystemPickOrder;
	private String _sGameType="";
	private byte _iID;
	/**
	 * @param data
	 * @param start
	 * @param len
	 * @throws CRCException
	 */
	public RequestGame(byte[] data, int start, int len) throws CRCException {
		super(data, start, len);
		_bSystemPickOrder=(data[start+10]==0x31);
		_iID=data[start+11];
		for(int i=12;i<len;i++) {
			if(data[start+i]==(byte)0x90) {
				// we have name
				_sName=getString(data,start+12,i-12);
				i++;
				_sGameType=getString(data,i,len-i);
				break;
			}
		}
	}
	/**
	 * @return
	 */
	public String getTitle() {
		return _sName;
	}
	/**
	 * @return
	 */
	public String getType() {
		return _sGameType;
	}
	/**
	 * @return
	 */
	public boolean doesSystemPickOrder() {
		return _bSystemPickOrder;
	}
	/**
	 * @return
	 */
	public int getID() {
		return _iID; 
	}
}
