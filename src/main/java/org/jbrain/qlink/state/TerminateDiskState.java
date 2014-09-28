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
import org.jbrain.qlink.dialog.*;
import org.jbrain.qlink.user.AccountInfo;
import org.jbrain.qlink.user.AccountUpdateException;
import org.jbrain.qlink.user.QHandle;
import org.jbrain.qlink.user.UserManager;


public class TerminateDiskState extends AbstractState {
	private static Logger _log=Logger.getLogger(TerminateDiskState.class);
	private EntryDialog _termDiskDialog;

	private DialogCallBack _termDiskCallBack = new DialogCallBack() {
		/* (non-Javadoc)
		 * @see org.jbrain.qlink.state.DialogCallBack#handleResponse(org.jbrain.qlink.dialog.AbstractDialog, org.jbrain.qlink.cmd.action.Action)
		 */
		public boolean handleResponse(AbstractDialog d, Action a) throws IOException {
			int id;
		
			_log.debug("We received " + a.getName() + " from entry dialog");
			if (a instanceof ZA) {
				String handle = ((ZA) a).getResponse();
				handle=handle.trim();
				migrateAccounts((EntryDialog)d,new QHandle(handle));
			} else if(a instanceof DialogCancel) {
				_session.send(new InitDataSend(0,0,0));
				_session.send(new FileText("Terminate and Migrate Account action cancelled.",false));
				_session.send(new FileText("",false));
				_session.send(new FileText("          <PRESS F5 FOR MENU>",true));
				_session.setState(_intState);
			}
			return false;
		}
	};

	private QState _intState;
	//private int _iSlot;

	static {
		// define a static dialog for this.
	}
	
	public TerminateDiskState(QSession session) {
		super(session);
	}
	
	public void activate() throws IOException {
		_intState=_session.getState();
		super.activate();
		_log.debug("Defining TERMDISK dialog");
		_termDiskDialog=new EntryDialog("TERMDISK", EntryDialog.TYPE_MENU, EntryDialog.FORMAT_NONE);
		_termDiskDialog.addText("This action will migrate all of your user names to another disk and terminate the current disk. This action cannot be undone.  After this operation, the current disk will no longer be valid. You will need to enter the menu area on QLink to auto-update the other disk and finalize the process of migrating the user names.\n\nIf you are sure you want to proceed, please select a valid user name on the other Q-Link disk and enter it below.\n\n  Press F5 to cancel this operation.");
    	EntryDialogState state=new EntryDialogState(_session,_termDiskDialog,_termDiskCallBack);
    	state.activate();
	}

	/**
	 * @param dialog
	 * @param handle
	 */
	private void migrateAccounts(EntryDialog d, QHandle handle) throws IOException  {
        AccountInfo info;
        List newList;
        List oldList;
        boolean rc=false;
        
    	info=UserManager.getAccount(handle);
    	if(info!=null) {
        	// we found a userid
    		if(info.getUserID()==_session.getUserID()) {
    			_log.debug("Error: trying to migrate accounts to same disk");
    			_session
				.send(d.getErrorResponse("You cannot migrate accounts to the disk you are terminating.  Please select a user name from a different disk."));
    		} else {
	    		newList=UserManager.getAccountsforUser(info.getUserID());
	    		oldList=UserManager.getAccountsforUser(_session.getUserID());
	    		if(oldList.size() + newList.size() >5) {
	        		//error, to many accounts
	        		_log.debug("Error, too many accounts to migrate");
	    			_session
					.send(d.getErrorResponse("This disk contains " + oldList.size() + " accounts and '"
							+ handle
							+ "' has already created " + newList.size() + " accounts, which would exceed the user name maximum (5).  Please delete user names from one or both disks and try again."));
	        	} else {
	        		// migrate the accounts.
	        		_log.debug("Migrating " + oldList.size() + " accounts from '" + _session.getHandle() + " to '" + handle + "'");
	    			try {
	            		for(int i=0,size=oldList.size();i<size;i++) {
							((AccountInfo)oldList.get(i)).setUserID(info.getUserID());
							((AccountInfo)oldList.get(i)).setRefresh(true);
							((AccountInfo)oldList.get(i)).setPrimaryInd(false);
	            		}
	            		try {
							UserManager.deleteUser(_session.getUserID());
		        			_session
		    				.send(d.getSuccessResponse(oldList.size() + " user names migrated to user '"
		    						+ handle
		    						+ "' and current account closed.  The system will disconnect in 15 seconds."));
		        			_log.debug("Accounts migrated");
		    				_session.send(new InitDataSend(0,0,0));
		    				_session.send(new FileText("Accounts and user names successfully migrated to '" + handle + "'.  The system will now disconnect.",true));
		        			try {
		    					Thread.sleep(15000);
		    				} catch (InterruptedException e1) {
		    				}
		        			_session.send(new LostConnection());
		        			_session.terminate();
						} catch (Exception e2) {
				        	_log.error("Could not delete user id");
						}
					} catch (AccountUpdateException e) {
			        	_log.error("Could not update existing accounts",e);
					}
			        if(!rc) {
		    			_session
						.send(d.getErrorResponse("An error occurred while migrating the user names.  Please contact customer service."));
		    			_log.debug("Account migration error");
						_session.send(new InitDataSend(0,0,0));
						_session.send(new FileText("Accounts and user name migration was not successful..",true));
			        }
	        	}
    		}
        } else {
    		_log.debug("Error, cannot find user: '" + handle + "'");
			_session
			.send(d.getErrorResponse("We're sorry, but user name '" + handle + "' is not a valid user.  Please select another name."));
        }
	}

}
