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
	Created on Sep 3, 2005
	
 */
package org.jbrain.qlink.chat;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;
import java.util.Vector;

import org.apache.log4j.Logger;
import org.jbrain.qlink.user.QHandle;

public class GameDelegate {
	private static Logger _log=Logger.getLogger(GameDelegate.class);
	private String _sName;
	private String _sType;
	private boolean _bSystemPickOrder;

	private RoomDelegate _room;
	private ArrayList _alPlayers = new ArrayList();
	private byte[] _seats;
	private ArrayList _listeners = new ArrayList();
	private int _iID;
	private ArrayList _alDeclineList = new ArrayList();
	private ArrayList _alAcceptList = new ArrayList();
	private ArrayList _alAbstainList = new ArrayList();
	private boolean _bActive=true;
	private Vector _vGameLog=new Vector();

	/**
	 * @param name
	 * @param type
	 * @param systemPickOrder
	 */
	public GameDelegate(RoomDelegate room, int id, String name, String type, boolean systemPickOrder) {
		_iID=id;
		_sName=name;
		_sType=type;
		_bSystemPickOrder=systemPickOrder;
		_room=room;
		_log.info("Creating new instance of " + name);
	}

	/**
	 * @param seat
	 * @throws UserMismatchException
	 * @throws UserNotInRoomException
	 */
	public boolean addPlayer(QHandle handle) throws UserNotInRoomException {
		QSeat info;
		synchronized(_room) {
			info=_room.addUserToGame(handle,this);
			if(info==null) {
				_log.debug("Could not add '" + handle + "' to game: " + _sName);
				return false;
			} else {
				// add to unacked invite list.
				synchronized(_alDeclineList) {
					_alPlayers.add(info);
					_alAbstainList.add(info);
				}
				return true;
			}
		}
	}

	/**
	 * @return
	 */
	public byte[] getPlayOrder() {
		List l;
		Random r=new Random();
		
		synchronized(_alDeclineList) {
			if(_bSystemPickOrder) {
				List orig=new ArrayList(_alPlayers);
				l=new ArrayList();
				while(orig.size()>0) {
					l.add(orig.remove(r.nextInt(orig.size())));
				}
			} else {
				l=_alPlayers;
			}
		}
		// if we need to sort, do it here.
		if(_seats==null) {
			_seats=new byte[l.size()];
			for(int i=0;i<_seats.length;i++) {
				_seats[i] = (byte)((SeatInfo)l.get(i)).getSeatID();
			}
		} 
		return _seats;
	}

	/**
	 * @return
	 */
	public SeatInfo[] getPlayers() {
		return (SeatInfo[])_alPlayers.toArray(new SeatInfo[0]);
	}

	/**
	 * 
	 */
	public void acceptInvite(QHandle handle) {
		QSeat seat=getGameSeatInfo(handle);
		if(seat!=null) {
			addAccept(seat);
			processEvent(new GameEvent(this,GameEvent.ACCEPT_INVITE, seat.getSeatID(),seat.getHandle().toString()));
		}
	}

	public void declineInvite(QHandle handle) {
		QSeat seat=getGameSeatInfo(handle);
		if(seat!=null) {
			addDecline(seat);
			processEvent(new GameEvent(this,GameEvent.DECLINE_INVITE, seat.getSeatID(),seat.getHandle().toString()));
		}
	}

	public boolean canContinue() {
		return _alAcceptList.size()==_alPlayers.size();
	}

	/**
	 * @return
	 */
	public String getType() {
		return _sType;
	}

	/**
	 * @return
	 */
	public boolean isSystemPickingOrder() {
		return _bSystemPickOrder;
	}

	/**
	 * @return
	 */
	public String getName() {
		return _sName;
	}

	/**
	 * @return
	 */
	public int getID() {
		return _iID;
	}

	public void terminate() {
		_log.info("Terminating instance of " + _sName);
		// let everyone watching this game know.
		processEvent(new GameTerminationEvent(this));
		synchronized(_alDeclineList) {
			while(_alPlayers.size()>0)
				removePlayer((SeatInfo)_alPlayers.get(0));
		}
		synchronized(_listeners) {
			_listeners.clear();
		}
		_room.destroyGame(this);
		_bActive=false;
	}

	/**
	 * @param _listener
	 */
	public void addListener(GameEventListener listener) {
		synchronized(_listeners) {
			_listeners.add(listener);
		}
	}

	/**
	 * @param listener
	 */
	public void removeListener(GameEventListener listener) {
		synchronized(_listeners) {
			_listeners.remove(listener);
		}
		
	}

	/**
	 * @param _handle
	 * @param text
	 */
	public void send(QHandle handle, String text) {
		QSeat seat=getGameSeatInfo(handle);
		if(seat!=null) {
			GameCommEvent event=new GameCommEvent(this,seat.getSeatID(),seat.getHandle().toString(),text);
			record(event);
			processEvent(event);
		}
	}

	/**
	 * @param _handle
	 */
	public void requestLoad(QHandle handle) {
		QSeat seat=getGameSeatInfo(handle);
		if(seat!=null) {
			clearVotes();
			processEvent(new GameEvent(this,GameEvent.REQUEST_LOAD, seat.getSeatID(),seat.getHandle().toString()));
		}
	}

	public void readyToStart(QHandle handle) {
		QSeat seat=getGameSeatInfo(handle);
		if(seat!=null) {
			addAccept(seat);
			processEvent(new GameEvent(this,GameEvent.READY_TO_START, seat.getSeatID(),seat.getHandle().toString()));
		}
	}

	/**
	 * 
	 */
	public void requestRestart(QHandle handle) {
		QSeat seat=getGameSeatInfo(handle);
		if(seat!=null) {
			clearVotes();
			// we alreayd want to restart...
			addAccept(seat);
			processEvent(new GameEvent(this,GameEvent.REQUEST_RESTART, seat.getSeatID(),seat.getHandle().toString()));
		}
	}

	/**
	 * 
	 */
	public void clearVotes() {
		synchronized(_alDeclineList) {
			_alDeclineList.clear();
			_alAcceptList.clear();
			_alAbstainList.clear();
			_alAbstainList.addAll(_alPlayers);
		}
	}

	/**
	 * @param _handle
	 */
	public void acceptRestart(QHandle handle) {
		QSeat seat=getGameSeatInfo(handle);
		if(seat!=null) {
			addAccept(seat);
			processEvent(new GameEvent(this,GameEvent.ACCEPT_RESTART, seat.getSeatID(),seat.getHandle().toString()));
		}
	}

	/**
	 * @return
	 */
	public List getAbstainList() {
		return Collections.unmodifiableList(_alAbstainList);
	}

	/**
	 * @param handle
	 * 
	 */
	public void leave(QHandle handle) {
		QSeat seat=getGameSeatInfo(handle);
		if(seat!=null) {
			_log.debug("Removing '" + seat.getHandle() + "' from game: " + _sName);
			removePlayer(seat);
			processEvent(new GameEvent(this,GameEvent.LEAVE_GAME, seat.getSeatID(),seat.getHandle().toString()));
			synchronized(_alDeclineList) {
				// is everyone gone?
				if(_alPlayers.size()==0)
					terminate();
			}
		} else if(seat!=null){
			_log.warn("Player '" + seat.getHandle() + "' not in game: " + _sName);
		} else {
			_log.warn("Null player tried to leave game");
			
		}
	}

	/**
	 * @param _handle
	 */
	public void restart(QHandle handle) {
		QSeat seat=getGameSeatInfo(handle);
		if(seat!=null) {
			// we need to re-order the players to have this person first.
			// for now, let's just shift everyone up by 1
			int i=_seats.length-1;
			while(i>0 && _seats[i]!=seat.getSeatID()) {
				i--;
			}
			while(i>0) {
				_seats[i] = _seats[i-1];
				i--;
			}
			_seats[0]=(byte)seat.getSeatID();
			StartGameEvent event=new StartGameEvent(this,seat,getPlayOrder());
			record(event);
			processEvent(event);
		}
	}

	/**
	 * @return
	 */
	public boolean isActive() {
		return _bActive;
	}

	/**
	 * 
	 */
	public void start(QHandle handle) {
		QSeat seat=getGameSeatInfo(handle);
		if(seat!=null) {
			StartGameEvent event=new StartGameEvent(this,seat,getPlayOrder());
			record(event);
			processEvent(event);
		}
	}

	/**
	 * @param _handle
	 */
	public void declineRestart(QHandle handle) {
		QSeat seat=getGameSeatInfo(handle);
		if(seat!=null) {
			addDecline(seat);
			processEvent(new GameEvent(this,GameEvent.DECLINE_RESTART, seat.getSeatID(),seat.getHandle().toString()));
		}
		
	}

	public List getGameLog() {
		return Collections.unmodifiableList(_vGameLog);
	}

	/**
	 * @param event
	 */
	protected void processGameCommEvent(GameCommEvent event) {
		if(event != null && _listeners.size() > 0) {
			for(int i=0,size=_listeners.size();i<size;i++) {
				((GameEventListener)_listeners.get(i)).gameSent(event);
			}
		}
	}

	protected void processStartGameEvent(StartGameEvent event) {
		if(event != null && _listeners.size() > 0) {
			for(int i=0,size=_listeners.size();i<size;i++) {
				((GameEventListener)_listeners.get(i)).gameStarted(event);
			}
		}
	}

	protected void processGameEvent(GameEvent event) {
		if(event != null && _listeners.size() > 0) {
			for(int i=0,size=_listeners.size();i<size;i++) {
				((GameEventListener)_listeners.get(i)).eventOccurred(event);
			}
		}
	}

	protected void processGameTerminationEvent(GameTerminationEvent event) {
		if(event != null && _listeners.size() > 0) {
			for(int i=0,size=_listeners.size();i<size;i++) {
				((GameEventListener)_listeners.get(i)).gameTerminated(event);
			}
		}
	}

	protected void processEvent(RoomEvent event) {
		synchronized(_listeners) {
			if(event instanceof GameCommEvent) 
				processGameCommEvent((GameCommEvent)event);
			else if(event instanceof GameEvent) 
				processGameEvent((GameEvent)event);
			else if(event instanceof GameTerminationEvent) 
				processGameTerminationEvent((GameTerminationEvent)event);
			else if(event instanceof StartGameEvent) 
				processStartGameEvent((StartGameEvent)event);
		}
	}
	
	/**
	 * @param seat
	 * @return
	 */
	
	private QSeat getGameSeatInfo(QHandle handle) {
		QSeat seat=_room.getSeatInfo(handle);
		if(seat!=null && _alPlayers.contains(seat))
			return seat;
		return null;
	}
	
	/**
	 * @param seat
	 */
	private void removePlayer(QSeat seat) {
		_room.removeUserFromGame(seat.getHandle());
		synchronized(_alDeclineList) {
			_alPlayers.remove(seat);
			_alAbstainList.remove(seat);
			_alDeclineList.remove(seat);
			_alAcceptList.remove(seat);
		}
	}

	/**
	 * @param seat
	 */
	private void addAccept(QSeat seat) {
		synchronized(_alDeclineList) {
			_alAcceptList.add(seat);
			_alAbstainList.remove(seat);
		}
	}

	/**
	 * @param seat
	 */
	private void addDecline(QSeat seat) {
		synchronized(_alDeclineList) {
			_alDeclineList.add(seat);
			_alAbstainList.remove(seat);
		}
	}

	/**
	 * @param object
	 */
	private void record(RoomEvent event) {
		_vGameLog.add(event);
	}
}
