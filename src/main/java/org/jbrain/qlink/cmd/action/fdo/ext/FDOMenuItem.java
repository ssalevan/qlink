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
	Created on Oct 12, 2005
	
 */
package org.jbrain.qlink.cmd.action.fdo.ext;

import org.jbrain.qlink.cmd.action.fdo.AbstractFDOCommand;
import org.jbrain.qlink.cmd.action.fdo.FDOMenuTitle;
import org.jbrain.qlink.cmd.action.fdo.FDOResponse;
import org.jbrain.qlink.cmd.action.fdo.FDOSelectItemResponse;


public class FDOMenuItem extends AbstractFDOCommand {
	private FDOMenuTitle _title;
	private FDOResponse _response;
	
	public static final FDOMenuItem LOCATE = new FDOMenuItem("Locate someone",FDOSelectItemResponse.LOCATE);
	public static final FDOMenuItem IDENTIFY=new FDOMenuItem("Identify someone",FDOSelectItemResponse.IDENTIFY);
	public static final FDOMenuItem PUBLIC_ROOM=new FDOMenuItem("Enter public room",FDOSelectItemResponse.PUBLIC_ROOM);
	public static final FDOMenuItem PRIVATE_ROOM=new FDOMenuItem("Enter private room",FDOSelectItemResponse.PRIVATE_ROOM);
	public static final FDOMenuItem SEND_OLM=new FDOMenuItem("Send OLM",FDOSelectItemResponse.SEND_OLM);
	public static final FDOMenuItem OLM_MENU=new FDOMenuItem("OLM Menu",FDOSelectItemResponse.OLM_MENU);
	public static final FDOMenuItem CHANGE_ROOM=new FDOMenuItem("QRoom Menu",FDOSelectItemResponse.CHANGE_ROOM);
	public static final FDOMenuItem PLAY_MUSIC=new FDOMenuItem("Play a SID File",FDOSelectItemResponse.PLAY_MUSIC);
	public static final FDOMenuItem SEND_EMAIL=new FDOMenuItem("Send E-Mail to someone's mailbox",FDOSelectItemResponse.SEND_EMAIL);
	//public static final FDOMenuItem COMPLETED=new FDOMenuItem("Completed",FDOSelectItemResponse.COMPLETED);
	public static final FDOMenuItem DISK_MENU=new FDOMenuItem("Disk Menu",FDOSelectItemResponse.DISK_MENU);
	public static final FDOMenuItem SAVE=new FDOMenuItem("SAVE",FDOSelectItemResponse.SAVE);
	public static final FDOMenuItem DISK_CMD=new FDOMenuItem("Disk Command",FDOSelectItemResponse.DISK_CMD);
	public static final FDOMenuItem HIGHLIGHT_ON=new FDOMenuItem("Highlight someone's mesages",FDOSelectItemResponse.HIGHLIGHT_ON);
	public static final FDOMenuItem HIGHLIGHT_OFF=new FDOMenuItem("Remove highlighting",FDOSelectItemResponse.HIGHLIGHT_OFF);
	public static final FDOMenuItem IGNORE_ON=new FDOMenuItem("Ignore someone",FDOSelectItemResponse.IGNORE_ON);
	public static final FDOMenuItem IGNORE_OFF=new FDOMenuItem("Stop ignoring someone",FDOSelectItemResponse.IGNORE_OFF);
	public static final FDOMenuItem LOAD_TEXT=new FDOMenuItem("Load Text from File",FDOSelectItemResponse.LOAD_TEXT);

	
	public FDOMenuItem(String title, FDOResponse response) {
		_title=new FDOMenuTitle(title);
		_response=response;
	}
	
	FDOMenuTitle getTitle() {
		return _title;
	}
	
	FDOResponse getResponse() {
		return _response;
	}

	/* (non-Javadoc)
	 * @see org.jbrain.qlink.cmd.action.fdo.FDOCommand#getBytes()
	 */
	public byte[] getBytes() {
		byte[] data=new byte[size()];
		byte[] b1,b2;
		
		b1=_title.getBytes();
		System.arraycopy(b1,0,data,0,b1.length);
		b2=_response.getBytes();
		System.arraycopy(b2,0,data,b1.length,b2.length);
		return data;
	}

	/* (non-Javadoc)
	 * @see org.jbrain.qlink.cmd.action.fdo.FDOCommand#size()
	 */
	public int size() {
		return _title.size()+_response.size();
	}

}
