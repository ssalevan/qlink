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
import java.util.*;

import org.apache.log4j.Logger;
import org.jbrain.qlink.*;
import org.jbrain.qlink.db.DBUtils;
import org.jbrain.qlink.dialog.*;
import org.jbrain.qlink.user.AccountInfo;
import org.jbrain.qlink.user.QHandle;
import org.jbrain.qlink.user.UserManager;


public class AbstractAccountState extends AbstractPhaseState {
	private static Logger _log=Logger.getLogger(AbstractAccountState.class);
	private static Random _random = new Random();
	protected String _sSecurityCode;

	public AbstractAccountState(QSession session, int phase) {
		super(session,phase);
	}

	protected void updateCode(String code) throws IOException {
        Connection conn=null;
        Statement stmt = null;
        ResultSet rs = null;
        int id;
        
        if(_log.isDebugEnabled())
        	_log.debug("Updating account '" + _session.getAccountID() + "' access code to: " + code);
        try {
        	conn=DBUtils.getConnection();
            stmt = conn.createStatement();
            if(stmt.execute("UPDATE users set access_code='" + code + "' WHERE user_id=" + _session.getUserID())) {
    			_log.info("PHASE: Updating access code on disk");
    			// we did it.
            }
        } catch (SQLException e) {
        	// big time error, send back error string and close connection
        	_log.error("Could not update security code",e);
        	_session.terminate();
        } finally {
        	DBUtils.close(stmt);
        	DBUtils.close(conn);
        }
        	
		
	}

	protected boolean addPrimaryAccount(QHandle handle, String sAccount) throws IOException {
		boolean rc=false;
        Connection conn=null;
        Statement stmt = null;
        ResultSet rs = null;
        int iUserID;
        
        try {
        	conn=DBUtils.getConnection();
            stmt = conn.createStatement();
        	_log.debug("Adding new user");
        	DBUtils.close(rs);
        	String code=getNewCode();
            stmt.execute("INSERT INTO users (access_code,active,create_date,last_access,last_update,orig_account,orig_code) VALUES ('" + code + "','Y',now(),now(),now(),'" + sAccount + "','" + _sSecurityCode + "')",Statement.RETURN_GENERATED_KEYS);
            if(stmt.getUpdateCount()>0) {
            	// we added it.
            	// update security code
                rs=stmt.getGeneratedKeys();
                if(rs.next()) {
	        		iUserID=rs.getInt(1);
	            	_sSecurityCode=code;
	        		DBUtils.close(rs);
	        		int id=addScreenName(stmt,iUserID,true,handle);
	        		if(id > -1) {
	        			rc=true;
	        			_session.setAccountInfo(new AccountInfo(iUserID,id,true,handle.toString(),false,false));
	        		}
                } else {
                	// could not get insert key....
                	_log.error("Could not obtain inserted record key");
                }
            } else {
            	// db error, could not insert first part.
            	_log.error("Could not insert record into users table");
            }
        } catch (SQLException e) {
        	_log.error("SQL Exception",e);
        	// big time error, send back error string and close connection
        } finally {
        	DBUtils.close(rs);
        	DBUtils.close(stmt);
        	DBUtils.close(conn);
        }
        return rc;
		
	}

	protected int addScreenName(int iUserID, QHandle handle) {
		int id=-1;
        Connection conn=null;
        Statement stmt = null;
        
        try {
        	conn=DBUtils.getConnection();
            stmt = conn.createStatement();
    		id=addScreenName(stmt,iUserID,false,handle);
        } catch (SQLException e) {
        	_log.error("SQL Exception",e);
        } finally {
        	DBUtils.close(stmt);
        	DBUtils.close(conn);
        }
        return id;
		
	}
	/**
	 * @param stmt
	 * @param handle
	 * @return
	 */
	private int addScreenName(Statement stmt, int iUserID, boolean bPrimary, QHandle handle) {
        ResultSet rs = null;
        int id=-1;
        String sPrimary=(bPrimary?"Y":"N");
       
    	// synchronized on something, because we can't allow two people to add at exactly same time.
        synchronized(_log) {
	        try {
	        	if(UserManager.getAccount(handle)==null) {
	        		stmt.execute("INSERT INTO accounts (user_id,primary_ind,active,handle,create_date,last_access,last_update,refresh) VALUES (" + iUserID + ",'" + sPrimary + "','Y','" + handle + "',now(),now(),now(),'N')",Statement.RETURN_GENERATED_KEYS);
			        if(stmt.getUpdateCount()>0) {
			        	// get account number.
			        	rs=stmt.getGeneratedKeys();
			        	if(rs.next()) {
				        	id=rs.getInt(1);
				        	_log.debug("New screen name '" + handle + "' added");
			        	} else {
			            	_log.error("Could not obtain inserted record key");
			        	}
			        } else {
			        	_log.info("Handle '" + handle + "' could not be inserted");
			        }
		        } else {
		        	_log.info("Handle '" + handle + "' already in use");
		        }
	        } catch (SQLException e) {
	        	_log.info("Handle '" + handle + "' already in use");
	        }
        }
        return id;
	}

	protected String getNewCode() {
		DecimalFormat format=new DecimalFormat("0000");
		return format.format(_random.nextInt(10000));
	}

	protected boolean validateNewAccount(EntryDialog d, String handle) throws IOException {
		boolean rc=false;
		if(handle==null || handle.length()==0) {
			_log.debug("Handle is null");
			_session.send(d
				.getErrorResponse("We're sorry, but you must select a screen name"));
		} else {
			if (handle.length() > 10) {
				_log.debug("Handle '" + handle + "' is too long");
				_session.send(d
					.getErrorResponse("We're sorry, but '"
						+ handle
						+ "' is too long.  Please select a shorter name"));
			} else if (getEffLength(handle) < 3) {
					_log.debug("Handle '" + handle + "' is too short");
					_session.send(d
						.getErrorResponse("We're sorry, but '"
							+ handle
							+ "' is too short.  Please select a longer name."));
			} else if (containsInvalidChars(handle)) {
				_log.debug("'" + handle + "' contains invalid characters");
				_session
					.send(d
						.getErrorResponse("We're sorry, but screen names can only contain letters, digits, or spaces.  Please select another name."));
			} else if (!Character.isLetter(handle.charAt(0))) {
				_log.debug("'"
					+ handle
					+ "' contains leading space or number");
				_session
					.send(d
						.getErrorResponse("We're sorry, but screen names must start with a letter.  Please select another name."));
			} else {
				try {
					if (containsReservedWords(handle)) {
						_log.debug("'"
							+ handle
							+ "' contains a reserved word");
						_session
							.send(d
								.getErrorResponse("We're sorry, but your choice contains a reserved word.  Please select another name."));
					} else {
						rc=true;
					}
				} catch (SQLException e) {
					// something very bad happened... We cannot continue.
					_log.error("Error during reserved word lookup", e);
					_session.terminate();
				}
			}
		}
		return rc;
	}

	/**
	 * @param handle
	 * @return
	 */
	private int getEffLength(String handle) {
		int num=0;
		for(int i=0,size=handle.length();i<size;i++) {
			if(Character.isLetterOrDigit(handle.charAt(i)))
				num++;
		}
		return num;
	}

	private boolean containsReservedWords(String handle)
		throws SQLException {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
	
		// lowercase and remove spaces.
		handle=handle.toLowerCase().replaceAll(" ","");
		try {
			_log.debug("Checking for reserved words");
			conn = DBUtils.getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT name from reserved_names");
			if (rs.next()) {
				// check the found names
				do {
					if (handle.startsWith(
						rs.getString("name").toLowerCase()))
						return true;
				} while (rs.next());
			}
		} finally {
			DBUtils.close(rs);
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException sqlEx) {
				}// ignore }
				stmt = null;
			}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException e) {
				}
		}
		return false;
	}

	private boolean containsInvalidChars(String handle) {
		boolean rc = false;
		char ch;
		for (int i = 0; i < handle.length(); i++) {
			ch = handle.charAt(i);
			if (!(Character.isLetterOrDigit(ch) || ch == ' '))
				return true;
		}
		return false;
	}

}
