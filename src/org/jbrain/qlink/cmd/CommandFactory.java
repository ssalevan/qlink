/*
	Copyright Jim Brain and Brain Innovations, 2005.

	This file is part of QLinkServer.

	QLink is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	QLink is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with QLink; if not, write to the Free Software
	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

	@author Jim Brain
	Created on Jul 18, 2005
	
 */
package org.jbrain.qlink.cmd;
import org.jbrain.qlink.cmd.action.*;

public class CommandFactory {

	/**
	 * 
	 * @uml.property name="_factory"
	 * @uml.associationEnd multiplicity="(1 1)"
	 */
	private ActionFactory _factory;

	public CommandFactory() {
		_factory=new ActionFactory();
	}

	public Command newInstance(byte[] b, int start, int len) throws CRCException {
		if(len<8) {
			return null;
		}
		if(b[start]!=AbstractCommand.CMD_START){
			return null;
		}
		switch (b[start+7]&0xff) {
			case Ping.CMD_PING:
				return new Ping(b,start,len);
			case Reset.CMD_RESET:
				return new Reset(b,start,len);
			case ResetAck.CMD_RESETACK:
				return new ResetAck(b,start,len);
			case AbstractAction.CMD_ACTION:
				return _factory.newInstance(b,start,len); 
			case WindowFull.CMD_WINDOWFULL:
				return new WindowFull(b,start,len);
			case SequenceError.CMD:
				return new SequenceError(b,start,len);
			default:
				return null;
		}
		
	}
}
