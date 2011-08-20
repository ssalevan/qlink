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


public class DownloadFile extends AbstractMenuItem {
	private String _sName="";
	private String _sFileType="prg";

	public static final String MNEMONIC = "K4";
	/**
	 * @param data
	 * @param start
	 * @param len
	 * @throws CRCException
	 */
	public DownloadFile(byte[] data, int start, int len) throws CRCException {
		super(data, start, len);
		_iID=decode(data,start+10);
		for(int i=15;i<len;i++) {
			if(data[start+i]==(byte)0x90) {
				_sName=getString(data,start+15,i-16);
				i++;
				int j=i;
				for(;i<len;i++) {
					if(data[start+i]==(byte)0x90) {
						_sFileType=getString(data,start+j,i-j);
						break;
					}
				}
				break;
			}
		}
	}

	public int getID() {
		return _iID;
	}
}
