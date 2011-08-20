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
package org.jbrain.qlink.cmd;

// two bytes in payload are version/release
public class Reset extends AbstractCommand {
	private byte _bVersion;
	private byte _bRelease;

	public static final byte CMD_RESET=0x23;
	private boolean _bSuper=false;

	public Reset(byte[] data, int start, int len) throws CRCException {
		super(data,start,len);
		if(data[start+1]==0 && data[start+2] ==0 && data[start+3]==0 && data[start+4] ==0) {
			// special Reset;
			_bSuper=true;
		} else if(_iReportedCRC!=_iCalculatedCRC) {
			throw new CRCException(_iReportedCRC + "!=" + _iCalculatedCRC);
		}
		_bVersion=data[start+9];
		_bRelease=data[start+8];
	}
	
	public Reset() {
		super(CMD_RESET);
		_bVersion=9;
		_bRelease=5;
	}
	
	public int getVersion() {
		return _bVersion;
	}

	public int getRelease() {
		return _bRelease;
	}
	
	public byte[] getBytes() {
		byte[] data=new byte[10];
		data[9]=_bVersion;
		data[8]=_bRelease;
		finalizeCmd(data);
		return data;
	}

	/**
	 * @return
	 */
	public boolean isSuperQ() {
		return _bSuper;
	}
}
