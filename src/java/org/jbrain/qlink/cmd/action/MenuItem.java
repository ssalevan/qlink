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
	Created on Jul 25, 2005
	
 */
package org.jbrain.qlink.cmd.action;


public class MenuItem extends AbstractMenuItem {
	private String _sName;
	private int _iType;
	private int _iCost;
	
	public static final int HEADING = 0;
	// probably should not be here
	public static final int MESSAGE_BASE = 0x01;
	public static final int MESSAGE = 0x02;
	
	public static final int MENU = 0x81;
	public static final int TEXT = 0x82;
	public static final int UNKNOWN_83 = 0x83;
	public static final int UNKNOWN_84 = 0x84;
	public static final int GATEWAY = 0x85;
	public static final int AREA_MENU = 0x86;
	public static final int POST_OFFICE = 0x87;
	public static final int MULTI_TEXT = 0x88;
	public static final int UNKNOWN_89 = 0x89;
	public static final int DOWNLOAD = 0x8A;
	public static final int CHAT = 0x8B;
	public static final int UNKNOWN_8C = 0x8C;
	public static final int UPLOAD = 0x8d;
	public static final int UNKNOWN_8E = 0x8E;
	public static final int MENU_DATA = 0x8F;
	public static final int FILE_DESC = 0x90;
	
	public static final int COST_NORMAL=2;
	public static final int COST_PREMIUM=1;
	public static final int COST_NO_CHARGE=0;

	/**
	 * 
	 */
	public MenuItem(int id, String name, int type, int cost, boolean bLastItem) {
		super((bLastItem?"KB":"KA"),id);
		_sName=name;
		_iCost=cost;
		int i=0;
		// looks like last 2 bits are +/- indicator 00/10 is nothing
		// +=01, -=11
		_iType=type<<16|_iCost;
	}
	
	/**
	 * @param refid
	 * @param title
	 * @param int1
	 * @param b
	 */
	public MenuItem(int id, String name, int ser, boolean bLastItem) {
		super((bLastItem?"KB":"KA"),id);
		_sName=name;
		_iType=ser;
	}

	public byte[] getBytes() {
		// 0x5a CH CH CH CH SEQ SEQ CMD K A 0x01 ID ID ID ID COD COD COD COD 0x90 <name>
		byte[] b=getBytes(_sName);
		byte[] data;
		data=new byte[10+10 + b.length];
		data[10]=(byte)0x01;
		encode(_iID,data,11);
		// put in codes;
		encode(_iType,data,15);
		data[19]=(byte)0x90;
		System.arraycopy(b,0,data,20,b.length);
		finalizeCmd(data);
		return data;
	}
}
