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
	Created on Oct 14, 2005
	
 */
package org.jbrain.qlink.cmd.action.fdo;


public abstract class AbstractFDOResponse extends AbstractFDOCommand implements FDOResponse {
	
	private String _sCmd;
	private int _iType;
	
	public AbstractFDOResponse(String cmd, int type) {
		_sCmd=cmd;
		_iType=type;
		if(cmd==null)
			throw new NullPointerException("Null command string");
		if(cmd.length()!=2)
			throw new IllegalArgumentException("Command string not 2 characters");
	}
	
	protected void finalizeResponse(byte[] data) {
		data[0]=(byte)FDOCommand.CMD_RESPONSE;
		data[1]=(byte)_iType;
		data[2]=(byte)(_sCmd.charAt(0)<<1  | ((_sCmd.charAt(1)&0x80)==0?0:1));
		data[3]=(byte)(_sCmd.charAt(1)<<2);
	}
	

}
