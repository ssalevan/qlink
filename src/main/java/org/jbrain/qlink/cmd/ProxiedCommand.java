package org.jbrain.qlink.cmd;

import org.jbrain.qlink.util.*;

public class ProxiedCommand extends AbstractCommand {
	// you call this on receipt of data
	public ProxiedCommand(byte[] data, int start, int len) {
            super(data, start, len);
		CRC16 crc=new CRC16();
		crc.update(data,start+5,len-5);
		_iCalculatedCRC=(int)crc.getValue();
                _iReportedCRC = _iCalculatedCRC;
	}
}


