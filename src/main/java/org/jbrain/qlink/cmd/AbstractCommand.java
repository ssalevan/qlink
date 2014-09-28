/*
	Copyright Jim Brain and Brain Innovations, 2005.

	This file is part of QLink.

	QLink is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	QLink is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with QLink; if not, write to the Free Software
	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

	@author Jim Brain
	Created on Jul 14, 2005
	
 */
package org.jbrain.qlink.cmd;

import org.jbrain.qlink.util.*;

public abstract class AbstractCommand implements Command {
	private byte _bCmd;
	private byte _bSendSeq;
	private byte _bRecvSeq;
	protected int _iReportedCRC;
	protected int _iCalculatedCRC;
	
	// you call this to create a command
	public AbstractCommand(byte cmd) {
		_bCmd=cmd;
	}
	
	/**
	 * @param cmd_ping
	 * @param data
	 * @param start
	 * @param len
	 */
	// you call this on receipt of data
	public AbstractCommand(byte[] data, int start, int len) {
		_iReportedCRC=((data[start+1]&0xf0 | data[start+2]&0x0f)<<8)|(data[start+3]&0xf0 | data[start+4]&0x0f);
		CRC16 crc=new CRC16();
		crc.update(data,start+5,len-5);
		_iCalculatedCRC=(int)crc.getValue();
		
		_bCmd=data[start+7];
		_bRecvSeq=data[start+5];
		_bSendSeq=data[start+6];
	}
	
	public void setRecvSequence(byte seq) {
		_bRecvSeq=(byte)seq;
	}
	
	public void setSendSequence(byte seq) {
		_bSendSeq=(byte)seq;
	}
	
	protected void finalizeCmd(byte[] data) {
		data[0]=CMD_START;
		data[5]=_bSendSeq;
		data[6]=_bRecvSeq;
		data[7]=_bCmd;
		CRC16 crc=new CRC16();
		crc.update(data,5,data.length-5);
		int c=(int)crc.getValue();
		data[1]=(byte)(((c&0xf000)>>8) | 0x01); 
		data[2]=(byte)(((c&0xf00)>>8) | 0x40); 
		data[3]=(byte)((c&0xf0) | 0x01); 
		data[4]=(byte)((c&0xf) | 0x40); 
	}
	
	public byte[] getBytes() {
		byte[] data=new byte[8];
		finalizeCmd(data);
		return data;
	}
	
	/* (non-Javadoc)
	 * @see org.jbrain.qlink.cmd.Command#getRecvSequence()
	 */
	public byte getRecvSequence() {
		return _bRecvSeq;
	}

	public byte getSendSequence() {
		return _bSendSeq;
	}
	
	/* (non-Javadoc)
	 * @see org.jbrain.qlink.cmd.Command#getAction()
	 */
	public byte getCommand() {
		return _bCmd;
	}
	
	public String getName() {
		// we should shorten this.
		return this.getClass().getName();
	}
}


