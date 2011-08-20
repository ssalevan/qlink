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


public class EntryDialogState extends AbstractDialogState {
	private static Logger _log=Logger.getLogger(EntryDialogState.class);
	public static final int PHASE_TERMINATE = 4;
	
	public EntryDialogState(QSession session, EntryDialog dialog, DialogCallBack callback) {
		super(session,dialog,callback);
	}
	
	public boolean execute(Action a) throws IOException {
		QState state;
		boolean rc=false;
		
        // handle global stuff here
        switch(getPhase()) {
        	case PHASE_RESPONSE:
        		if(a instanceof ZA) {
        			rc=true;
        			_log.debug("Dispatching response to callback");
        			if(_callback.handleResponse(_dialog,a)) {
        				if(_dialog.getDialogType()==AbstractDialog.TYPE_MENU) {
	        				_log.info("PHASE: closing dialog");
        				} else {
	        				_log.info("PHASE: waiting to close dialog");
        				}
        				setPhase(PHASE_TERMINATE);
        				rc=true;
        			}
        		}
        		break;
        	case PHASE_TERMINATE:
        		if(a instanceof D2) {
        			_log.debug("Dispatching dialog close to callback");
        			_callback.handleResponse(_dialog,a);
    				_log.info("closing dialog");
        			rc=true;
        		}
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
