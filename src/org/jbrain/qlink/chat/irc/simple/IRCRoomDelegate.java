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
	Created on Oct 2, 2005
	
 */
package org.jbrain.qlink.chat.irc.simple;

import java.util.*;

import org.apache.log4j.Logger;
import org.jbrain.qlink.chat.*;
import org.jbrain.qlink.text.TextFormatter;
import org.jbrain.qlink.user.QHandle;
import org.jbrain.qlink.util.QuotedStringTokenizer;

import f00f.net.irc.martyr.*;
import f00f.net.irc.martyr.clientstate.Channel;
import f00f.net.irc.martyr.clientstate.Member;
import f00f.net.irc.martyr.commands.*;
import f00f.net.irc.martyr.replies.NamesEndReply;
import f00f.net.irc.martyr.services.*;


public class IRCRoomDelegate extends AbstractRoomDelegate {
	private static Logger _log=Logger.getLogger(IRCRoomDelegate.class);
	private static String SERVER_DNS;
	private static String SERVER_NICK="Q-Link";
	private static IRCConnection _ircConn=null;
    private static AutoReconnect _autoReconnect;
	
	private static Hashtable _htRooms=new Hashtable();
	
	private HashSet _hsIRCUsers=new HashSet();
	private AutoJoin _autoJoin;
	private String _sChannel;
	protected static boolean _bConnected;
	protected boolean _bJoined;
	
	static {
		SERVER_DNS=System.getProperty("qlink.chat.irc.server");
		if(SERVER_DNS==null || SERVER_DNS.equals(""))
			SERVER_DNS="localhost";
	}
	
    class ConnectThread extends Thread
    {

        public void run()
        {
            _autoReconnect.go(SERVER_DNS, 6667);
        }

        public ConnectThread()
        {
            setDaemon(true);
            start();
        }
    }


	private static Observer _listener=new Observer() {

		public void update(Observable arg0, Object arg1) {
			processIRCCommand(arg1);
		}
		
	};
	private static Observer _stateListener = new Observer() {

		public void update(Observable obj, Object event) {
			IRCRoomDelegate room;
			if(event==State.UNCONNECTED) {
				_log.debug("IRC server disconnected");
				Iterator i=_htRooms.values().iterator();
				while(i.hasNext()) {
					room=(IRCRoomDelegate)i.next();
					room.clearIRCUsers();
					room.setJoinedStatus(false);
				}
				_bConnected=false;
			} else if(event==State.UNREGISTERED || event==State.REGISTERED) {
				_log.debug("We have been connected to the server");
				_bConnected=true;
			} else {
				_log.debug("Unhandled state received: "+ event);
			}
		}
		
	};
	
	/**
	 * 
	 */
	
	public IRCRoomDelegate(String name, boolean bPublic, boolean bLocked) {
		super(name.substring(0,4).toUpperCase() + name.substring(4),bPublic,bLocked);
		// fix name.
		_sChannel="#"+ getName().substring(4).replaceAll(" ","-");
		synchronized(IRCRoomDelegate.class) {
	        if(_ircConn == null) {
	            connect();
	        }
		}
		if(_htRooms.containsKey(_sChannel)) {
			_log.error("We already have an IRC room for: " + _sChannel);
		}
		_htRooms.put(_sChannel,this);
		_autoJoin = new AutoJoin( _ircConn, _sChannel );
	}
	

	/**
	 * 
	 */
	protected void clearIRCUsers() {
		_hsIRCUsers.clear();
	}


	/* (non-Javadoc)
	 * @see org.jbrain.qlink.chat.QRoomDelegate#addUser(org.jbrain.qlink.user.QHandle, org.jbrain.qlink.chat.ChatProfile)
	 */
	public boolean addUser(QHandle handle, ChatProfile security) {
		SeatInfo seat=new SeatInfo(handle,-1,security);
		takeSeat(seat);
		return true;
	}


	public QSeat[] getSeatInfoList(QHandle handle) {
		QSeat[] seats=new QSeat[1];
		QSeat seat=getSeatInfo(handle);
		if(seat!=null)
			seats[0]=seat;
		else {
			_log.error("Seat Information requested by user not in room");
			seats[0]=new SeatInfo(handle,-1,new ChatProfile());
		}
		return seats;
	
	}


	/* (non-Javadoc)
	 * @see org.jbrain.qlink.chat.AbstractRoomDelegate#getCapacity()
	 */
	public int getCapacity() {
		return 0;
	}

	public GameDelegate createGame(int id, String name, String type, boolean systemPickOrder) {	return null; }
	public QSeat addUserToGame(QHandle handle, GameDelegate game) throws UserNotInRoomException { return null; }
	public void removeUserFromGame(QHandle handle) {}
	public GameDelegate getGame(QHandle handle) { return null; }
	public void destroyGame(GameDelegate game) {}
	public ObservedGame observeGame(QHandle handle) { return null; }


	/* (non-Javadoc)
	 * @see org.jbrain.qlink.chat.QRoomDelegate#getExtSeatInfoList(org.jbrain.qlink.chat.QSeat)
	 */
	public QSeat[] getExtSeatInfoList(QHandle handle) {
		List l=new ArrayList();
		Channel chan=_ircConn.getClientState().getChannel(_sChannel);
		if(chan!=null) {
			Enumeration enum=chan.getMembers();
			Member m;
			while(enum.hasMoreElements()) {
				m=(Member)enum.nextElement();
				if(!m.getNick().equals(SERVER_NICK)) {
					l.add(new SeatInfo(new QHandle(fix(m.getNick().getNick()))));
				}
			}
		}
		l.addAll(_htUsers.values());
		return (QSeat[])l.toArray(new SeatInfo[0]);
	}

	//public boolean changeUserName(QHandle oldHandle, QHandle handle, ChatProfile profile) {
	//	String text=fix(oldHandle.toString()) + " is now known as " + fix(handle.toString());
	//	//sendText("",text);
	//	return super.changeUserName(oldHandle,handle,profile);
	//}
	/**
	 * @param room
	 * @param channel
	 */
	
	protected void processCommand(SeatInfo info, String text) {
		ArrayList alMsg=new ArrayList();
		String error=null;
		String name=null,msg=null;
		QHandle handle;
		
		if(text != null && text.length()>0) {
			QuotedStringTokenizer st=new QuotedStringTokenizer(text);
			String cmd=st.nextToken(" ").toLowerCase();
			int pos=0;
			if(cmd.startsWith("topic")) {
				// Send topic;
				if(st.hasMoreTokens())
					msg=st.nextToken("\n");
				if(msg!= null) {
					_log.debug("Executing '" + text + "' from '" + info.getHandle() + "'");
					if(_bJoined) 
						sendIRCCommand(new TopicCommand(_sChannel,msg));
					else
						error="Error: not connected to server";
				}
			} else {
				super.processCommand(info,text);
			}
		} else {
			error="Error: no command specified";
		}
		if(error!=null) {
			alMsg.add(error);
			sendSystemMessage(info,alMsg);
		}
	}
	/* (non-Javadoc)
	 * @see org.jbrain.qlink.chat.AbstractRoomDelegate#send(org.jbrain.qlink.chat.RoomEvent)
	 */
	protected void send(RoomEvent event) {
		if(event instanceof JoinEvent) {
			if(((JoinEvent)event).getType()==JoinEvent.EVENT_JOIN) {
				// we need to send a "Joined..." messahge to IRC and to the channel.
				processEvent(new JoinEvent(this,JoinEvent.EVENT_JOIN,23,((JoinEvent)event).getName()));
				processEvent(new ChatEvent(this,-1,"","*" + ((JoinEvent)event).getName() + " enters the room"));
				if(_bJoined)
					sendJoinInfo(((JoinEvent)event).getName());
			} else {
				// we need to send a "Joined..." messahge to IRC and to the channel.
				//processEvent(new JoinEvent(this,JoinEvent.EVENT_LEAVE,22,((JoinEvent)event).getName()));
				processEvent(new ChatEvent(this,-1,"","*" + ((JoinEvent)event).getName() + " leaves the room"));
				if(_bJoined)
					sendIRCCommand(new MessageCommand(_sChannel,"Left QRoom: " + ((JoinEvent)event).getName()));
			}
		} else if(event instanceof ChatEvent) {
			processEvent((ChatEvent)event);
			if(_bJoined) {
				String name=((ChatEvent)event).getName();
				if(name==null || name.equals(""))
					sendIRCCommand(new MessageCommand(_sChannel,((ChatEvent)event).getText()));
				else
					sendIRCCommand(new MessageCommand(_sChannel,"{" + name + "} " + ((ChatEvent)event).getText()));
			}
		} else if(event instanceof SystemMessageEvent)
			// these will always go back to users on QLink.
			processEvent(event);
	}


	/**
	 * @param name
	 */
	private void sendJoinInfo(String name) {
		_log.debug("Sending join information to " + _sChannel + " for " + name);
		sendIRCCommand(new MessageCommand(_sChannel,"Entered QRoom: " + name ));
	}


	/**
	 * @param b
	 */
	private void setJoinedStatus(boolean b) {
		_bJoined=b;
	}


	/**
	 * @param channel
	 * @return
	 */
	private static IRCRoomDelegate getRoom(String channel) {
		return (IRCRoomDelegate)_htRooms.get(channel.toLowerCase());
	}


	/**
	 * @param arg1
	 */
	private static void processIRCCommand(Object arg1) {
		
		if(arg1 instanceof CtcpMessage) {
			CtcpMessage msg=(CtcpMessage)arg1;
			IRCRoomDelegate room=getRoom(msg.getDest());
			if(room!=null) {
				// this will not work perfect if the line > 97 chars, but who writes
				// an action that long...
				room.sendText("","*" + msg.getSource().getNick() +" " +  msg.getMessage());
			} else {
				_log.warn("Action received for unknown room: " + msg.getDest());
			}
		} else if(arg1 instanceof MessageCommand) {
			MessageCommand msg= (MessageCommand)arg1;
			IRCRoomDelegate room=getRoom(msg.getDest());
			if(room!=null) {
				room.sendText(msg.getSource().getNick(),msg.getMessage());
			} else {
				_log.warn("Message received for unknown room: " + msg.getDest());
			}
		} else if(arg1 instanceof JoinCommand) {
			JoinCommand cmd=(JoinCommand)arg1;
			IRCRoomDelegate room=getRoom(cmd.getChannel());
			if(room!=null) {
				if(cmd.getUser().equals(SERVER_NICK)) {
					_log.debug("Sending join information to channel");
					// print joins for all the users in here.
					Iterator i=room._htUsers.keySet().iterator();
					while(i.hasNext()) {
						room.sendJoinInfo(((SeatInfo)room._htUsers.get(i.next())).getHandle().toString());
					}
					room.setJoinedStatus(true);
				} else {
					room.processEvent(new JoinEvent(room,JoinEvent.EVENT_JOIN,23,fix(cmd.getUser().toString())));
					room.sendText("","*" + fix(cmd.getUser().toString()) + " enters the room");
					room.addIRCUser(cmd.getUser().getNick());
				}
			} else {
				_log.warn("Received JOIN for unrecognized room: " + cmd.getChannel());
			}
		} else if(arg1 instanceof NickCommand) {
			NickCommand cmd=(NickCommand)arg1;
			_log.debug(cmd.getOldNick() + " is now known as " + cmd.getNick());
			Enumeration enum=_ircConn.getClientState().getChannels();
			Channel c;
			while(enum.hasMoreElements()) {
				c=(Channel)enum.nextElement();
				if(c.findMember(cmd.getNick())!=null) {
					IRCRoomDelegate room=getRoom(c.getName());
					if(room!=null) {
						room.sendText("",fix(cmd.getOldNick()) + " is now known as " + fix(cmd.getNick()));
						room.removeIRCUser(cmd.getOldNick());
						room.addIRCUser(cmd.getNick());
					} else {
						_log.warn("Can't find user '" + cmd.getNick() + " in room: " + c.getName());
					}
				}
			}
		} else if(arg1 instanceof NamesEndReply) {
			NamesEndReply end=(NamesEndReply)arg1;
			_log.debug("Received name list for room: " + end.getChannel());
			IRCRoomDelegate room=getRoom(end.getChannel());
			if(room!=null) {
				Channel chan=_ircConn.getClientState().getChannel(end.getChannel());
				Enumeration enum=chan.getMembers();
				Member m;
				while(enum.hasMoreElements()) {
					m=(Member)enum.nextElement();
					if(!m.getNick().equals(SERVER_NICK)) {
						room.addIRCUser(m.getNick().getNick());
					}
				}
			} else {
				_log.warn("Received name list for unrecognized room: " + end.getChannel());
				
			}
		} else if (arg1 instanceof PartCommand) {
			PartCommand cmd=(PartCommand)arg1;
			IRCRoomDelegate room=getRoom(cmd.getChannel());
			if(room!=null) {
				// the below crashes the client.
				//room.processEvent(new JoinEvent(room,JoinEvent.EVENT_LEAVE,22,cmd.getUser().toString()));
				room.sendText("","*" + fix(cmd.getUser().toString()) + " leaves the room");
				room.removeIRCUser(cmd.getUser().getNick());
			} else {
				_log.warn("Received PART for unrecognized room: " + cmd.getChannel());
			}
		} else if(arg1 instanceof QuitCommand) {
			QuitCommand cmd=(QuitCommand)arg1;
			// handle Quit like Leave.
			Enumeration enum=_ircConn.getClientState().getChannels();
			Channel c;
			while(enum.hasMoreElements()) {
				c=(Channel)enum.nextElement();
				IRCRoomDelegate room=getRoom(c.getName());
				if(room!=null && room.getIRCUsers().contains(cmd.getUser().getNick())) {
					room.sendText("","*" + fix(cmd.getUser().toString()) + " leaves the room");
					room.removeIRCUser(cmd.getUser().getNick());
				}
			}
		} else {
			_log.debug(arg1);
		}
		
	}


	/**
	 * @return
	 */
	private Set getIRCUsers() {
		return _hsIRCUsers;
	}


	/**
	 * @param nick
	 */
	private void addIRCUser(String nick) {
		_hsIRCUsers.add(nick);
		
	}
	
	private void removeIRCUser(String nick) {
		_hsIRCUsers.remove(nick);
	}


	/**
	 * @param handle
	 * @param msg
	 */
	private void sendText(String handle, String msg) {
		if(msg.length()>97) {
			// too long, split.
			TextFormatter tf=new TextFormatter(TextFormatter.FORMAT_NONE,97);
			tf.add(msg);
			List l=tf.getList();
			for(int i=0;i<l.size();i++) {
				processEvent(new ChatEvent(this,-1,fix(handle),fix((String)l.get(i))));
			}
		} else {
			// send anon chat to rooms.
			processEvent(new ChatEvent(this,-1,fix(handle),fix(msg)));
		}
	}


	/**
	 * @param handle
	 * @return
	 */
	private static String fix(String str) {
		return str.replace((char)0x5f,'-');
	}


	/**
	 * 
	 */
	public void close() {
		_log.debug("Leaving IRC room: " + _sChannel);
		_autoJoin.disable();
		if(_bJoined)
			sendIRCCommand(new PartCommand(_sChannel,"Try QuantumLink RELOADED!"));
		_htRooms.remove(_sChannel);
		if(_htRooms.size()==0)
			disconnect();
		super.close();
	}


	/**
	 * 
	 */
	private synchronized void connect() {
		_log.debug("Connecting to IRC server" + SERVER_DNS);
		if(_ircConn==null && !_bConnected) {
			_ircConn = new IRCConnection();
			// Alive connections do not keep the program running
			_ircConn.setDaemon(true);
			_ircConn.addCommandObserver(_listener);
			_ircConn.addStateObserver(_stateListener);
		
			_autoReconnect = new AutoReconnect( _ircConn,1000,60000 );
			AutoRegister autoReg = new AutoRegister( _ircConn, SERVER_NICK, "qlink", "QuantumLink RELOADED" );
			AutoResponder autoRes = new AutoResponder( _ircConn );
		
			new ConnectThread();
			//Debug.println( "main", "Connecting", Debug.NORMAL );
		} else {
			_log.warn("We are calling connect() while we are already connected");
		}
	}


	/**
	 * 
	 */
	private synchronized void disconnect() {
		_log.debug("Disconnecting from IRC");
		_autoReconnect.disable();
		if(_ircConn!= null && _bConnected) {
			sendIRCCommand(new QuitCommand());
			_ircConn.disconnect();
		} else {
			_log.warn("We are not connected to IRC");
		}
		_ircConn=null;
	}


	/**
	 * @param command
	 */
	private void sendIRCCommand(OutCommand command) {
		try {
			_ircConn.sendCommand(command);
		} catch (NullPointerException e) {
			_log.debug("We lost our connection");
		} catch (Exception e) {
			_log.warn("We received this during IRC send",e);
		}
		
	}


	/**
	 * @param name
	 * @return
	 */
	public static QRoomDelegate getInstance(String name,boolean bPublic, boolean bLocked) {
		String channel="#"+new QHandle(name.substring(4)).getKey();
		QRoomDelegate room=(QRoomDelegate)_htRooms.get(channel);
		if(room==null)
			room=new IRCRoomDelegate(name,bPublic,bLocked);
		return room;
	}


	/* (non-Javadoc)
	 * @see org.jbrain.qlink.chat.QRoomDelegate#isManagedRoom()
	 */
	public boolean isManagedRoom() {
		return false;
	}


}
