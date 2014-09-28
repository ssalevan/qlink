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
	Created on Oct 7, 2005
	
 */
package org.jbrain.qlink.state;

import java.io.IOException;
import java.util.Hashtable;

import org.apache.log4j.Logger;
import org.jbrain.qlink.QSession;
import org.jbrain.qlink.chat.QSeat;
import org.jbrain.qlink.chat.RoomInfo;
import org.jbrain.qlink.cmd.action.*;
import org.jbrain.qlink.cmd.action.fdo.*;
import org.jbrain.qlink.cmd.action.fdo.ext.FDOMenuHelper;
import org.jbrain.qlink.cmd.action.fdo.ext.FDOMenuItem;
import org.jbrain.qlink.cmd.action.fdo.ext.FDORoomInfo;
import org.jbrain.qlink.user.QHandle;
import org.jbrain.qlink.util.QuotedStringTokenizer;


public class SuperChat extends Chat {
	private static Logger _log=Logger.getLogger(SuperChat.class);
	private static Hashtable _menus = new Hashtable();
	private static final FDOItemID ID_MAIN_MENU=new FDOItemID(0x0f0000);
	
	static {
		// create some menus...
		FDOMenuHelper helper=new FDOMenuHelper();
		helper.add(FDOMenuItem.CHANGE_ROOM);
		helper.add(FDOMenuItem.DISK_CMD);
		helper.add(FDOMenuItem.DISK_MENU);
		helper.add(FDOMenuItem.HIGHLIGHT_OFF);
		helper.add(FDOMenuItem.HIGHLIGHT_ON);
		helper.add(FDOMenuItem.IDENTIFY);
		helper.add(FDOMenuItem.IGNORE_OFF);
		helper.add(FDOMenuItem.IGNORE_ON);
		helper.add(FDOMenuItem.LOAD_TEXT);
		helper.add(FDOMenuItem.LOCATE);
		helper.add(FDOMenuItem.OLM_MENU);
		helper.add(FDOMenuItem.PLAY_MUSIC);
		helper.add(FDOMenuItem.PRIVATE_ROOM);
		helper.add(FDOMenuItem.PUBLIC_ROOM);
		helper.add(FDOMenuItem.SAVE);
		helper.add(FDOMenuItem.SEND_EMAIL);
		helper.add(FDOMenuItem.SEND_OLM);
		_menus.put(new Integer(ID_MAIN_MENU.getID()),helper);
		
	}

	/**
	 * @param session
	 */
	public SuperChat(QSession session) {
		super(session);
	}
	
	public boolean execute(Action a) throws IOException {
		FDOMenuHelper helper;
		boolean rc=false;
		int id;
		
		if(a instanceof SelectMenuItem) {
			id=((SelectMenuItem)a).getID();
			_log.debug("User requests menu item: " + id);
			helper=(FDOMenuHelper)_menus.get(new Integer(id));
			if(helper==null) {
				helper=new FDOMenuHelper();
				helper.add(new FDOMenuItem("Invalid",new FDOSelectItemResponse("K1",0)));
			}
			_session.send(helper.getMenu());
		} else if(a instanceof ListRooms) {
			// override Chat ListRooms function.
			RoomInfo[] rooms=_mgr.getRoomInfoList();
			FDO fdo=new FDO(new NewWindow(FDOWindowType.TYPE_TEXT_WINDOW));
			for(int i=0;i<rooms.length;i++) {
				if(!fdo.add(new FDORoomInfo(rooms[i]))) {
					_session.send(fdo);
					fdo=new FDO(new ContinueWindow());
					fdo.add(new FDORoomInfo(rooms[i]));
				}
			}
			_session.send(fdo);
			rc=true;
		}
		if(!rc)
			rc=super.execute(a);
		return rc;
	}
	
	protected void sendRoomInfo(QSeat[] seats) {
		showSeats(seats,false);
	}
	
	protected void showSeats(QSeat[] seats, boolean b) {
		// in SuperQ/MC, you have to send the QRoom name and your seat number all the time.
		int seat=_room.getSeatInfo(_session.getHandle()).getSeatID();
		_session.send(new EnterExtRoom(ID_MAIN_MENU,seat,_room.getName()));
		super.showSeats(seats,b);
		
	}

	protected void process(String text) throws IOException {
		QHandle handle;
		
		if(text.startsWith("//") || text.startsWith("=q")) {
			// do //msg and //join here.
			String[] olm;
			String name=null,msg=null, error=null;
			if(text.length()>2) {
				QuotedStringTokenizer st=new QuotedStringTokenizer(text.substring(2));
				String cmd=st.nextToken(" ").toLowerCase();
				int pos=0;
				if((cmd.startsWith("tos") || (cmd.startsWith("bump"))) && _session.isStaff()) {
					// kick user;
					if(st.hasMoreTokens()) {
						super.process(text);
					} else {
						// bing up list
					}
				} else if(cmd.startsWith("nick")) {
					// Change user name;
					if(st.hasMoreTokens())
						super.process(text);
					else {
						// bring up list
					}
				} else if(cmd.startsWith("join")) {
					_log.debug("Entering public room");
					if(st.hasMoreTokens()) {
						name=st.nextToken("\n");
						enterRoom(name,true);
					} else {
						RoomInfo[] rooms=_mgr.getRoomInfoList();
						// need to put up room list.
						FDOMenuHelper helper=new FDOMenuHelper();
						for(int i=0;i<rooms.length;i++) {
							helper.add(rooms[i].getName(),new FDOStringResponse("CM",rooms[i].getName()));
						}
						_session.send(helper.getMenu());
					}
				} else if(cmd.startsWith("pjoin")) {
					_log.debug("Entering private room");
					if(st.hasMoreTokens()) {
						name=st.nextToken("\n");
						enterRoom(name,false);
					} else {
						error="No room specified";
					}
				} else if(cmd.startsWith("msg")) {
					// Send someone a private msg;
					if(st.hasMoreTokens())
						super.process(text);
					else {
						// bring up a window.
					}
				} else {
					// try the normal chat stuff
					super.process(text);
				}
			} else {
				error="No command specified";
			}
			// did we have an error.
			if(error!=null) {
				_log.debug("Sending error: " + error);
				olm=new String[1];
				olm[0]="Error: " + error;
				_session.sendOLM(olm);
			}
		
		} else {
			// can room make sense of it?
			_room.say(text);
		}
	}

}
