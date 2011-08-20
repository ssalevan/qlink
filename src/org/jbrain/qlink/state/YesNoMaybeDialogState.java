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

import java.io.IOException;

import org.apache.log4j.Logger;
import org.jbrain.qlink.*;
import org.jbrain.qlink.cmd.action.*;
import org.jbrain.qlink.dialog.*;


public class YesNoMaybeDialogState extends AbstractDialogState {
	private static Logger _log=Logger.getLogger(YesNoMaybeDialogState.class);
	
	public YesNoMaybeDialogState(QSession session, YesNoDialog dialog, DialogCallBack callback) {
		super(session,dialog,callback);
	}
	
	public boolean execute(Action a) throws IOException {
		QState state;
		boolean rc=false;
		
        // handle global stuff here
        switch(getPhase()) {
        	case PHASE_RESPONSE:
        		//if(_dialog.getDialogType()==AbstractDialog.TYPE_CHAT)
        		//	_session.send(new ChatDialogClose());
    			// don't set rc to true, and it will get propogated
        		break;
        }
        if(!rc)
        	rc=super.execute(a);
        return rc;
	}
	
	/**
	 * @param handle
	 */
}
