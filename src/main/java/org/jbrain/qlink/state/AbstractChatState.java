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
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.jbrain.qlink.QSession;
import org.jbrain.qlink.chat.*;
import org.jbrain.qlink.cmd.action.*;
import org.jbrain.qlink.user.*;
import org.jbrain.qlink.util.QuotedStringTokenizer;


public abstract class AbstractChatState extends AbstractState {
	protected static final String pad="            ";
	private static Logger _log=Logger.getLogger(AbstractChatState.class);
	private static ChatProfile _staffProfile=new ChatProfile();
	private static ChatProfile _normalProfile=new ChatProfile();
	protected static RoomManager _mgr=RoomManager.getRoomManager();
	protected QRoom _room=null;
	protected QueuedChatEventListener _listener;

	static {
		_staffProfile.setEntry("room.user.gag",true);
		_staffProfile.setEntry("tos.warning",true);
		_staffProfile.setEntry("room.say.anon",true);
		
	}
	
	
	class QueuedChatEventListener implements RoomEventListener {
		private boolean _bSuspend=true;
		private ArrayList _alQueue=new ArrayList();

		/* (non-Javadoc)
		 * @see org.jbrain.qlink.chat.BasicRoomEventListener#eventOccurred(org.jbrain.qlink.chat.RoomEvent)
		 */
		public synchronized void suspend() {
			_bSuspend=true;
		}
		
		public synchronized void resume() {
			RoomEvent e;
			
			_bSuspend=false;
			while(_alQueue.size()>0) {
				e=(RoomEvent)_alQueue.remove(0);
				if(e instanceof ChatEvent)
					userSaid((ChatEvent)e);
				else if(e instanceof SystemMessageEvent)
					systemSent((SystemMessageEvent)e);
				else if(e instanceof JoinEvent && ((JoinEvent)e).getType()==JoinEvent.EVENT_JOIN)
					userJoined((JoinEvent)e);
				else if(e instanceof JoinEvent && ((JoinEvent)e).getType()==JoinEvent.EVENT_LEAVE)
					userLeft((JoinEvent)e);
				else if(e instanceof QuestionStateEvent && ((QuestionStateEvent)e).getType()==QuestionStateEvent.ACCEPTING_QUESTIONS)
					acceptingQuestions((QuestionStateEvent)e);
				else if(e instanceof QuestionStateEvent && ((QuestionStateEvent)e).getType()==QuestionStateEvent.NOT_ACCEPTING_QUESTIONS)
					rejectingQuestions((QuestionStateEvent)e);
			}
		}
		public void userSaid(ChatEvent event) {
			if(_bSuspend)
				_alQueue.add(event);
			else
				if(_log.isDebugEnabled())
					_log.debug("Sending " + event.getName() + "'s text: '" + event.getText() +"'");
				if(event.getSeatID()>-1) {
					_session.send(new ChatSend(event.getSeatID(),event.getText()));
				} else {
					_session.send(new AnonChatSend(event.getName(),event.getText()));
				}
			
		}

		public void userJoined(JoinEvent event) {
			if(_bSuspend)
				_alQueue.add(event);
			else {
				if(_log.isDebugEnabled())
					_log.debug(event.getName() + " enters room in seat " + event.getSeatID());
				_session.send(new CA(event.getSeatID(),event.getName()));
			}
			
		}

		public void userLeft(JoinEvent event) {
			if(_bSuspend)
				_alQueue.add(event);
			else {
				if(_log.isDebugEnabled())
					_log.debug(event.getName() + " leaves room and vacates seat " + event.getSeatID());
				_session.send(new CB(event.getSeatID(),event.getName()));
			}
		}

		public void systemSent(SystemMessageEvent event) {
			// send ourselves an OLM, as we requested it.
			String[] msg=event.getMessage();
			_session.sendOLM(msg);
			
		}

		public void acceptingQuestions(QuestionStateEvent event) {
			_session.send(new AcceptingQuestions());
		}

		public void rejectingQuestions(QuestionStateEvent event) {
			_session.send(new RejectingQuestions());
		}
	}

	/**
	 * @param session
	 */
	public AbstractChatState(QSession session) {
		super(session);
	}
	
	public boolean execute(Action a) throws IOException {
		boolean rc=false;

		if(a instanceof ChatSay) {
			_log.debug(_room.getName() + "." + _session.getHandle() + " says: '" + ((ChatSay)a).getText() + "'");
			process(((ChatSay)a).getText());
			rc=true;
		} else if(a instanceof IdentifyUser) {
			QHandle handle = new QHandle(((IdentifyUser)a).getData());
			_log.debug("Trying to identify user: '" + handle + "'");
			AccountInfo info = UserManager.getAccount(handle);
			if(info==null) {
				_log.debug("ID Error: No such user");
				_session.send(new UserInvalid());
			} else {
				if(info.isStaff()) {
					_log.debug("Sending staff identity");
					_session.send(new BulletinLine("QuantumLink RELOADED Staff Member",false));
					_session.send(new BulletinLine("",false));
					_session.send(new BulletinLine("Location:",false));
					_session.send(new BulletinLine("Cedar Rapids, IA",false));
					_session.send(new BulletinLine("USA",true));
				} else {
					UserInfo user=info.getUserInfo();
					if(user!=null && user.getCountry()!=null) {
						_log.debug("Sending user identity");
						//_session.send(new BulletinLine("Name:",false));
						//_session.send(new BulletinLine(user.getName(),false));
						//_session.send(new BulletinLine("",false));
						_session.send(new BulletinLine("Location:",false));
						_session.send(new BulletinLine(user.getCity() + ", " + user.getState(),false));
						_session.send(new BulletinLine(user.getCountry(),true));
					} else {
						_log.debug("Identity info not available");
						_session.send(new BulletinLine("Information not available for user",true));
						//_session.send(new BulletinLine("Error retrieving user information",true));
					}
				}
			}
		}
		if(!rc)
			rc=super.execute(a);
		return rc;
	}
	
	/**
	 * @param text
	 */
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
				if(cmd.startsWith("sysmsg") && _session.isStaff()) {
					// Send SYSOLM;
					if(st.hasMoreTokens())
						msg=st.nextToken("\n");
					if(msg!= null) {
						_log.debug("Executing '" + text + "' from '" + _session.getHandle() + "'");
						_session.getServer().sendSYSOLM(msg);
					}
				} else if(cmd.startsWith("kill") && _session.isStaff()) {
					// Kill account;
					if(st.hasMoreTokens())
						name=st.nextToken("\n");
					if(name!= null) {
						handle=new QHandle(name);
						_log.debug("Killing '" + handle + "' session ");
						if(_session.getServer().killSession(handle)) {
							error=name + "'s session terminated";
						} else {
							error=name + "'s session could not be terminated";
						}
					}
				} else if((cmd.startsWith("tos") || (cmd.startsWith("bump"))) && _session.isStaff()) {
					// kick user;
					if(st.hasMoreTokens()) {
						name=st.nextToken("\n");
						handle=new QHandle(name);
						if(_mgr.getUserLocation(handle) != null) {
							_log.debug("Kicked '" + handle + "' off");
							_session.getServer().sendToUser(handle,new Toss("You have violated the TOS and your session has been terminated " + (char)0xff + (char)0xff + "Press F5 to return to BASIC"));
							_session.getServer().killSession(handle);
						} else {
							error=name + " not in chat";
						}
					} else {
						error="Usage: //tos <user name>";
					}
				} else if(cmd.startsWith("reboot") && _session.isStaff()) {
					// reboot server;
					if(st.hasMoreTokens())
						msg=st.nextToken("\n");
					_session.getServer().reboot(msg);
				} else if(cmd.startsWith("test") && _session.isStaff()) {
					if(st.hasMoreTokens())
						name=st.nextToken(" ");
					if(st.hasMoreTokens())
						msg=st.nextToken("\n");
					if(name != null && msg!= null) {
						_session.send(new TestText(name,msg));
					} else if(name!=null && name.length()==2) {
						_session.send(new Test(name));
					}
				} else if(cmd.startsWith("nick")) {
					QSeat seat=_room.getSeatInfo(_session.getHandle());
					if(seat != null && !seat.isInGame()) {
						// Change user name;
						if(st.hasMoreTokens())
							name=st.nextToken("\n");
						if(name!= null) {
							handle=new QHandle(name);
							AccountInfo info=UserManager.getAccount(handle);
							if(info!=null && info.getUserID()==_session.getUserID()) {
								_log.debug("Changing user name from '" + _session.getHandle() + "' to '" + info.getHandle()+ "'");
								if(_room.changeUserName(info.getHandle(),getProfile(info)))
									_session.setAccountInfo(info);
								else
									error="Could not change user name";
							} else {
								error="Invalid handle '" + name + "'";
							}
						}
					} else {
						error="Cannot change user names while in a game";
					}
				//} else if(cmd.startsWith("join")) {
				//	_log.debug("Entering public room");
				//	enterRoom("TestRoom",true);
				} else if(cmd.startsWith("who")) {
					sendUserList();
				} else if(cmd.startsWith("msg")) {
					// Send someone a private msg;
					if(st.hasMoreTokens())
						name=st.nextToken(" ");
					if(st.hasMoreTokens())
						msg=st.nextToken("\n");
					if(name != null && msg!= null) {
						handle=new QHandle(name);
						if(_log.isDebugEnabled())
							_log.debug("sending private message: '" + msg +"' to " + handle);
						if(UserManager.getAccount(handle)==null)
							error="User not valid";
						else if(!_session.getServer().isUserOnline(handle))
							error="User not online";
						else if(!_session.getServer().canReceiveOLMs(handle)) {
							error="User cannot receive OLMs";
						} else {
							olm=new String[3];
							olm[0]="Message From:  " + _session.getHandle();
							olm[1]=msg;
							olm[2]="End of Message - Press F5 to cancel";
							_session.getServer().sendOLM(handle,olm);
						}
					}
				} else {
					_room.say(text);
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


	/**
	 * @param b
	 * @return
	 */
	protected void showSeats(QSeat[] seats, boolean bRoomChange) {
		QSeat user;
		int mySeat=-1;
	
		_log.debug("Sending seat information");
		for(int i=0,size=seats.length;i<size;i++) {
			user=seats[i];
			if(!_session.getHandle().equals(user.getHandle()))
				if(bRoomChange)
					_session.send(new CL(user.getSeatID(),user.getHandle().toString()));
				else
					_session.send(new CA(user.getSeatID(),user.getHandle().toString()));
			else
				mySeat=user.getSeatID();
		}
		if(mySeat>-1)
			_session.send(new CE(mySeat,_session.getHandle().toString()));
		else
			_session.send(new CE(23,_session.getHandle().toString()));
		_listener.resume();
		if(!bRoomChange && checkEmail())
			_session.send(new NewMail());
	}

	protected void sendUserList() {
		QSeat[] seats=_room.getExtSeatInfoList();
		List l=new ArrayList();
		l.add("Currently in room:");
		StringBuffer sb=new StringBuffer();
		sb.append("  ");
		String name=pad;
		for(int i=0;i<seats.length;i++) {
			sb.append(pad.substring(name.length()));
			name=seats[i].getHandle().toString();
			sb.append(name);
			if(i%3==2) {
				// add line to list.
				l.add(sb.toString());
				sb.setLength(0);
				sb.append("  ");
				name=pad;
			}
		}
		if(sb.length()>2)
			l.add(sb.toString());
		l.add("End of QRoom List - Press F5 to go on.");
		_session.sendOLM((String[])l.toArray(new String[0]));
	}

	protected void leaveRoom() {
		// remove the listener 
		_log.debug("Removing room listener");
		_room.removeEventListener(_listener);
		// suspend so no more messages will go to the client.
		_listener.suspend();
		_log.debug("Leaving current room");
		// leave this room.
		_room.leave();
	}

	protected QSeat[] addListener() {
		QSeat[] seats;
		_listener=new QueuedChatEventListener();
		synchronized(_room) {
			_log.debug("Adding room listener");
			_room.addEventListener(_listener);
			_log.debug("Getting seat information");
			seats=_room.getSeatInfoList();
		}
		return seats;
	}

	protected ChatProfile getProfile(AccountInfo info) {
		ChatProfile profile;
		if(info.isStaff())
			profile=_staffProfile;
		else
			profile=_normalProfile;
		return profile;
	}



}
