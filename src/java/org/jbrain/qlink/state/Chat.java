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
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.jbrain.qlink.*;
import org.jbrain.qlink.chat.*;
import org.jbrain.qlink.cmd.action.*;
import org.jbrain.qlink.text.TextFormatter;
import org.jbrain.qlink.user.AccountInfo;
import org.jbrain.qlink.user.QHandle;
import org.jbrain.qlink.user.UserManager;
import org.jbrain.qlink.util.QuotedStringTokenizer;

public class Chat extends AbstractChatState {
	private static Logger _log=Logger.getLogger(Chat.class);
	private int _iSeat;
	private RoomInfo[] _rooms;
	private int _roomPos;
	private ArrayList _alQuestion=new ArrayList();
	
	public Chat(QSession session) {
		super(session);
		session.enableOLMs(true);
	}
	
	public void activate() throws IOException {
		QSeat[] seats;
		
		super.activate();
		_log.debug(_session.getHandle() + " joins Lobby");
		// find a Lobby to enter, get our seat number, etc.
		// need to make sure no enter/leaves slip by while in here.
		_room=_mgr.join(_session.getHandle(),getProfile(_session.getAccountInfo()));
		seats=addListener();
		sendRoomInfo(seats);
	}

	/* (non-Javadoc)
	 * @see org.jbrain.qlink.state.QState#execute(org.jbrain.qlink.cmd.Command)
	 */
	public boolean execute(Action a) throws IOException {
		boolean rc=false;
		QState state;
		AccountInfo info;
		QHandle handle;
		
		if(a instanceof RequestGame) {
			int id=((RequestGame)a).getID();
			String name=((RequestGame)a).getTitle();
			String type=((RequestGame)a).getType();
			boolean order=((RequestGame)a).doesSystemPickOrder();
			_log.debug(_session.getHandle() + " wants to play " + name);
			state=new PlayGame(_session,_room,id,name,type,order);
			state.activate();
		} else if(a instanceof AcceptInvite) {
			Game game=_room.getPendingGame();
			state=new PlayGame(_session,game);
			state.activate();
		} else if(a instanceof DeclineInvite) {
			Game game=_room.getPendingGame();
			game.declineInvite();
		} else if(a instanceof ListRooms) {
			_log.debug("Listing Public rooms");
			rc=true;
			_rooms=_mgr.getRoomInfoList();
			_roomPos=0;
			sendRoomList();
		} else if(a instanceof ListMoreRooms) {
			sendRoomList();
		} else if(a instanceof ListGames) {
			_log.debug("Listing Games");
			rc=true;
			GameInfo[] games=_room.getGameInfoList();
			int i;
			if(games.length==0) {
				_session.send(new NoGames());
			} else {
				for(i=0;i<games.length-1;i++) {
					_session.send(new GameLine(games[i].getName(),games[i].getPlayOrder(),false));
				}
				_session.send(new GameLine(games[i].getName(),games[i].getPlayOrder(),true));
			}
		} else if(a instanceof EnterPublicRoom) {
			_log.debug("Entering public room");
			enterRoom(((EnterPublicRoom)a).getRoom(),true);
			rc=true;
		} else if(a instanceof EnterPrivateRoom) {
			_log.debug("Entering private room");
			rc=true;
			enterRoom(((EnterPrivateRoom)a).getRoom(),false);
		} else if(a instanceof LocateUser) {
			handle=new QHandle(((LocateUser)a).getData());
			_log.debug("Trying to locate user: '" + handle + "'");
			info=UserManager.getAccount(handle);
			if(info==null) {
				_log.debug("LOCATE Error: No such user");
				_session.send(new UserInvalid());
			} else if(!_session.getServer().isUserOnline(handle)) {
				_log.debug("LOCATE Error: User is not online");
				_session.send(new UserNotOnline());
			} else {
				RoomInfo room=_mgr.getUserLocation(handle);
				if(room==null) {
					_log.debug("LOCATE Error: User is unavailable");
					_session.send(new UserUnavailable());
				} else if(room.isPublicRoom()) {
					_log.debug("LOCATE Success:  User '" + handle + "' is in public room '" + room.getName() + "'");
					_session.send(new LocateUserText(room.getName()));
				} else {
					_log.debug("LOCATE Success:  User '" + handle + "' is in private room '" + room.getName() + "'");
					_session.send(new UserInPrivateRoom());
				}
			}
		} else if(a instanceof LeaveChat) {
			// we need to ack this.
			_log.debug("Leaving chat");
			leaveRoom();
			state=new DepartmentMenu(_session);
			state.activate();
		} else if(a instanceof IgnoreUser) {
			_log.debug("Ignoring user: " + ((IgnoreUser)a).getData());
			//_session.send(new IgnoreUser());
		} else if(a instanceof DeIgnoreUser) {
			_log.debug("Not Ignoring user: " + ((DeIgnoreUser)a).getData());
			//_session.send(new DeIgnoreUser());
		} else if(a instanceof EnterAuditorium) {
			enterAuditorium();
		} else if(a instanceof RequestToObserve) {
			handle=new QHandle(((RequestToObserve)a).getHandle());
			_log.debug("User requesting to observe " + handle + "'s game.");
			// we should ask permission, but no matter
			String name=((RequestToObserve)a).getHandle();
			state=new ObserveGame(_session, _room, new QHandle(name));
			state.activate();
		} else if(a instanceof EnterChat) {
			// we get this after coming back from game
			QSeat[] seats;
			synchronized(_room) {
				_listener.suspend();
				seats=_room.getSeatInfoList();
			}
			sendRoomInfo(seats);
		} else if(a instanceof QuestionNextLine) {
			_alQuestion.add(((QuestionNextLine)a).getData());
		} else if(a instanceof QuestionLastLine) {
			_alQuestion.add(((QuestionLastLine)a).getData());
			// we bypass the process function for this.
			_room.say((String[])_alQuestion.toArray(new String[_alQuestion.size()]));
			_alQuestion.clear();
		} else if(a instanceof IncludeMe) {
			_session.send(new PartnerSearchMessage("This is not implemented yet"));
		} else if(a instanceof ExcludeMe) {
			_session.send(new PartnerSearchMessage("This is not implemented yet"));
		} else if(a instanceof PartnerSearchStatusRequest) {
			_session.send(new PartnerSearchMessage("This is not implemented yet"));
		} else if(a instanceof CancelPartnerSearch) {
			_session.send(new PartnerSearchMessage("This is not implemented yet"));
		} else if(a instanceof FindPartners) {
			_log.debug(_session.getHandle() + " wants system to pick partners for " + ((FindPartners)a).getTitle());
			_session.send(new FindPartnersAck());
		} else if(a instanceof SelectPartner) {
			_log.debug("Adding " + ((SelectPartner)a).getHandle() + " to partner list");
			
		} else if(a instanceof FindMorePartners) {
			_log.debug("System needs to find  " + ((FindMorePartners)a).getNumberToFind());
			_session.send(new FindPartnersAck());
		} else if(a instanceof EnterBoxOffice) {
			// this is not correct...
			enterRoom("BoxOffice",false);
    		_session.send(new AuditoriumText("Heading",false));
    		_session.send(new AuditoriumText("    Item 1",false));
    		_session.send(new AuditoriumText("    Item 2",false));
    		_session.send(new AuditoriumText("    Item 3",true));
		} else if(a instanceof MakeReservation) {
			_log.debug("User made reservation for event: " + ((MakeReservation)a).getID());
    		_session.send(new AuditoriumText("This is not implements yet",true));
		} else if(a instanceof CancelReservation) {
			_log.debug("User canceled reservation for event: " + ((CancelReservation)a).getID());
    		_session.send(new AuditoriumText("This is not implemented yet",true));
		} else if(a instanceof EventInfo) {
			sendEventInfo();
		}
		if(!rc)
			rc=super.execute(a);
		return rc;
	}

	public void terminate() {
		// need to leave current room, and that's it.
		leaveRoom();
	}

	protected void sendRoomInfo(QSeat[] seats) {
		if(_room.isPublicRoom()) {
			_session.send(new EnterPublicRoom(_room.getName()));
		} else
			_session.send(new EnterPrivateRoom(_room.getName()));
		showSeats(seats,false);
	}

	/**
	 * @param room
	 * @param b
	 */
	
	protected void enterRoom(String name, boolean b) {
		QRoom room;
		QSeat user;
		int mySeat=0;
		QSeat[] seats;
		
		if(_room.getName().toLowerCase().equals(name.toLowerCase()) && _room.isPublicRoom()==b) {
			_log.debug("User changed to same room");
			synchronized(_room) {
				_listener.suspend();
				_log.debug("Getting seat information");
				seats=_room.getSeatInfoList();
			}
			showSeats(seats,true);
			_log.debug("Joining room: " + name);
		} else {
			room=_mgr.joinRoom(name,_session.getHandle(),getProfile(_session.getAccountInfo()),b);
			if(room==null) {
				_log.debug("QRoom is full");
				// send room is full.
				_session.send(new C2());
			} else {
				leaveRoom();
				// enter new room
				_room=room;
				seats=addListener();
				showSeats(seats,true);
			}
		}
	}
	
	protected void monitorRoom(String name, boolean b) {
		QRoom room;
		QSeat user;
		int mySeat=0;
		QSeat[] seats;
		
		if(!_room.getName().toLowerCase().equals(name.toLowerCase()) && _room.isPublicRoom()==b) {
			_log.debug("Monitoring room: " + name);
			room=_mgr.monitorRoom(name,_session.getHandle(),getProfile(_session.getAccountInfo()),b);
			leaveRoom();
			// enter new room
			_room=room;
			seats=addListener();
			showSeats(seats,true);
			
		} else {
			_log.debug("User changed to same room");
			synchronized(_room) {
				_listener.suspend();
				_log.debug("Getting seat information");
				seats=_room.getSeatInfoList();
			}
			showSeats(seats,true);
		}
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
				if(cmd.startsWith("mon") && _session.isStaff()) {
					// Monitor room;
					if(st.hasMoreTokens())
						name=st.nextToken("\n");
					if(name!= null) {
						_log.debug("Monitoring '" + name + "' public room ");
						monitorRoom(name,true);
					}
				} else {
					super.process(text);
				}
			} else {
				super.process(text);
			}
		} else {
			_room.say(text);
		}
	}
	
	/**
	 * 
	 */
	private void sendAuditoriumText() {
		_log.debug("Defining Auditorium text");
		String text=_room.getInfo();
		TextFormatter tf=new TextFormatter();
		tf.add(text);
		tf.add("\n     <PRESS F5 TO CONTINUE>");
    	_log.info("Sending Auditorium Text");
    	List l=tf.getList();
    	int size=l.size();
    	for(int i=0;i<size;i++) {
    		_session.send(new AuditoriumText((String)l.get(i),i+1==size));
    	}
	}

	/**
	 * 
	 */
	private void enterAuditorium() {
		QSeat user;
		QSeat[] seats;
		
		leaveRoom();
		_log.debug("Joining Auditorium");
		_room=_mgr.joinAuditorium(_session.getHandle(),getProfile(_session.getAccountInfo()));
		seats=addListener();
		sendRoomInfo(seats);
		sendAuditoriumText();
		if(_room.canTalk())
			_session.send(new AcceptingQuestions());
		else
			_session.send(new RejectingQuestions());
		
	}

	/**
	 * 
	 */
	private void sendRoomList() {
		for(int i=0;i<8&& _roomPos<_rooms.length;i++) {
			_session.send(new RoomLine(_rooms[_roomPos].getName(),_rooms[_roomPos].getPopulation(),_roomPos+1==_rooms.length));
			_roomPos++;
		}
		if(_roomPos<_rooms.length) {
			_session.send(new PauseRoomInfo("Press RETURN to continue, F5 to cancel"));
		}
	}

	/**
	 * 
	 */
	private void sendEventInfo() {
		// TODO Need to modify this to send speaker information
		sendAuditoriumText();
	}

}
