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
	Created on Sep 29, 2005
	
 */
package org.jbrain.qlink.user;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.jbrain.qlink.db.DBUtils;


public class AccountInfo {
	private static Logger _log=Logger.getLogger(AccountInfo.class);

	private int _iAccountID;
	private boolean _bPrimary;
	private QHandle _handle;
	private boolean _bRefresh;
	private int _iUserID;
	private boolean _bStaff;

	/**
	 * @param acct
	 * @param i
	 * @param b
	 * @param string
	 */
	public AccountInfo(
			int userid, 
			int acct, 
			boolean b, 
			String handle, 
			boolean bRefresh,
			boolean bStaff
		   ) {
		_iAccountID=acct;
		_iUserID=userid;
		_bPrimary=b;
		_handle=new QHandle(handle);
		_bRefresh=bRefresh;
		_bStaff=bStaff;
	}

	/**
	 * @return
	 */
	public QHandle getHandle() {
		return _handle;
	}

	/**
	 * @return
	 */
	public boolean isPrimaryAccount() {
		return _bPrimary;
	}

	/**
	 * @return
	 */
	public int getAccountID() {
		return _iAccountID;
	}

	/**
	 * @param b
	 * @throws AccountUpdateException
	 */
	public void setRefresh(boolean b) throws AccountUpdateException {
        String sRefresh=(b?"Y":"N");
		
        if(_log.isDebugEnabled())
        	_log.debug("Updating user name '" + getHandle() + "' refresh status to: '" + sRefresh + "'");
        executeSQL("UPDATE accounts set refresh='" + sRefresh + "' where account_id=" + getAccountID());
    	_bRefresh=b;
	}

	public void setPrimaryInd(boolean b) throws AccountUpdateException {
        String sRefresh=(b?"Y":"N");
		
        if(_log.isDebugEnabled())
        	_log.debug("Updating user name '" + getHandle() + "' primary account status to: '" + sRefresh + "'");
        executeSQL("UPDATE accounts set primary_ind='" + sRefresh + "' where account_id=" + getAccountID());
    	_bPrimary=b;
	}
	
	/**
	 * @return
	 */
	public boolean needsRefresh() {
		return _bRefresh;
	}

	/**
	 * @return
	 * @throws AccountUpdateException
	 */
	public void delete() throws AccountUpdateException {
        _log.debug("Deleting account for '" + getHandle() + "'");
		executeSQL("DELETE from accounts WHERE account_id=" + getAccountID());
	}

	/**
	 * @param string
	 * @throws AccountUpdateException
	 */
	private void executeSQL(String sql) throws AccountUpdateException {
        Connection conn=null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try {
        	conn=DBUtils.getConnection();
            stmt = conn.createStatement();
	        stmt.execute(sql);
	        if(stmt.getUpdateCount()==0)
	        	throw new AccountUpdateException("Update Count=0");
        } catch (SQLException e) {
        	_log.error("SQL Exception",e);
        	throw new AccountUpdateException();
        } finally {
        	DBUtils.close(rs);
        	DBUtils.close(stmt);
        	DBUtils.close(conn);
        }
	}

	/**
	 * @return
	 */
	public int getUserID() {
		return _iUserID;
	}

	/**
	 * @param userID
	 * @throws AccountUpdateException
	 */
	public void setUserID(int userID) throws AccountUpdateException {
        _log.debug("Setting userid for '" + getHandle() + "' to: " + userID);
		executeSQL("UPDATE accounts SET user_id=" + userID + " where account_id=" + getAccountID());
		_iUserID=userID;
	}
	
	public UserInfo getUserInfo() {
		UserInfo info;

        Connection conn=null;
        Statement stmt = null;
        ResultSet rs = null;
        List l=new ArrayList();
		
        try {
        	conn=DBUtils.getConnection();
            stmt = conn.createStatement();
            _log.debug("Getting user information for account: '" + getHandle() + "'");
        	rs=stmt.executeQuery("SELECT name, city, state, country, email FROM users where user_id=" + getUserID());
        	if(rs.next()) {
        		return new UserInfo(rs.getString("name"),rs.getString("city"),rs.getString("state"),rs.getString("country"),rs.getString("email"));
        	}
        } catch (SQLException e) {
        	_log.error("SQL Exception",e);
        } finally {
        	DBUtils.close(rs);
        	DBUtils.close(stmt);
        	DBUtils.close(conn);
        }
		return null;
	}

	/**
	 * @returngre
	 */
	public boolean isStaff() {
		return _bStaff;
	}
}

