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
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.log4j.Logger;
import org.jbrain.qlink.*;
import org.jbrain.qlink.cmd.action.*;
import org.jbrain.qlink.db.DBUtils;
import org.jbrain.qlink.user.AccountInfo;
import org.jbrain.qlink.user.QHandle;
import org.jbrain.qlink.user.UserManager;

public class SendEmailState extends AbstractState {
	private static Logger _log=Logger.getLogger(SendEmailState.class);

	/**
	 * 
	 * @uml.property name="_intState"
	 * @uml.associationEnd multiplicity="(0 1)"
	 */
	private QState _intState;

	private QHandle _recipient;
	private int _iToID;
	private StringBuffer _sbText=new StringBuffer();
	
	public SendEmailState(QSession session, QHandle recipient) {
		super(session);
		_recipient=recipient;
}
	
	public void activate() throws IOException {
		_log.debug("User requested to send an email to " + _recipient);
		// we need to send an email...
		// need to check for valid user
		AccountInfo info=UserManager.getAccount(_recipient);
		if(info!=null) {
			_iToID=info.getAccountID();
			_intState=_session.getState();
			super.activate();
			String line1="Date:  ";
			SimpleDateFormat sdf=new SimpleDateFormat("EEEEEEEE d-MMM-yyyy HH:mm zzz");
			line1+=sdf.format(new Date());
			_session.send(new EK(line1,_session.getHandle().toString()));
			_log.debug("Asking user to compose email");
		} else {
			// user does not exist or internal error.
			_session.send(new E2());
		}

	}
	

	public boolean execute(Action a) throws IOException {
		if(a instanceof EmailLastLine) {
			// save last line of email text;
			String text=((EmailLastLine)a).getData();
			_log.debug("Email End: " + text);
			_sbText.append(text);
			_sbText.append("\n");
			// now, save email...
			saveEmail(_iToID,_sbText.toString());
			// get DB connection and save email, and pop up MAIL tag on user if they
			// are logged in.
			_session.getServer().sendToUser(_recipient,new NewMail());
			_session.setState(_intState);
			return true;
		} else if(a instanceof EmailNextLine) {
			// save first/next line of email text
			String text=((EmailNextLine)a).getData();
			_log.debug("Email Text: " + text);
			_sbText.append(text);
			_sbText.append("\n");
			return true;
		} else if(a instanceof EmailCanceled) {
			// email is cancelled
			_log.debug("Cancelled email to " + _recipient);
			_session.setState(_intState);
			return true;
		} else {
			return _intState.execute(a);
		}
	}


	public void terminate() {
		_intState.terminate();
	}

	
	private void saveEmail(int id, String text) {
        Connection conn=null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try {
        	conn=DBUtils.getConnection();
            stmt = conn.createStatement();
            _log.debug("Saving email to " + _recipient);
            String sql="INSERT INTO email (recipient_id,recipient,sender_id,sender,subject,body,unread,received_date) VALUES (" + id + ",NULL," + _session.getAccountID() + ",NULL,NULL,'" + text.replaceAll("'","\\\\'") + "','Y',now())";
            //_log.debug(sql);
            stmt.execute(sql);
            if(stmt.getUpdateCount()>0) {
            	// we added it.
            	_log.debug("Email successfully saved");
            } else {
            	_log.debug("Email not saved");
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
