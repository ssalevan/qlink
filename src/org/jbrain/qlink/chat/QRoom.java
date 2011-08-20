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
 Created on Aug 23, 2005
 
 */
package org.jbrain.qlink.chat;

import org.jbrain.qlink.user.QHandle;

public interface QRoom {

	public abstract String getName();
	public abstract int getPopulation();
	public abstract QSeat[] getSeatInfoList();
	public abstract QSeat[] getExtSeatInfoList();
	public abstract void addEventListener(RoomEventListener listener);
	public abstract void removeEventListener(RoomEventListener listener);
	public abstract void say(String[] text);
	public abstract void say(String text);
	public abstract void leave();
	public abstract Game createGame(int id, String name, String type, boolean systemPickOrder);
	public abstract Game getPendingGame();
	public abstract QSeat getSeatInfo(QHandle handle);
	public abstract boolean isPublicRoom();
	public GameInfo[] getGameInfoList();
	public String getInfo();
	public abstract ObservedGame observeGame(QHandle handle);
	public abstract boolean changeUserName(QHandle handle, ChatProfile profile);
	public abstract boolean canTalk();
}