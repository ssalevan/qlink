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
import org.jbrain.qlink.*;
import org.jbrain.qlink.cmd.action.*;
import org.jbrain.qlink.db.DBUtils;
import org.jbrain.qlink.text.TextFormatter;

public class ReadEmailState extends AbstractState {
	private static Logger _log=Logger.getLogger(ReadEmailState.class);

	/**
	 * 
	 * @uml.property name="_intState"
	 * @uml.associationEnd multiplicity="(0 1)"
	 */
	private QState _intState;

	
	public ReadEmailState(QSession session) {
		super(session);
}
	
	public void activate() throws IOException {
		if(checkEmail()) {
			//StringBuffer sb=new StringBuffer();
			_session.send(new ReadEmailAck());
			TextFormatter tf=new TextFormatter();
			tf.add(getNextEmail());
			List l=tf.getList();
			int size=l.size();
			for(int i=0;i<size;i++) {
				//sb.append((String)l.get(i));
				//sb.append((char)0x01);
				//sb.append("This is a test line");
				//sb.append((char)0x01);
				//sb.append("This is a test line");
				_session.send(new EmailText((String)l.get(i),EmailText.LINE_NEXT));
				//_session.send(new EmailText(sb.toString(),EmailText.LINE_NEXT));
				//sb.setLength(0);
			}
			int flag=EmailText.LINE_LAST_NO_MORE_MAIL;
			if(checkEmail()) {
				flag=EmailText.LINE_LAST;
			}
			_session.send(new EmailText("End of Mail - Press F5 to cancel",flag));
			_intState=_session.getState();
			super.activate();
		} else {
			_session.send(new NoEmail());
		}

	}
	

	public boolean execute(Action a) throws IOException {
		if(!(a instanceof LostConnection)) {
			// delete email.
		}
		_session.setState(_intState);
		return _intState.execute(a);
	}


	public void terminate() {
		_intState.terminate();
	}

	
	private String getNextEmail() {
        Connection conn=null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try {
        	conn=DBUtils.getConnection();
            stmt = conn.createStatement();
            _log.debug("Getting next email for " + _session.getHandle());
            rs=stmt.executeQuery("SELECT email_id,body FROM email WHERE unread='Y' AND recipient_id=" + _session.getAccountID() + " LIMIT 1");
            if(rs.next()) {
            	String body=rs.getString("body");
                stmt.execute("UPDATE email SET unread='N' WHERE email_id=" + rs.getInt("email_id"));
                if(stmt.getUpdateCount()>0) {
                	_log.debug("Updated email to read");
                } else {
                	_log.error("Was not able to set email indicator to 'read'");
                }
            	return body;
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

}
