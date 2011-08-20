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
package org.jbrain.qlink.cmd.action.fdo;

public class FDOSelectItemResponse extends AbstractFDOResponse {

	private FDOItemID _id;
	public static final FDOSelectItemResponse LOCATE=new FDOSelectItemResponse("K1",0x0f01f1);
	public static final FDOSelectItemResponse IDENTIFY=new FDOSelectItemResponse("K1",0x0f01e5);
	public static final FDOSelectItemResponse PUBLIC_ROOM=new FDOSelectItemResponse("K1",0x0f0044);
	public static final FDOSelectItemResponse PRIVATE_ROOM=new FDOSelectItemResponse("K1",0x0f050a);
	public static final FDOSelectItemResponse SEND_OLM=new FDOSelectItemResponse("K1",0x0f03fe);
	public static final FDOSelectItemResponse OLM_MENU=new FDOSelectItemResponse("K1",0x0f04d9);
	public static final FDOSelectItemResponse CHANGE_ROOM=new FDOSelectItemResponse("K1",0x0f03a0);
	public static final FDOSelectItemResponse PLAY_MUSIC=new FDOSelectItemResponse("K1",0x0f0313);
	public static final FDOSelectItemResponse SEND_EMAIL=new FDOSelectItemResponse("K1",0x0f0216);
	public static final FDOSelectItemResponse COMPLETED=new FDOSelectItemResponse("K1",0x0f0151);
	public static final FDOSelectItemResponse DISK_MENU=new FDOSelectItemResponse("K1",0x0f00c5);
	public static final FDOSelectItemResponse SAVE=new FDOSelectItemResponse("K1",0x0f0157);
	public static final FDOSelectItemResponse DISK_CMD=new FDOSelectItemResponse("K1",0x0f0065);
	public static final FDOSelectItemResponse HIGHLIGHT_ON=new FDOSelectItemResponse("K1",0x0f03e9);
	public static final FDOSelectItemResponse HIGHLIGHT_OFF=new FDOSelectItemResponse("K1",0x0f03e8);
	public static final FDOSelectItemResponse IGNORE_ON=new FDOSelectItemResponse("K1",0x0f0735);
	public static final FDOSelectItemResponse IGNORE_OFF=new FDOSelectItemResponse("K1",0x0f073a);
	public static final FDOSelectItemResponse LOAD_TEXT=new FDOSelectItemResponse("K1",0x0f0294);

	public FDOSelectItemResponse(String cmd, int id) {
		this(cmd,new FDOItemID(id));
	}
	
	public FDOSelectItemResponse(String cmd, FDOItemID id) {
		super(cmd,FDOResponse.RESP_SELECT);
		_id=id;
		if(id==null)
			throw new NullPointerException("Null ID");
		
	}
	/* (non-Javadoc)
	 * @see org.jbrain.qlink.cmd.action.fdo.FDOCommand#getBytes()
	 */
	public byte[] getBytes() {
		byte[] data = new byte[7];
		data[4]=_id.getMSB();
		data[5]=_id.getSSB();
		data[6]=_id.getLSB();
		finalizeResponse(data);
		return data;
	}

	/* (non-Javadoc)
	 * @see org.jbrain.qlink.cmd.action.fdo.FDOCommand#size()
	 */
	public int size() {
		// TODO Auto-generated method stub
		return 7;
	}
}
