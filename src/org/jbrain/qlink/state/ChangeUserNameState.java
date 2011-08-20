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
import java.util.List;

import org.apache.log4j.Logger;
import org.jbrain.qlink.*;
import org.jbrain.qlink.cmd.action.*;
import org.jbrain.qlink.user.AccountInfo;
import org.jbrain.qlink.user.UserManager;

public class ChangeUserNameState extends AbstractState {
	private static Logger _log=Logger.getLogger(ChangeUserNameState.class);
	public static final int PHASE_INITIAL=1;
	private List _lAccounts;
	private QState _intState;

	public ChangeUserNameState(QSession session) {
		super(session);
	}
	
	public void activate() throws IOException {
		_intState=_session.getState();
		super.activate();
		// show list.
		showAccountList();
	}

	/**
	 * @return
	 */
	private void showAccountList() throws IOException {
		AccountInfo info;
		
		_lAccounts=UserManager.getAccountsforUser(_session.getUserID());
		for(int i=_lAccounts.size()-1;i>-1;i--) {
			info=(AccountInfo)_lAccounts.get(i);
			if(info.getHandle().equals(_session.getHandle())) {
				_lAccounts.remove(i);
			}
		}
    	if(_lAccounts.size()!=0) {
    		_session.send(new MenuItem(0,"Please select user name to use",MenuItem.HEADING,MenuItem.COST_NO_CHARGE,false));
    		for(int i=0;i<_lAccounts.size();i++) {
    			info=(AccountInfo)_lAccounts.get(i);
        		// show screen name as menu item.
	    		_session.send(new MenuItem(i+DepartmentMenu.RESERVED_MENU_REF_ID_MIN,"    " + info.getHandle(),MenuItem.MENU_DATA,MenuItem.COST_NO_CHARGE,i+1==_lAccounts.size()));
    		}
    	} else {
    		_session.send(new MenuItem(0,"No user names to choose",MenuItem.HEADING,MenuItem.COST_NO_CHARGE,true));
    	}
	}

	public boolean execute(Action a) throws IOException {
		QState state;
		boolean rc=false;
		int id;
		AccountInfo info;
		
        // handle global stuff here
		if(a instanceof SelectMenuItem) {
			id=((SelectMenuItem)a).getID()-DepartmentMenu.RESERVED_MENU_REF_ID_MIN;
			_log.debug("User selected item: " + id);
			if(id>-1 && id<_lAccounts.size()) {
				info=((AccountInfo)_lAccounts.get(id));
				_log.debug("User selected screen name '" + info.getHandle() + "'.");
				_session.setAccountInfo(info);
				_session.send(new InitDataSend(0,0,0));
				_session.send(new FileText("User name changed to '" + info.getHandle() +"'.",false));
				_session.send(new FileText("",false));
				_session.send(new FileText("          <PRESS F5 FOR MENU>",true));
				rc=true;
			}
		}
        if(!rc) {
			_log.debug("User backed up in tree and selected something else");
			// they have backed up, restore and send to previous state
			_session.setState(_intState);
			rc= _intState.execute(a);
        }
        return rc;
	}
}
