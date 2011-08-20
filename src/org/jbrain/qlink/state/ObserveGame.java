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
import java.util.Vector;

import org.apache.log4j.Logger;
import org.jbrain.qlink.*;
import org.jbrain.qlink.chat.*;
import org.jbrain.qlink.cmd.action.*;
import org.jbrain.qlink.user.QHandle;

public class ObserveGame extends AbstractState {
	private static Logger _log=Logger.getLogger(ObserveGame.class);
	private QState _intState;
	private QRoom _room;
	private ObservedGame _game;
	private QHandle _handle;
	private int _iSeat;
	
	class QueuedGameListener implements ObservedGameEventListener {
		private boolean _bCaughtUp=false;
		private boolean _bSuspended=false;
		private Vector v=new Vector();
		private PlayBackMoves _pm=null;

		private void suspend() {
			_bSuspended=true;
		}
		
		public void resume() {
			_bSuspended=false;
			dequeue();
		}
		
		public void movesCaughtUp(CaughtUpEvent event) {
			if(_pm!=null) {
				v.add(_pm);
				_pm=null;
			}
			_log.debug("Moves are caught up");
			v.add(new NoMoreMoves());
			dequeue();
			
		}

		/**
		 * @param _pm2
		 */
		private void enqueue(Action a) {
			if(_bCaughtUp)
				v.add(new PlayBackMoves(a));
			else if(_pm==null)
				_pm=new PlayBackMoves(a);
			else if (!_pm.add(a)) {
				v.add(_pm);
				_pm=new PlayBackMoves(a);
			}
			dequeue();
		}

		/**
		 * 
		 */
		private void dequeue() {
			Action a;
			if(v.size()!=0 && !_bSuspended) {
				a=(Action)v.remove(0);
				_session.send(a);
				if(a instanceof NoMoreMoves) {
					_bCaughtUp=true;
				} else {
					_bSuspended=true;
				}
			}
		}

		public void gameSent(GameCommEvent event) {
			if (_log.isDebugEnabled())
				_log.debug("Seat: "
					+ event.getSeatID()
					+ " sent game data: '"
					+ event.getText()
					+ "'");
			enqueue(new GameSend(event.getSeatID(), event.getText()));
		}

		public void eventOccurred(GameEvent event) {
			switch (event.getType()) {
				case GameEvent.LEAVE_GAME :
					_log.debug(event.getName() + " left game");
					break;
			}
		}

		public void gameTerminated(GameTerminationEvent event) {
			_log.debug("Game has been terminated, restoring state");
			//restoreState();
		}

		/* (non-Javadoc)
		 * @see org.jbrain.qlink.chat.GameEventListener#gameStarted(org.jbrain.qlink.chat.StartGameEvent)
		 */
		public void gameStarted(StartGameEvent event) {
			_log.debug(event.getSeat().getHandle() + " started game");
			enqueue(new StartGame("GAME",event.getPlayOrder()));
		}

	};

	private QueuedGameListener _listener=new QueuedGameListener();
	public ObserveGame(QSession session, QRoom room, QHandle handle) {
		super(session);
		_room=room;
		_handle=handle;
	}
	
	/**
	 * 
	 */
	protected void restoreState() {
		if(_game != null && _game.isActive()) {
			_game.removeListener(_listener);
		}
		_session.setState(_intState);
		_session.enableOLMs(true);
	}

	public void activate() throws IOException {
		_log.debug("Accessing game for '" + _handle + "'");
		QSeat info=_room.getSeatInfo(_handle);
		if(info==null) {
			_log.debug("'" + _handle + "' is not in room");
			// need to do something here.
		} else {
			_iSeat=info.getSeatID();
			_game=_room.observeGame(_handle);
			if(_game==null) {
				_log.debug("'" + _handle + "' is not in game");
				// need to do something here.
			} else {
				_session.enableOLMs(false);
				_intState=_session.getState();
				super.activate();
				_session.send(new LoadObservedGame(_game.getID(),_game.getName(), _game.getPlayOrder()));
			}
		}
	}
	

	public boolean execute(Action a) throws IOException {
		boolean rc=false;
		
		if(a instanceof RequestGameStart) {
			_session.send(new StartObservedGame(_iSeat));
			_game.addListener(_listener);
		} else if(a instanceof PlayBackMovesAck) {
			_listener.resume();
		} else
			rc=_intState.execute(a);
		return rc;
	}


	public void terminate() {
		// go ahead and leave and remove the listener
		restoreState();
		_session.enableOLMs(false);
		_intState.terminate();
	}
}
