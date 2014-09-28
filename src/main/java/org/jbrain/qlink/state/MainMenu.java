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

import java.io.*;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

import org.apache.log4j.Logger;
import org.jbrain.qlink.QSession;
import org.jbrain.qlink.cmd.action.*;
import org.jbrain.qlink.db.DBUtils;
import org.jbrain.qlink.text.TextFormatter;


public class MainMenu extends AbstractState {
	private static Logger _log=Logger.getLogger(MainMenu.class);
	private boolean _bSuperChat=false;

	public MainMenu(QSession session) {
		super(session);
	}
	
	public void activate() throws IOException {
		super.activate();
		sendBulletin();
	}

	public void sendBulletin() throws IOException {
        Connection conn=null;
        Statement stmt = null;
        ResultSet rs = null;
    	StringBuffer sb=new StringBuffer();
    	char delim=(char)0xff;
        
        try {
        	conn=DBUtils.getConnection();
            stmt = conn.createStatement();
            _log.debug("Reading today's bulletin");
        	rs=stmt.executeQuery("SELECT text from bulletin WHERE start_date<now() AND end_date>now() AND approved='Y' ORDER BY start_date DESC");
        	if(rs.next()) {
        		_log.debug("Defining Bulletin");
        		TextFormatter tf=new TextFormatter();
        		tf.add("WELCOME TO Q-LINK, " + _session.getHandle());
        		tf.add("\n");
        		do {
            		tf.add(rs.getString("text"));
            		tf.add("\n");
        		} while (rs.next());
            	tf.add("\n        <PRESS F5 FOR MENU>");
        		_log.debug("Sending Bulletin");
            	List l=tf.getList();
            	int size=l.size();
            	String line;
            	for(int i=0;i<size;i++) {
            		line=(String)l.get(i);
            		if((sb.length()+ 1 + line.length()) > 117) {
                		_session.send(new BulletinLine(sb.toString(),false));
                		// strange, a trailing xff is not honored.
                		if(sb.charAt(sb.length()-1) == 0xff && sb.charAt(sb.length()-2)!=0xff) {
                			sb.setLength(0);
                			sb.append(delim);
                		} else {
                			sb.setLength(0);
                		}
            			sb.append(line);
            		} else {
            			sb.append(delim);
            			sb.append(line);
            		}
            	}
        		_session.send(new BulletinLine(sb.toString(),true));
        	} else {
        		// we have no bulletin data.
        		_session.send(new DisplayMainMenu());
        	}
        } catch (SQLException e) {
        	_log.error("SQL Exception",e);
        } finally {
        	DBUtils.close(rs);
        	DBUtils.close(stmt);
        	DBUtils.close(conn);
        }
	}
	
	public boolean execute(Action a) throws IOException {
		QState state;
		boolean rc=false;
		
		if(a instanceof EnterMessageBoard) {
			rc=true;
			state=new DepartmentMenu(_session);
			state.activate();
		} else if(a instanceof EnterChat) {
			rc=true;
			if(_bSuperChat)
				state=new SuperChat(_session);
			else
				state=new Chat(_session);
			state.activate();
		} else if(a instanceof EnterSuperChat) {
			_bSuperChat=true;
			rc=true;
		}
		if(!rc)
			rc=super.execute(a);
		return rc;
	}

}
