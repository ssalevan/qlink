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

import org.apache.log4j.Logger;
import org.jbrain.qlink.user.QHandle;

public class RoomDelegate extends AbstractRoomDelegate {
	private static Logger _log=Logger.getLogger(RoomDelegate.class);
	public static final int ROOM_CAPACITY=23;
	protected SeatInfo[] _users=new SeatInfo[ROOM_CAPACITY];
	private GameDelegate[] _userGame = new GameDelegate[ROOM_CAPACITY];
	
	public RoomDelegate(String name, boolean bPublic, boolean bLocked) {
		super(name,bPublic,bLocked);
	}

	/**
	 * @param handle
	 * @param delegate
	 * @return
	 * @throws UserNotInRoomException
	 * @throws UserMismatchException
	 */
	public QSeat addUserToGame(QHandle handle, GameDelegate game) throws UserNotInRoomException {
		// we need to check seat and handle to make sure they match.
		synchronized(_htUsers) {
			SeatInfo info=(SeatInfo)getSeatInfo(handle);
			if(info==null)
				throw new UserNotInRoomException();
			if(!info.isInGame()) {
				info.setGameStatus(true);
				_userGame[info.getSeatID()]=game;
				return info;
			}
			return null;
		}
	}

	/* (non-Javadoc)
	 * @see org.jbrain.qlink.chat.AbstractRoomDelegate#getCapacity()
	 */
	public int getCapacity() {
		return ROOM_CAPACITY;
	}

	public QSeat[] getSeatInfoList(QHandle handle) {
		return (SeatInfo[])_htUsers.values().toArray(new SeatInfo[0]);
	
	}

	/**
	 * @return
	 */
	public GameInfo[] getGameInfoList() {
		int size;
		GameDelegate game;
		GameInfo[] info;
		synchronized(_alGames) {
			size=_alGames.size();
			info=new GameInfo[size];
			for(int i=0;i<size;i++) {
				game=(GameDelegate)_alGames.get(i);
				info[i]=new GameInfo(game.getName(),game.getPlayOrder());
			}
		}
		return info;
	}

	/* (non-Javadoc)
	 * @see org.jbrain.qlink.chat.QRoomDelegate#getExtSeatInfoList()
	 */
	public QSeat[] getExtSeatInfoList(QHandle handle) {
		return getSeatInfoList(handle);
	}

	/**
	 * @param delegate
	 */
	public void destroyGame(GameDelegate game) {
		// need to reset all users in game
		for(int i=0;i<ROOM_CAPACITY;i++) {
			if(_userGame[i]==game) {
				_users[i].setGameStatus(false);
				_userGame[i]=null;
			}
		}
		synchronized(_alGames) {
			_alGames.remove(game);
		}
	}

	public GameDelegate getGame(QHandle handle) {
		QSeat seat=getSeatInfo(handle);
		if(seat!=null)
			return _userGame[seat.getSeatID()];
		return null;
	}

	public void removeUserFromGame(QHandle handle) {
		synchronized(_htUsers) {
			QSeat user=getSeatInfo(handle);
			if(user!=null) {
				int seat=user.getSeatID();
				_userGame[seat]=null;
				_users[seat].setGameStatus(false);
			}
		}
		
	}

	/**
	 * @param name
	 * @param type
	 * @param systemPickOrder
	 * @return
	 */
	public GameDelegate createGame(int id, String name, String type, boolean systemPickOrder) {
		GameDelegate game=new GameDelegate(this,id,name,type,systemPickOrder);
		synchronized(_alGames) {
			_alGames.add(game);
		}
		return game;
	}

	/**
	 * @return
	 */
	public ObservedGame observeGame(QHandle handle) {
		QSeat info=getSeatInfo(handle);
		if(info!=null) {
			GameDelegate game=_userGame[info.getSeatID()];
			if(game!=null)
				return new ObservedGame(game);
		}
		return null;
	}

	/**
	 * @param handle
	 */
	public boolean addUser(QHandle handle, ChatProfile security) {
		synchronized(_htUsers) {
			QSeat user=getSeatInfo(handle);
			if(user==null) {
				if(!isFull()) {
					for(int i=0;i<ROOM_CAPACITY;i++){
						if(_users[i]==null) {
							user=new SeatInfo(handle,i,security);
							takeSeat(user);
							return true;
						}
					}
				}
				return false;
			} else {
				if(_log.isDebugEnabled())
					_log.warn("'" + handle + "' is already in room: " + getName());
				return true;
			}
		}
	}

	/* (non-Javadoc)
	 * @see org.jbrain.qlink.chat.QRoomDelegate#isManagedRoom()
	 */
	public boolean isManagedRoom() {
		return true;
	}

	public void leave(QHandle handle) {
		synchronized(_htUsers) {
			QSeat seat=getSeatInfo(handle);
			// was this seat filled?
			if(seat!=null) {
				// are they in a game?
				if(_userGame[seat.getSeatID()]!= null) {
					_userGame[seat.getSeatID()].leave(handle);
				}
			}
		}
		super.leave(handle);
	}

	/**
	 * @param user
	 */
	protected void takeSeat(QSeat user) {
		_users[user.getSeatID()]=(SeatInfo)user;
		super.takeSeat(user);
	}

	/**
	 * @param user
	 */
	protected void leaveSeat(QSeat user) {
		_users[user.getSeatID()]=null;
		super.leaveSeat(user);
	}

	/* (non-Javadoc)
	 * @see org.jbrain.qlink.chat.AbstractRoomDelegate#send(org.jbrain.qlink.chat.RoomEvent)
	 */
	protected void send(RoomEvent event) {
		// no outside integration, so loop.
		processEvent(event);
	}

}
