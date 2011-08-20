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
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Map;

import org.apache.log4j.Logger;
import org.jbrain.qlink.*;
import org.jbrain.qlink.cmd.action.InitDataSend;

public class ShowStatsState extends AbstractMenuState {
	private static Logger _log=Logger.getLogger(ShowStatsState.class);

	public ShowStatsState(QSession session) {
		super(session);
	}
	
	public void activate() throws IOException {
		// do not activate this state, as we don't need to switch state.
		// just display the stats.
		Map m=_session.getServer().getAttributes();
		_lText=new ArrayList();
		Iterator i=m.keySet().iterator();
		while(i.hasNext()) {
			Object o=i.next();
			addLine(o.toString() + ": " + m.get(o));
		}
		_session.send(new InitDataSend(0,0,0));
		sendSingleLines();
		
	}

	/**
	 * @param string
	 */
	private void addLine(String string) {
		_lText.add(string);
	}

}
