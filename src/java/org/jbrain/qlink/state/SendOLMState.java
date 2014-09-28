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
	Created on Jul 23, 2005
	
 */
package org.jbrain.qlink.state;

import java.io.*;
import java.util.ArrayList;

import org.apache.log4j.Logger;
import org.jbrain.qlink.*;
import org.jbrain.qlink.cmd.action.*;
import org.jbrain.qlink.user.QHandle;
import org.jbrain.qlink.user.UserManager;

public class SendOLMState extends AbstractState {
	private static Logger _log=Logger.getLogger(SendOLMState.class);
	private QState _intState;
	private QHandle _recipient;
	private ArrayList _alOLMText = new ArrayList();

	
	public SendOLMState(QSession session, QHandle recipient) {
		super(session);
		_recipient=recipient;
}
	
	public void activate() throws IOException {
		_log.debug("User requested to send an OLM to " + _recipient);
		//if(_session.getHandle().toLowerCase().equals(_sRecipient)) {
			//_log.debug("User trying to send OLM to him/herself");
			//_session.send(new SendSYSOLM("You cannot send an OLM to yourself"));
		//} else
		if(UserManager.getAccount(_recipient)==null) {
			_log.debug("OLM Error: No such user");
			_session.send(new UserInvalid());
		} else if(!_session.getServer().isUserOnline(_recipient)) {
			_log.debug("OLM Error: User is not online");
			_session.send(new UserNotOnline());
		} else if(_session.getServer().canReceiveOLMs(_recipient)) {
			_intState=_session.getState();
			super.activate();
			_log.debug("User can receive OLMs");
			_session.send(new SendOLMAck(_session.getHandle().toString()));
		} else {
			_log.debug("OLM Error: User cannot receive OLMs");
			_session.send(new SendOLMNAck());
		}
	}
	

	public boolean execute(Action a) throws IOException {
		boolean rc=false;
		if(a instanceof OM) {
			// save first/next line of olm text;
			String text=((OM)a).getData();
			_log.debug("OLM Text: " + text);
			_alOLMText.add(text);
			rc=true;
		} else if(a instanceof OE) {
			// save last line of OLM text
			String text=((OE)a).getData();
			_log.debug("OLM End: " + text);
			_alOLMText.add(text);
			_alOLMText.add("End of Message - Press F5 to cancel");
			// now, send to other user.
			_session.getServer().sendOLM(_recipient,(String[])_alOLMText.toArray(new String[0]));
			// restore state
			_session.setState(_intState);
			rc=true;
		} else if(a instanceof OLMCancelled) {
			// email is cancelled
			_log.debug("Cancelled OLM to " + _recipient);
			_session.setState(_intState);
		} else {
			rc=_intState.execute(a);
		}
		return rc;
	}


	public void terminate() {
		_intState.terminate();
	}
}
