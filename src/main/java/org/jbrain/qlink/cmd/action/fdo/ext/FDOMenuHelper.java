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
	Created on Oct 13, 2005
	
 */
package org.jbrain.qlink.cmd.action.fdo.ext;

import java.util.ArrayList;

import org.jbrain.qlink.cmd.action.Action;
import org.jbrain.qlink.cmd.action.fdo.ContinueWindow;
import org.jbrain.qlink.cmd.action.fdo.FDO;
import org.jbrain.qlink.cmd.action.fdo.FDOCommand;
import org.jbrain.qlink.cmd.action.fdo.FDOMenuTitle;
import org.jbrain.qlink.cmd.action.fdo.FDOResponse;
import org.jbrain.qlink.cmd.action.fdo.FDOWindowType;
import org.jbrain.qlink.cmd.action.fdo.NewWindow;


public class FDOMenuHelper {
	ArrayList _alItems=new ArrayList();
	
	public FDOMenuHelper() {
		//_alItems.add(new NewWindow(FDOWindowType.TYPE_MENU));
	}
	
	public void add(FDOMenuItem item) {
		_alItems.add(item.getTitle());
		_alItems.add(item.getResponse());
	}
	
	public void add(String title,FDOResponse response) {
		_alItems.add(new FDOMenuTitle(title));
		_alItems.add(response);
	}
	
	public Action[] getMenu() {
		ArrayList l=new ArrayList();
		FDO fdo=new FDO(new NewWindow(FDOWindowType.TYPE_MENU));
		for(int i=0;i<_alItems.size();i++) {
			if(!fdo.add((FDOCommand)_alItems.get(i))) {
				l.add(fdo);
				fdo=new FDO(new ContinueWindow());
				fdo.add((FDOCommand)_alItems.get(i));
			}
		}
		l.add(fdo);
		return (Action[])l.toArray(new Action[l.size()]);
		
	}

}
