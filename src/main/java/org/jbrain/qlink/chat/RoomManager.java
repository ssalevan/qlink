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
	Created on Jul 26, 2005
	
 */
package org.jbrain.qlink.chat;

import java.util.*;

import org.apache.log4j.Logger;
import org.jbrain.qlink.chat.irc.simple.IRCRoomDelegate;
import org.jbrain.qlink.user.QHandle;


/*
 * Normally, this would be a singleton, but then you'd need to synchronize on the class, not the instance,
 * so this seemed easier.  I may change it later
 */
public class RoomManager {
	private static Logger _log=Logger.getLogger(RoomManager.class);
	private  Hashtable _htPublicRooms=new Hashtable();
	private static Hashtable _htPrivateRooms=new Hashtable();
	private static final String ROOM_LOBBY = "Lobby";
	private static AuditoriumDelegate _auditorium;
	private static ArrayList _listeners = new ArrayList();
	private static RoomManager _mgr=new RoomManager();

	private RoomManager() {
		_log.debug("Creating default Lobby");
		addPublicRoom(new RoomDelegate(ROOM_LOBBY,true,true));
		_log.debug("Creating Auditorium");
		_auditorium=new AuditoriumDelegate("Auditorium");
		addPrivateRoom(_auditorium);
		
		// temp people for testing
		/*ChatProfile p=new ChatProfile();
		join(new QHandle("Person 1"),p);
		join(new QHandle("Person 2"),p);
		join(new QHandle("Person 3"),p);
		join(new QHandle("Person 4"),p);
		join(new QHandle("Person 5"),p);
		join(new QHandle("Person 6"),p);
		join(new QHandle("Person 7"),p);
		join(new QHandle("Person 8"),p);
		join(new QHandle("Person 9"),p);
		join(new QHandle("Person 10"),p);*/
	}
	
	public static RoomManager getRoomManager() {
		return _mgr;
	}

	// does not need to be sync
	public QRoom join(QHandle handle,ChatProfile profile) {
		String name=ROOM_LOBBY;
		QRoom room=null;
		int i=(int)'A';
		
		do {
			room=joinRoom(name,handle,profile,true);
			if(i<='Z')
				name=ROOM_LOBBY + " " + (char)(i++);
			else {
				name=ROOM_LOBBY + " " + (int)(i-'Z');
				i++;
			}
		} while(room == null);
		return room;
	}
	
	/*
	 * We try to find the specified room, and get a seat.
	 * Questions:
	 * 
	 * If a user tries to enter a Lobby, it will work if the Lobby is present and not full
	 * If the Lobby is full, it will return null...
	 */
	// this needs to be sync
	public synchronized QRoom joinRoom(String name, QHandle handle, ChatProfile profile, boolean bPublic) {
		QRoomDelegate room;
		QSeat user=null;
		
		if(bPublic)
			room=getPublicRoom(name);
		else
			room=getPrivateRoom(name);
		if(room.addUser(handle,profile))
			return new NormalRoom(room,handle); 
		return null;
	}
	
	// what happens if room has no other users and is public?
	public synchronized QRoom monitorRoom(String name, QHandle handle, ChatProfile profile, boolean bPublic) {
		QRoomDelegate room;
		QSeat user=null;
		
		if(bPublic)
			room=getPublicRoom(name);
		else
			room=getPrivateRoom(name);
		room.addAdminUser(handle,profile);
		return new NormalRoom(room,handle); 
	}

	// no need for sync
	public QRoom joinAuditorium(QHandle handle, ChatProfile profile) {
		_auditorium.addViewer(handle,profile);
		return new Auditorium(_auditorium,handle);
	}

	// no need for sync
	public void leaveAuditorium(QHandle handle) {
		_auditorium.removeViewer(handle);
	}
	
	public RoomInfo[] getRoomInfoList() {
		QRoomDelegate room;
		int pop;
		// synchronized on the hashtable
		List l=new ArrayList(_htPublicRooms.values());
		List info=new ArrayList();
		for(int i=0;i<l.size();i++) {
			room=(QRoomDelegate)l.get(i);
			pop=room.getPopulation();
			if(pop!=0)
				info.add(new RoomInfo(room.getName(),pop,room.isPublicRoom()));
		}
		return (RoomInfo[])info.toArray(new RoomInfo[info.size()]);
	}
	
	public List getRoomList() {
			List l= new ArrayList(_htPublicRooms.values());
			l.addAll(_htPrivateRooms.values());
			return l;
	}

	public synchronized void removeEventListener(RoomManagerEventListener listener) {
		_listeners.remove(listener);
	}

	public synchronized void addEventListener(RoomManagerEventListener listener) {
		_listeners.add(listener);
	}

	public RoomInfo getUserLocation(QHandle handle) {
		// this will get all the rooms in a syncrhonized way
		List l=this.getRoomList();
		QRoomDelegate room;
	
		for(int i=0;i<l.size();i++) {
			room=(QRoomDelegate)l.get(i);
			if(room.getSeatInfo(handle)!=null)
				return new RoomInfo(room.getName(),room.getPopulation(), room.isPublicRoom());
		}
		return null;
	}

	synchronized void leaveRoom(QRoomDelegate room, QHandle handle) {
		// this is called from the room facades, so we get the locks right (mgr, then room); 
		room.leave(handle);
		if(room.getPopulation()==0 && !room.isLocked())
			if(room.isPublicRoom()) {
				removePublicRoom(room);
			} else {
				removePrivateRoom(room);
			}
		
	}

	private synchronized void processEvent(RoomManagerEvent event) {
		if(event != null && _listeners.size() > 0) {
			if(event.getType()==RoomManagerEvent.EVENT_ADD)
				for(int i=0,size=_listeners.size();i<size;i++) {
					((RoomManagerEventListener)_listeners.get(i)).roomAdded(event);
				}
			else
				for(int i=0,size=_listeners.size();i<size;i++) {
					((RoomManagerEventListener)_listeners.get(i)).roomRemoved(event);
				}
		}
	}

	private QRoomDelegate getPublicRoom(String name) {
		QRoomDelegate room=(QRoomDelegate)_htPublicRooms.get(name.toLowerCase());
		if(room==null) {
			room=createRoom(name,true);
			addPublicRoom(room);
		}
		return room;
	}

	/**
	 * @param name
	 * @param b
	 */
	private QRoomDelegate createRoom(String name, boolean b) {
		QRoomDelegate room;
		
		if(b && name.toLowerCase().startsWith("irc ") && name.length()>4) {
			room=new IRCRoomDelegate(name,b,false);
		} else
			room=new RoomDelegate(name,b,false);
		return room;
	}

	private QRoomDelegate getPrivateRoom(String name) {
		QRoomDelegate room=(QRoomDelegate)_htPrivateRooms.get(name.toLowerCase());
		if(room==null) {
			room=createRoom(name,false);
			addPrivateRoom(room);
		}
		return room;
	}
	private void addPublicRoom(QRoomDelegate room) {
		_log.debug("Adding room '" + room.getName() + "' to public room list");
		_htPublicRooms.put(room.getName().toLowerCase(),room);
		processEvent(new RoomManagerEvent(this,RoomManagerEvent.EVENT_ADD,room));
	}
	
	private void addPrivateRoom(QRoomDelegate room) {
		_log.debug("Adding room '" + room.getName() + "' to private room list");
		_htPrivateRooms.put(room.getName().toLowerCase(),room);
		processEvent(new RoomManagerEvent(this,RoomManagerEvent.EVENT_ADD,room));
	}
	
	/**
	 * @param room
	 */
	private void removePublicRoom(QRoomDelegate room) {
		_log.debug("Removing room '" + room.getName() + "' from public room list");
		_htPublicRooms.remove(room.getName().toLowerCase());
		try {
			processEvent(new RoomManagerEvent(this,RoomManagerEvent.EVENT_REMOVE,room));
		} finally {
			room.close();
		}
		
	}

	private void removePrivateRoom(QRoomDelegate room) {
		_log.debug("Removing room '" + room.getName() + "' from private room list");
		_htPrivateRooms.remove(room.getName());
		try {
			processEvent(new RoomManagerEvent(this,RoomManagerEvent.EVENT_REMOVE,room));
		} finally {
			room.close();
		}
		
	}
}
