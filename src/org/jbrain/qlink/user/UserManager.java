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


public class UserManager {
	private static Logger _log=Logger.getLogger(UserManager.class);
	
	public static List getAccountsforUser(int id) {
        Connection conn=null;
        Statement stmt = null;
        ResultSet rs = null;
        List l=new ArrayList();
		
        try {
        	conn=DBUtils.getConnection();
            stmt = conn.createStatement();
            _log.debug("Checking for accounts for User ID: " + id);
        	rs=stmt.executeQuery("SELECT staff_ind,primary_ind, user_id,account_id,handle,refresh from accounts where user_id=" + id + " order by create_date");
        	createObjects(l,rs);
        } catch (SQLException e) {
        	_log.error("SQL Exception",e);
        } finally {
        	DBUtils.close(rs);
        	DBUtils.close(stmt);
        	DBUtils.close(conn);
        }
        return l;
	}
	
	public static AccountInfo getAccount(QHandle handle) {
        Connection conn=null;
        Statement stmt = null;
        ResultSet rs = null;
        AccountInfo info=null;
		
        try {
        	conn=DBUtils.getConnection();
            stmt = conn.createStatement();
            _log.debug("Getting Account information for '" + handle + "'");
        	rs=stmt.executeQuery("SELECT staff_ind,primary_ind, user_id,account_id,handle,refresh from accounts where REPLACE(handle,' ','') LIKE '" + handle.getKey() + "'");
        	if(rs.next())
        		info=populateAccountInfo(rs);
        } catch (SQLException e) {
        	_log.error("SQL Exception",e);
        } finally {
        	DBUtils.close(rs);
        	DBUtils.close(stmt);
        	DBUtils.close(conn);
        }
        return info;
	}
	
	public static List getSubAccountsforUser(int id) {
        Connection conn=null;
        Statement stmt = null;
        ResultSet rs = null;
        List l=new ArrayList();
		
        try {
        	conn=DBUtils.getConnection();
            stmt = conn.createStatement();
            _log.debug("Checking for sub accounts for User ID: " + id);
        	rs=stmt.executeQuery("SELECT staff_ind,primary_ind, user_id,account_id,handle,refresh from accounts where primary_ind='N' and user_id=" + id + " order by create_date");
        	createObjects(l,rs);
        } catch (SQLException e) {
        	_log.error("SQL Exception",e);
        } finally {
        	DBUtils.close(rs);
        	DBUtils.close(stmt);
        	DBUtils.close(conn);
        }
        return l;
	}

	/**
	 * @param rs
	 * @return
	 */
	private static List createObjects(List l,ResultSet rs) throws SQLException  {
    	while(rs.next()) {
    		l.add(populateAccountInfo(rs));
    	}
    	return l;
	}

	/**
	 * @param rs
	 * @return
	 * @throws SQLException
	 */
	private static AccountInfo populateAccountInfo(ResultSet rs) throws SQLException {
		return new AccountInfo(
				rs.getInt("user_id"),
				rs.getInt("account_id"),
				rs.getString("primary_ind").equalsIgnoreCase("Y"),
				rs.getString("handle"),
				(rs.getString("refresh").equalsIgnoreCase("Y")),
				(rs.getString("staff_ind").equalsIgnoreCase("Y"))
				);
	}

	/**
	 * @param userID
	 * @throws Exception
	 */
	public static void deleteUser(int userID) throws Exception {
		// TODO make this throw a better exception.
		try {
			if(executeSQL("DELETE from users where user_id=" + userID)==0) {
				throw new Exception("Update Count==0");
			}
		} catch (Exception e) {
			throw e;
		}
		
	}
	
	private static int executeSQL(String sql) throws SQLException {
        Connection conn=null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try {
        	conn=DBUtils.getConnection();
            stmt = conn.createStatement();
	        stmt.execute(sql);
	        return stmt.getUpdateCount();
        } catch (SQLException e) {
        	_log.error("SQL Exception",e);
        	throw e;
        } finally {
        	DBUtils.close(rs);
        	DBUtils.close(stmt);
        	DBUtils.close(conn);
        }
	}

	/**
	 * @param name
	 * @param city
	 * @param state
	 * @param country
	 */
	public static void updateUserInfo(int userID, String name, String city, String state, String country) throws Exception {
		// TODO make this throw a better exception.
		try {
			if(executeSQL("UPDATE users set name='" + name + "',city='" + city + "',state='" + state + "',country='" +country + "' where user_id=" + userID)==0) {
				throw new Exception("Update Count==0");
			}
		} catch (Exception e) {
			throw e;
		}
		
	}
	
}
