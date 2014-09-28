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
	Created on Sep 21, 2005
	
 */
package org.jbrain.qlink.cmd.action;

import java.util.ArrayList;


public class PlayBackMoves extends AbstractAction {
	private ArrayList _alActions=new ArrayList();
	private int _iLen=0;

	/**
	 * @param action
	 */
	public PlayBackMoves(Action a) {
		super("JM");
		add(a);
	}

	/**
	 * @param a
	 * @return
	 */
	public boolean add(Action a) {
		int len=a.getBytes().length-7;
		if(len + _iLen > 117 )
			return false;
		_alActions.add(a);
		_iLen+=len;
		return true;
	}
	
	public byte[] getBytes() {
		byte[] data=new byte[11 + _iLen];
		int pos=10;
		Action a;
		for(int i=0,size=_alActions.size();i<size;i++) {
			a=(Action)_alActions.get(i);
			byte[] b=a.getBytes();
			data[pos++]=(byte)((b.length-8)+ 0x0e);
			System.arraycopy(b,8,data,pos,b.length-8);
			pos+=(b.length-8);
		}
		data[data.length-1]=(byte)0x0e;
		finalizeCmd(data);
		return data;
	}	
	
	public static void main(String args[]) {
		byte[] b=new byte[2];
		b[0]=0;
		b[1]=1;
		Action a=new StartGame("GAME",b);
		PlayBackMoves pm=new PlayBackMoves(a);
		pm.add(new GameSend(0, "JIM1"));
		pm.add(new GameSend(1, "JIM2"));
		pm.add(new GameSend(0, "A"));
		pm.add(new GameSend(1, "B"));
		pm.getBytes();
	}
	

}
