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
import java.util.Timer;
import java.util.TimerTask;

import org.apache.log4j.Logger;
import org.jbrain.qlink.*;
import org.jbrain.qlink.chat.*;
import org.jbrain.qlink.cmd.action.*;
import org.jbrain.qlink.user.QHandle;

public class PlayGame extends AbstractPhaseState {
	private static Logger _log=Logger.getLogger(PlayGame.class);
	private static Timer _timer=new Timer();

	/**
	 * 
	 * @uml.property name="_intState"
	 * @uml.associationEnd multiplicity="(0 1)"
	 */
	private QState _intState;

	private boolean _bSystemPickOrder;
	private String _sType;
	private String _sName;

	/**
	 * 
	 * @uml.property name="_room"
	 * @uml.associationEnd multiplicity="(0 1)"
	 */
	private QRoom _room;

	/**
	 * 
	 * @uml.property name="_game"
	 * @uml.associationEnd multiplicity="(0 1)"
	 */
	private Game _game;

	private boolean _bInvited;
	private int _iGameID;

	/**
	 * 
	 * @uml.property name="_alInvitees"
	 * @uml.associationEnd elementType="org.jbrain.qlink.cmd.action.GamePlayer" multiplicity=
	 * "(0 -1)"
	 */
	private ArrayList _alInvitees = new ArrayList();

	private TimerTask _timerTask;
	private boolean _bRequestRestart=false;
	private static final int PHASE_INVITE = 1;
	private static final int PHASE_ACCEPT_INVITE = 2;
	private static final int PHASE_PLAYING = 3;
	private static final int PHASE_REQUEST_LOAD = 4;
	protected static final int PHASE_LOADING = 5;
	protected static final int PHASE_READY_TO_START = 6;
	protected static final int PHASE_REQUEST_RESTART = 7;

	private class InviteTimeoutTask extends TimerTask {
		public void run() {
			SeatInfo info;
			SeatInfo[] seats;
			
			if(!_game.canContinue()) {
				// too much time has elapsed...
				_log.debug("Timeout occurred");
				List l=_game.getAbstainList();
				// did some folks not respond?
				if(l.size()>0) {
					// we have players not yet hooked to the game.
					seats=_game.getPlayers();
					for(int i=0,size=seats.length;i<size;i++) {
						// send error to all players.
						_session.getServer().sendToUser(seats[i].getHandle(),new GameCannotBeInitiated());
					}
					for(int i=0,size=l.size();i<size;i++) {
						// send list of un acked players.
						info=(SeatInfo)l.get(i);
						if(_log.isDebugEnabled()) 
							_log.debug(info.getHandle() + " did not respond to invitation." );
						_session.send(new PlayerNoResponse(info.getSeatID()));
					}
					// this will restore our state, in the handler.
					_game.terminate();
				} else {
					_log.warn("For reason, we have no abstains, but timer is still running and we cannot continue");
					_game.terminate();
				}
			}
		}
	};

	/**
	 * 
	 * @uml.property name="_listener"
	 * @uml.associationEnd multiplicity="(1 1)"
	 */
	private GameEventListener _listener = new GameEventListener() {

		public void gameSent(GameCommEvent event) {
			if (!_session.getHandle().equals(event.getName())) {
				if (_log.isDebugEnabled())
					_log.debug("Seat: "
						+ event.getSeatID()
						+ " sent game data: '"
						+ event.getText()
						+ "'");
				_session.send(new GameSend(event.getSeatID(), event.getText()));
			}
		}

		public void eventOccurred(GameEvent event) {
			switch (event.getType()) {
				case GameEvent.LEAVE_GAME :
					if (!_session.getHandle().equals(event.getName())) {
						_log.debug(event.getName() + " left game");
						// if we are playing the game, and someone leaves, let the other user know.
						_session.send(new PlayerLeftGame(event.getName()));
					}
					break;
				case GameEvent.ACCEPT_INVITE :
					if (!_bInvited) {
						_log.debug(event.getName() + " accepted game invite");
						if (_game.canContinue()) {
							if (_timerTask != null) {
								_timerTask.cancel();
								_timerTask = null;
							}
							setPhase(PHASE_REQUEST_LOAD);
							_game.requestLoad();
						}
					}
					break;
				case GameEvent.DECLINE_INVITE :
					if (!_bInvited) {
						_log.debug(event.getName() + " declined game invite");
						_session.send(new PlayerDeclinedInvite(event.getSeatID()));
						if (_game.getAbstainList().size() == 0) {
							//everyone either accepted or declined.  delete game and send errors out.
							if (_timerTask != null) {
								_timerTask.cancel();
								_timerTask = null;
							}
							_game.terminate();
						}
					}
					break;
				case GameEvent.REQUEST_LOAD :
					_log.debug("Sending game load command");
				_session.send(new LoadGame());
					setPhase(PHASE_LOADING);
					break;
				case GameEvent.READY_TO_START :
					setPhase(PHASE_READY_TO_START);
					if (!_bInvited) {
						_log.debug(event.getName()
							+ " loaded the game and requests the start");
						if (_game.canContinue()) {
							_game.start();
						}
					}
					break;
				case GameEvent.REQUEST_RESTART :
					if (!_bRequestRestart) {
						_log.debug(event.getName()
							+ " requests a game restart");
						_session.send(new RequestGameRestart());
						setPhase(PHASE_REQUEST_RESTART);
					}
					break;
				case GameEvent.ACCEPT_RESTART :
					_log.debug(event.getName() + " accepts a game restart");
					if (_bRequestRestart && _game.canContinue()) {
						_session.send(new RestartGame());
						_log.debug("Restarting requestor");
					}
					break;
				case GameEvent.DECLINE_RESTART :
					_log.debug(event.getName() + " declined a game restart");
					if (_bRequestRestart) {
						_session.send(new DeclineRestart());
					}
					break;
			}
		}

		public void gameStarted(StartGameEvent event) {
			_log.debug("Game is (re)starting");
			setPhase(PHASE_PLAYING);
			_session.send(new StartGame("GAME", event.getPlayOrder()));
		}

		public void gameTerminated(GameTerminationEvent event) {
			_log.debug("Game has been terminated, restoring state");
			// should we send the Error commands here?
			restoreState();
		}

	};

	public PlayGame(QSession session, Game game) {
		super(session, PHASE_ACCEPT_INVITE);
		_game=game;
		_bInvited=true;
	}
	
	/**
	 * 
	 */
	protected void restoreState() {
		if(_game.isActive()) {
			_game.removeListener(_listener);
			_game.leave();
		}
		_session.setState(_intState);
		_session.enableOLMs(true);
	}

	public PlayGame(QSession session, QRoom room, int id, String name, String type, boolean bSystemPickOrder) {
		super(session, PHASE_INVITE);
		_bSystemPickOrder=bSystemPickOrder;
		_sType=type;
		_sName=name;
		_room=room;
		_iGameID=id;
		_bInvited=false;
}
	
	public void activate() throws IOException {
		_session.enableOLMs(false);
		if(!_bInvited) {
			_log.debug("User request to play a game");
			_game=_room.createGame(_iGameID,_sName,_sType,_bSystemPickOrder);
			if(_game!=null) {
				_log.debug("Game service successfully created");
				// we'll add listener later
				_intState=_session.getState();
				super.activate();
			} else {
				_log.debug("Game service creation failed");
			}
		} else {
			_log.debug("User invited to play a game");
			if(_game!=null) {
				_game.addListener(_listener);
				_intState=_session.getState();
				super.activate();
				// we are already in ACCEPT_INVITE state;
				_game.acceptInvite();
			} else {
				_log.debug("Game no longer active.  Must have timed out during invite");
				_session.send(new GameError("Game invitation cancelled due to timeout"));
				
			}
		}
	}
	

	public boolean execute(Action a) throws IOException {
		boolean rc=false;
		byte[] seats;
		String handle;
		
		if(!_bInvited) {
			if(a instanceof GameNextPlayer) {
				handle=((GamePlayer)a).getHandle();
				if(_log.isDebugEnabled())
					_log.debug(_session.getHandle() + " invites " + handle + " to play " +_sName);
				
				_alInvitees.add(a);
				rc=true;
			} else if(a instanceof GameLastPlayer) {
				rc=true;
				handle=((GamePlayer)a).getHandle();
				if(_log.isDebugEnabled())
					_log.debug(_session.getHandle() + " invites " + handle + " to play " +_sName);
				_alInvitees.add(a);
				invitePlayers();
			}
		}
		if(!rc){
			if(a instanceof GameMove) {
				_log.debug("Game sent data");
				_game.send(((GameMove)a).getText());
				rc=true;
			} else if(a instanceof RequestGameStart) {
				_log.debug("Loaded game, ready to play");
				_game.readyToStart();
				rc=true;
			} else if(a instanceof RequestGameRestart) {
				_log.debug("Request restart game");
				// set this so we do not process the restart request.
				_bRequestRestart=true;
				setPhase(PHASE_REQUEST_RESTART);
				_game.requestRestart();
				rc=true;
			} else if(a instanceof AcceptRestart) {
				_log.debug("Accept restart game");
				_game.acceptRestart();
				rc=true;
			} else if(a instanceof DeclineRestart) {
				_log.debug("Decline restart game");
				_game.declineRestart();
				rc=true;
			} else if(a instanceof LeaveGame) {
				_log.debug("Player is leaving game");
				restoreState();
				rc=true;
			} else if(a instanceof RestartGameAck) {
				_log.debug("Restart game acknowledged");
				_game.restart();
				rc=true;
			} else { 
				rc=_intState.execute(a);
			}
		}
		return rc;
	}


	/**
	 * 
	 */
	private void invitePlayers() throws IOException {
		QHandle handle;
		SeatInfo[] players;
		byte[] seats;
		GamePlayer invitee;
		
		// are all of them free to play and present?
		_log.debug("Checking invite list for issues");
		for(int i=0;i<_alInvitees.size();i++) {
			// add player
			invitee=(GamePlayer)_alInvitees.get(i);
			handle=new QHandle(invitee.getHandle());
			try {
				if(!_game.addPlayer(handle)) {
					// they are already in a pending game
					_log.debug(handle + "is already in a game, shutting down game.");
					_session.send(new PlayerInGameError(invitee.getSeat()));
					_game.terminate();
					break;
				}
			} catch (UserNotInRoomException e) {
				// player has left before we could invite him/her
				_log.debug(handle + "is not in room, shutting down game.");
				_session.send(new PlayerNotInRoomError(handle.toString()));
				_game.terminate();
				break;
			}
		}
		// is the game still active?
		if(_game.isActive()) {
			// we add the listener here.  Someone could leave between adding them and this, but we'd wait for timeout
			// anyway, and you can't send a PlayerLeftError during invite, I do not think.
			_game.addListener(_listener);
			players=_game.getPlayers();
			// get my seat number.
			int seat=_room.getSeatInfo(_session.getHandle()).getSeatID();
			seats=_game.getPlayOrder();
			// move to next step of game.
			for(int i=0;i<players.length;i++) {
				// we have to send directly to users, no game listeners yet.
				if(!players[i].getHandle().equals(_session.getHandle())) {
					_session.getServer().sendToUser(players[i].getHandle(),new InviteToGame(_bSystemPickOrder, seat, _iGameID, _sName, seats));
				}
			}
			_session.send(new PrepGame(seats));
			_log.debug("Setting timeout for responses");
			// need to set a timer...
			_timerTask=new InviteTimeoutTask(); 
			// schedule it for 30 seconds.
			_timer.schedule(_timerTask,30000);
			// accept the pseudoInvite for our client.
			_game.acceptInvite();
			setPhase(PHASE_ACCEPT_INVITE);
		} else {
			_log.debug("No players to invite, switching back to previous state");
			restoreState();
		}
	}

	public void terminate() {
		// go ahead and leave and remove the listener
		restoreState();
		_session.enableOLMs(false);
		if(_timerTask!=null)
			_timerTask.run();
		if(!_bInvited && _game.isActive()) {
			_game.terminate();
		}
		_intState.terminate();
	}
}
