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
	Created on Oct 21, 2005
	
 */
package org.jbrain.qlink.extensions;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

import org.apache.log4j.Logger;
import org.jbrain.qlink.QLinkServer;
import org.jbrain.qlink.chat.ChatEvent;
import org.jbrain.qlink.chat.JoinEvent;
import org.jbrain.qlink.chat.QRoomDelegate;
import org.jbrain.qlink.chat.QuestionStateEvent;
import org.jbrain.qlink.chat.RoomEventListener;
import org.jbrain.qlink.chat.RoomManager;
import org.jbrain.qlink.chat.RoomManagerEvent;
import org.jbrain.qlink.chat.RoomManagerEventListener;
import org.jbrain.qlink.chat.SystemMessageEvent;
import org.jbrain.qlink.db.DBUtils;


public class RoomAuditor {
	protected static RoomEventListener _roomEventListener = new RoomEventListener() {

		public void userSaid(ChatEvent event) {
			audit(event.getRoom().getName(),event.getRoom().isPublicRoom(),event.getSeatID(),event.getName(),"SAY",event.getText());
		}

		public void userJoined(JoinEvent event) {
			audit(event.getRoom().getName(),event.getRoom().isPublicRoom(),event.getSeatID(),event.getName(),"JOIN","");
		}

		public void userLeft(JoinEvent event) {
			audit(event.getRoom().getName(),event.getRoom().isPublicRoom(),event.getSeatID(),event.getName(),"LEAVE","");
		}

		public void systemSent(SystemMessageEvent event) {}
		public void acceptingQuestions(QuestionStateEvent event) {}
		public void rejectingQuestions(QuestionStateEvent event) {}
	};

	private static RoomManagerEventListener _roomMgrListener=new RoomManagerEventListener() {

		public void roomAdded(RoomManagerEvent event) {
			event.getRoom().addEventListener(_roomEventListener);
			audit(event.getRoom().getName(),event.getRoom().isPublicRoom(),-1,"","CREATE","");
		}

		public void roomRemoved(RoomManagerEvent event) {
			event.getRoom().removeEventListener(_roomEventListener);
			audit(event.getRoom().getName(),event.getRoom().isPublicRoom(),-1,"","DELETE","");
		}
		
	};

	private static Logger _log=Logger.getLogger(RoomAuditor.class);

	/**
	 * 
	 */
	public RoomAuditor(QLinkServer server) {
		super();
		QRoomDelegate room;
		// set up listener for room logging.
		RoomManager mgr=RoomManager.getRoomManager();
		
		mgr.addEventListener(_roomMgrListener);
		List l=mgr.getRoomList();
		for(int i=0;i<l.size();i++) {
			// add each pre-existing room to the listener.
			room=(QRoomDelegate)l.get(i);
			room.addEventListener(_roomEventListener);
			audit(room.getName(),room.isPublicRoom(),-1,"","CREATE","");
		}
	}

	private static void audit(String room, boolean bPublic, int seat, String name, String action, String text) {
        Connection conn=null;
        Statement stmt = null;
        
        try {
        	conn=DBUtils.getConnection();
            stmt = conn.createStatement();
	        stmt.execute("INSERT into room_log (room,public_ind,seat, handle,action,text, timestamp) VALUES ('" + room + "','" + (bPublic?"Y":"N") + "'," + seat + ",'" + name + "','" + action + "','" + text + "',now())");
        } catch (SQLException e) {
        	// ignore error
        	_log.error("SQL Exception",e);
        } finally {
        	DBUtils.close(stmt);
        	DBUtils.close(conn);
        }
	}

}
