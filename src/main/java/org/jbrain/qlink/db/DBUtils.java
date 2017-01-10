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
	Created on Sep 9, 2005
	
 */
package org.jbrain.qlink.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.log4j.Logger;
import org.apache.commons.configuration.Configuration;

import org.jbrain.qlink.QConfig;


public class DBUtils {
	private static Logger _log=Logger.getLogger(DBUtils.class);
	
	public static void init() throws Exception {
	  try {
			if (QConfig.getInstance().getBoolean("qlink.db.use_google_driver")) {
				// If we're using the Google Cloud SQL JDBC driver, pulls it in.
				Class.forName("com.mysql.jdbc.GoogleDriver");
			} else {
				// Otherwise, uses the system default MySQL JDBC driver.
				Class.forName("com.mysql.jdbc.Driver").newInstance();
			}
		} catch (Exception e) {
			_log.fatal("Could not load MySQL JDBC driver",e);
		}
	}
	public static Connection getConnection() throws SQLException {
		Configuration config = QConfig.getInstance();
		try {
			String username = System.getenv("QLINK_DB_USERNAME");
			String password = System.getenv("QLINK_DB_PASSWORD");
      String jdbcUri = System.getenv("QLINK_DB_JDBC_URI");

			if (username == null) {
				username = config.getString("qlink.db.username");
			}

			if (password == null) {
				password = config.getString("qlink.db.password");
			}

      if (jdbcUri == null) {
        jdbcUri = config.getString("qlink.db.jdbc_uri");
      }

			// TODO move this userid and password somewhere else
			Connection conn = DriverManager.getConnection(
				jdbcUri,
				username,
				password
			);
			return conn;
		} catch (SQLException e) {
			_log.error("Could not get DB Connection",e);
			throw e;
		}
	}
	
	public static void close(Connection c) {
		if(c!=null)
			try {
				c.close();
			} catch (SQLException e) {
			}
	}
	
	public static void close(Statement s) {
		if(s!=null)
			try {
				s.close();
			} catch (SQLException e) {
			}
	}
	
	public static void close(ResultSet rs) {
		if(rs!=null)
			try {
				rs.close();
			} catch (SQLException e) {
			}
	}

	public static int getNextID(int start, int type, int max) {
        Connection conn=null;
        Statement stmt = null;
        ResultSet rs = null;
        String sql; 
        
        try {
        	conn=DBUtils.getConnection();
            stmt = conn.createStatement();
            _log.debug("Attempting to find next available message base ID after "+ start);
        	int orig_id=start;
        	do {
        		start++;
        		if(start>max)
        			start=0;
        		sql="SELECT reference_id from entry_types where reference_id=" + start;
        		_log.debug(sql);
        		rs=stmt.executeQuery(sql);
        	} while(rs.next() && start!=orig_id);
    		try { rs.close(); 
    		} catch (Exception e) {}
        	if(start==orig_id) {
        		// error
        		_log.error("Cannot find ID <=" + max);
        		return -1;
        	} else {
        		_log.debug("Creating new entry_types record");
    			sql="insert into entry_types (reference_id,entry_type,create_date,last_update) VALUES (" + start + "," + type + ",now(),now())";
				_log.debug(sql);
    			stmt.execute(sql);
    			if(stmt.getUpdateCount()==0) {
    				_log.error("Could not insert record into entry_types");
    				return -1;
    			}
        	}
    		return start;
        } catch (SQLException e) {
        	_log.error("SQL Exception",e);
        	return -1;
        } finally {
        	close(rs);
        	close(stmt);
        	close(conn);
        }
	}
	

	
}
