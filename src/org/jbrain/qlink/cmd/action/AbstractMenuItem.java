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
	Created on Jul 25, 2005
	
 */
package org.jbrain.qlink.cmd.action;

import org.jbrain.qlink.cmd.CRCException;


public class AbstractMenuItem extends AbstractAction {
	protected int _iID;

	public AbstractMenuItem(String mnemonic, int id) {
		super(mnemonic);
		_iID=id;
	}
	
	/**
	 * @param data
	 * @param start
	 * @param len
	 */
	public AbstractMenuItem(byte[] data, int start, int len) throws CRCException {
		super(data,start,len);
	}

	protected void encode(int i,byte[] data,int pos) {
		// strip hi byte
		i&=0xffffff;
		data[pos++]=(byte)(((i>>18)&0xff)|0x40);
		data[pos++]=(byte)(((i>>12)&0xff)|0x40);
		data[pos++]=(byte)(((i>>6)&0xff)|0x40);
		data[pos++]=(byte)(((i)&0xff)|0x40);
	}
	
	protected int decode(byte[] data,int pos) {
		int i=(data[pos++]&0x3f)<<18;
		i|=(data[pos++]&0x3f)<<12;
		i|=(data[pos++]&0x3f)<<6;
		i|=(data[pos++]&0x3f);
		return i;
	}
}
