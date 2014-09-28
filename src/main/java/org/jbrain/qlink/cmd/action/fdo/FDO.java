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
	Created on Oct 8, 2005
	
 */
package org.jbrain.qlink.cmd.action.fdo;

import java.util.ArrayList;

import org.jbrain.qlink.cmd.action.AbstractAction;

public class FDO extends AbstractAction {
	private ArrayList _alCmds=new ArrayList();
	private int _iLen=10;
	private boolean _bContinue=false;

	/**
	 * @param action
	 */
	public FDO(FDOWindowType type) {
		super("fD");
		add(type);
	}
	
	public boolean add(FDOCommand cmd) {
		int len=cmd.size();
		if(_iLen+len>126) {
			_bContinue=true;
			return false;
		}
		_alCmds.add(cmd);
		_iLen+=len;
		return true;
	}
	
//	0x15 0x0e 0x01 0x11 0x00 Menu item text 0x00 0x05 0x01 0x96 0xc6 serial number packed 0x11 0x00 Menu item text 0x00 0x05 0x01 0x96 0xc6 serial number packed 0x09
	
	public byte[] getBytes() {
		FDOCommand cmd;
		byte[] b;
		
		byte[] data=new byte[_iLen+1];
		
		int i=10;
		
		for(int pos=0;pos<_alCmds.size();pos++) {
			cmd=(FDOCommand)_alCmds.get(pos);
			b=cmd.getBytes();
			System.arraycopy(b,0,data,i,b.length);
			i+=b.length;
		}
		if(_bContinue)
			data[i]=(byte)FDOCommand.CMD_PAUSE_PARSING;
		else
			data[i]=(byte)FDOCommand.CMD_SHOW;
		finalizeCmd(data);
		return data;
	}	
	
}
