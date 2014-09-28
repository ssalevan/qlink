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
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;

import org.apache.log4j.Logger;
import org.jbrain.qlink.*;
import org.jbrain.qlink.cmd.action.*;
import org.jbrain.qlink.db.DBUtils;
import org.jbrain.qlink.dialog.*;
import org.jbrain.qlink.user.AccountInfo;
import org.jbrain.qlink.user.QHandle;


public class Authentication extends AbstractAccountState {
	private static Logger _log=Logger.getLogger(Authentication.class);
	public static final int PHASE_LOGIN=1;
	public static final int PHASE_SETUPNAME=2;
	public static final int PHASE_DIALOGCLOSING=3;
	public static final int PHASE_UPDATECODE=4;
	private static EntryDialog _newUserDialog;
	private String _sAccount; 

	static {
		// define a static dialog for this.
		_log.debug("Defining NEWUSER dialog");
		_newUserDialog=new EntryDialog("NEWUSER", EntryDialog.TYPE_LOGIN, EntryDialog.FORMAT_NONE);
		_newUserDialog.addText("           WELCOME TO Q-LINK!\n\nBefore we begin, please choose a user name and type it in.  This name will be used to identify you in the system.  Your screen name can be up to 10 characters in length.");
	}

	private DialogCallBack _newUserCallBack = new DialogCallBack() {
		/* (non-Javadoc)
		 * @see org.jbrain.qlink.state.DialogCallBack#handleResponse(org.jbrain.qlink.dialog.AbstractDialog, org.jbrain.qlink.cmd.action.Action)
		 */
		public boolean handleResponse(AbstractDialog d, Action a) throws IOException {
			String text;
			QHandle handle;
			
			_log.debug("We received " + a.getName() + " from entry dialog");
			if (a instanceof ZA) {
				text = ((ZA) a).getResponse();
				text=text.trim();
				if(validateNewAccount((EntryDialog)d,text)) {
					// passed the checks, add account.
					// uppercase first char
					handle=new QHandle(text);
					if (addPrimaryAccount(handle,_sAccount)) {
		        		DecimalFormat format=new DecimalFormat("0000000000");
		        		_sAccount=format.format(_session.getAccountID());
						_session
							.send(((EntryDialog) d)
								.getSuccessResponse("Congratulations, "
									+ handle
									+ "!\n\nYou are now registered with QuantumLink RELOADED, the Commodore Community Gathering Place.  We hope you enjoy your visit (or re-visit) to Q-LINK.\n\n"));
						return true;
					} else {
						_session
							.send(((EntryDialog) d)
								.getErrorResponse("We're sorry, but '"
									+ handle
									+ "' is already in use.  Please select another name."));
					}
				}
				setPhase(PHASE_DIALOGCLOSING);
				// TODO if we terminate while in this state, rollback users and accounts tables
			} else if (a instanceof D2) {
				_session.send(new AddPrimaryAccount(_sAccount, _session.getHandle().toString()));
				_session.send(new ClearExtraAccounts());
				_session.send(new ChangeAccessCode(_sSecurityCode));
				_log.info("PHASE: Updating access code on disk");
				_session.setState(Authentication.this);
				setPhase(PHASE_UPDATECODE);
				_bInfoNeeded=true;
				return true;
			}
			return false;
		}
	};
	private boolean _bInfoNeeded=false;

	public Authentication(QSession session) {
		super(session,PHASE_LOGIN);
	}

	public boolean execute(Action a) throws IOException {
		QState state;
		boolean rc=false;
		
        // handle global stuff here
        switch(getPhase()) {
        	case PHASE_LOGIN:
        		if(a instanceof Login) {
        			_sAccount=((Login)a).getAccount();
        			_sSecurityCode=((Login)a).getCode();
        			if(_log.isInfoEnabled()) {
        				_log.info("Account: " + _sAccount + " presents access code: '" + _sSecurityCode + "' for validation");
        			}
        			validateUser();
        			rc=true;
        		}
        		break;
        	case PHASE_UPDATECODE:
        		if(a instanceof UpdatedCode) {
        			updateCode(_sSecurityCode);
        			if(_bInfoNeeded) {
	        			state=new GetUserInfoState(_session);
        			} else {
	        			state=new MainMenu(_session);
        			}
        			state.activate();
        			rc=true;
        		}
        		break;
        }
        if(!rc)
        	rc=super.execute(a);
        return rc;
	}
	
	protected void validateUser() throws IOException {
        Connection conn=null;
        Statement stmt = null;
        ResultSet rs = null;
        QHandle handle;
        long id=-1;
        long iUserID=-1;
        
        try {
        	try {
        		id=Long.parseLong(_sAccount);
            	conn=DBUtils.getConnection();
                stmt = conn.createStatement();
                rs=stmt.executeQuery("SELECT accounts.staff_ind, users.name, users.user_id,accounts.primary_ind, users.access_code,users.active,accounts.active,accounts.handle,accounts.refresh from accounts,users WHERE accounts.user_id=users.user_id AND accounts.account_id=" + id);
        	} catch (NumberFormatException e) {
            	_log.info("Account code '" + _sAccount + "' not a number, new user");
        	}
            if(id>-1 && rs!= null && rs.next()) {
            	// possible valid account...
            	if(rs.getString("users.access_code").equals(_sSecurityCode)) {
	            	// valid account
	            	// is account valid?
	            	if(rs.getString("accounts.active").equals("Y") && rs.getString("users.active").equals("Y")) {
	            		handle=new QHandle(rs.getString("accounts.handle"));
	            		if(!_session.getServer().isUserOnline(handle)) {
		            		// active account
		                	iUserID=rs.getInt("users.user_id");
		                	// little add for getting preexisting users information.
		                	String name=rs.getString("users.name");
		                	_bInfoNeeded=name==null || name.equals("");
		                	_session.setAccountInfo(new AccountInfo((int)iUserID,(int)id,rs.getString("accounts.primary_ind").equals("Y"),handle.toString(),false,rs.getString("accounts.staff_ind").equalsIgnoreCase("y")));
		                	
		                    // temp to clean up acounts:
		                    if(_session.isPrimaryAccount() && rs.getString("accounts.refresh").equalsIgnoreCase("Y")) {
		                    	_log.debug("Fixing account: '" + id + "'");
			    				_session.send(new AddPrimaryAccount(_sAccount, handle.toString()));
			    				_session.send(new ClearExtraAccounts());
			                    stmt.execute("update accounts SET refresh='N' where account_id=" + id);
			                    stmt.execute("update accounts SET refresh='Y' where primary_ind='N' and user_id=" + iUserID);
		                    }
		                	// update access time information in DB
		                	// if these fail, we're not too worried
		                    stmt.execute("UPDATE users set last_access=now() WHERE user_id=" + iUserID);
		                    stmt.execute("UPDATE accounts set last_access=now() WHERE account_id=" + id);
		                    
		                    // get new code
		                    // TODO enable this at appropriate time.
		                    //_sSecurityCode=getNewCode();
	
		                	// update access code.
		    	    		_session.send(new ChangeAccessCode(_sSecurityCode));
		    				_log.info("PHASE: Updating access code on disk");
		    	    		setPhase(PHASE_UPDATECODE);
	            		} else {
	            			// account is already logged in.
	            			_log.info(handle + " is already logged in");
	            			_session.send(new DuplicateLogin());
	            		}
	            	} else {
	            		// deal with inactive account....
	            		_log.info("Account '" + _sAccount +"' is inactive");
            			_session.send(new InvalidatedAccount());
	            	}
            	} else {
            		// good account, bad code...
            		_log.info("Account '" + _sAccount +"' failed access code check");
            		_session.send(new InvalidAccount());
            	}
            } else {
            	// if id>-1, then we should really send back DK command.
            	// new user.
            	_log.info("Account not found.  New user");
            	_log.info("Starting new user screen name dialog");
				setPhase(PHASE_SETUPNAME);
            	_session.send(new ClearScreen());
            	EntryDialogState state=new EntryDialogState(_session,_newUserDialog,_newUserCallBack);
            	state.activate();
            }
        } catch (SQLException e) {
        	_log.error("SQL Exception",e);
        	// big time error, send back error string and close connection
        } finally {
        	DBUtils.close(rs);
        	DBUtils.close(stmt);
        	DBUtils.close(conn);
        }
	}
}
