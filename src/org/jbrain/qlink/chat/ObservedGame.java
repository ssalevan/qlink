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
	Created on Sep 6, 2005
	
 */
package org.jbrain.qlink.chat;

import java.util.List;


public class ObservedGame {

	private GameDelegate _game;

	public ObservedGame(GameDelegate delegate) {
		_game=delegate;
	}

	/**
	 * @param _listener
	 */
	public void addListener(ObservedGameEventListener listener) {
		RoomEvent event;
		synchronized(_game) {
			List l=_game.getGameLog();
			for(int i=0,size=l.size();i<size;i++) {
				event=((RoomEvent)l.get(i));
				if(event instanceof GameEvent)
					listener.eventOccurred((GameEvent)event);
				else if(event instanceof GameCommEvent)
					listener.gameSent((GameCommEvent)event);
				else if(event instanceof GameTerminationEvent)
					listener.gameTerminated((GameTerminationEvent)event);
				else if(event instanceof StartGameEvent)
					listener.gameStarted((StartGameEvent)event);
			}
			listener.movesCaughtUp( new CaughtUpEvent(this));
			_game.addListener(listener);
		}
		
	}

	/**
	 * @return
	 */
	public SeatInfo[] getPlayers() {
		return _game.getPlayers();
	}

	/**
	 * @return
	 */
	public byte[] getPlayOrder() {
		return _game.getPlayOrder();
	}

	/**
	 * 
	 */
	public void terminate() {
		_game.terminate();
	}


	/**
	 * @param _listener
	 */
	public void removeListener(GameEventListener listener) {
		_game.removeListener(listener);
		
	}

	public List getAbstainList() {
		return _game.getAbstainList();
	}

	public boolean isActive() {
		return _game.isActive();
	}

	/**
	 * @return
	 */
	public String getName() {
		return _game.getName();
	}

	/**
	 * @return
	 */
	public int getID() {
		return _game.getID();
	}

}
