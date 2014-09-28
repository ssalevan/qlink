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
import java.util.List;

import org.apache.log4j.Logger;
import org.jbrain.qlink.*;
import org.jbrain.qlink.cmd.action.*;
import org.jbrain.qlink.dialog.*;
import org.jbrain.qlink.user.AccountInfo;
import org.jbrain.qlink.user.AccountUpdateException;
import org.jbrain.qlink.user.QHandle;
import org.jbrain.qlink.user.UserManager;


public class DeleteUserNameState extends AbstractState {
	private static Logger _log=Logger.getLogger(DeleteUserNameState.class);
	private static YesNoDialog _accountDialog;
	private int _iSelectedID;
	private DialogCallBack _accountCallBack = new DialogCallBack() {

		public boolean handleResponse(AbstractDialog d, Action a) throws IOException {
			boolean rc=false;
			AccountInfo info;
			_log.debug("We received " + a.getName() + " from yes/no dialog");
			if(a instanceof DialogYes) {
				info=(AccountInfo)_lAccounts.get(_iSelectedID);
				
				_session.send(((YesNoDialog)d).getSuccessResponse("Removing user name '" + info.getHandle() + "'"));
				if(_log.isDebugEnabled())
					_log.debug("Removing user name '" + info.getHandle() + "' in slot: " + (_iSelectedID+1));
				_session.send(new DeleteAccountInSlot(_iSelectedID+1));
				_session.setState(DeleteUserNameState.this);
				rc=true;
			} else if(a instanceof DialogNo) {
				_session.send(new InitDataSend(0,0,0));
				_session.send(new FileText("User name removal cancelled.",false));
				_session.send(new FileText("",false));
				_session.send(new FileText("         <PRESS F5 TO CONTINUE>",true));
				_session.setState(DeleteUserNameState.this);
				rc=true;
			}
			return rc;
		}
	};

	private QState _intState;
	private List _lAccounts;
	private ArrayList _alDeleted=new ArrayList();

	static {
		// define a static dialog for this.
		_log.debug("Defining DELNAME dialog");
		_accountDialog=new YesNoDialog("DELNAME", YesNoDialog.TYPE_MENU);
		_accountDialog.addText("Are you sure you wish to remove this screen name? Select 'yes' or 'no'.");
	}
	
	public DeleteUserNameState(QSession session) {
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
		
		_lAccounts=UserManager.getSubAccountsforUser(_session.getUserID());
		for(int i=_lAccounts.size()-1;i>-1;i--) {
			info=(AccountInfo)_lAccounts.get(i);
			if(info.getHandle().equals(_session.getHandle())) {
				_lAccounts.remove(i);
			}
		}
    	if(_lAccounts.size()!=0) {
    		_session.send(new MenuItem(0,"Please select user name to remove",MenuItem.HEADING,MenuItem.COST_NO_CHARGE,false));
    		for(int i=0;i<_lAccounts.size();i++) {
    			info=(AccountInfo)_lAccounts.get(i);
        		// show screen name as menu item.
	    		_session.send(new MenuItem(i+DepartmentMenu.RESERVED_MENU_REF_ID_MIN,"    " + info.getHandle(),MenuItem.MENU_DATA,MenuItem.COST_NO_CHARGE,i+1==_lAccounts.size()));
    		}
    	} else {
    		_session.send(new MenuItem(0,"No removable users names",MenuItem.HEADING,MenuItem.COST_NO_CHARGE,true));
    	}
	}

	public boolean execute(Action a) throws IOException {
		QState state;
		boolean rc=false;
		AccountInfo info;
		
        // handle global stuff here
		if(a instanceof SelectMenuItem) {
			// subtract the block from the ID.
			_iSelectedID=((SelectMenuItem)a).getID()-DepartmentMenu.RESERVED_MENU_REF_ID_MIN;
			_log.debug("User selected item: " + _iSelectedID);
			if(_iSelectedID>-1 && _iSelectedID<_lAccounts.size()) {
				if(_alDeleted.contains(new Integer(_iSelectedID))) {
					_session.send(new InitDataSend(0,0,0));
					_session.send(new FileText("User name '" + ((AccountInfo)_lAccounts.get(_iSelectedID)).getHandle() +"' has already been removed.",false));
					_session.send(new FileText("         <PRESS F5 TO GO BACK>",true));
				} else {
					QHandle handle=((AccountInfo)_lAccounts.get(_iSelectedID)).getHandle();
					_log.debug("User selected screen name '" + handle + "' for removal");
					state=new YesNoMaybeDialogState(_session,_accountDialog,_accountCallBack);
					state.activate();
				}
					rc=true;
			}
		} else if(a instanceof DeleteAccountInSlotAck) {
			info=(AccountInfo)_lAccounts.get(_iSelectedID);
			_session.send(new InitDataSend(0,0,0));
			try {
				info.delete();
				_alDeleted.add(new Integer(_iSelectedID));
				_session.send(new FileText("User name '" + info.getHandle() +"' has been successfully removed.",false));
			} catch (AccountUpdateException e) {
				_session.send(new FileText("An error occured while removing user name '" + info.getHandle() +"'. Please try again later.",false));
			}
			_session.send(new FileText("         <PRESS F5 TO CONTINUE>",true));
			rc=true;
		} else if(a instanceof SuspendServiceAck) {
			rc=_intState.execute(a);
		} else if(a instanceof ResumeService) {
			rc=_intState.execute(a);
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
