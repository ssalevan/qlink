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
	Created on Jul 18, 2005
	
 */
package org.jbrain.qlink;

import java.io.*;

import org.apache.log4j.Logger;


public class TelenetProxy {
	private static Logger _log=Logger.getLogger(TelenetProxy.class);
	private static final int STATE_CONNECT=1;
	private static final int STATE_CONNECT2 = 2;
	private static final int STATE_CONNECT3 = 5;
	private static final int STATE_TERMINAL = 3;
	private static final int STATE_LOGGEDIN = 4;
	private static final String CMD_TERMINAL = "TERMINAL=";
	private static final String PROMPT = "@";
	private static final String CONNECTED = "\r\rCONNECTED\r";

	private BufferedReader _br;
	private OutputStream _os;
	private int _iState;

	public TelenetProxy(InputStream is, OutputStream os) {
		try {
			_br=new BufferedReader(new InputStreamReader(is,"ISO-8859-1"));
			_os=os;
		} catch (UnsupportedEncodingException e) {
			_log.fatal("US-ASCII is not supported",e);
		}
		_iState=STATE_CONNECT;
	}

	/**
	 * @return
	 */
	public boolean negotiate() {
		String line;
		boolean done=false;
		
		try {
			do {
				line=_br.readLine();
				_log.debug("Received line: " + line);
				if(line==null) {
					_log.error("Connection prematurely terminated");
				} else {
					switch(_iState) {
						case STATE_CONNECT:
							_iState=STATE_CONNECT2;
							break;
						case STATE_CONNECT2:
							_iState=STATE_CONNECT3;
							break;
						case STATE_CONNECT3:
							write(CMD_TERMINAL);
							_iState=STATE_TERMINAL;
							break;
						case STATE_TERMINAL:
							if(line.equals("D1")) {
								_iState=STATE_LOGGEDIN;
								write(PROMPT);
							} else {
								_log.debug("Received '" + line + "' for TERMINAL TYPE");
								write(CMD_TERMINAL);
							}
							break;
						case STATE_LOGGEDIN:
							if(line.startsWith("CONNECT")) {
								done=true;
								write(CONNECTED);
							}
							if(!done)
								write(PROMPT);
					}
				}
			} while (line != null && !done);
		} catch (IOException e) {
			_log.error("Received error during packet negotiation",e);
		}
		return done;
	}

	/**
	 * @param data
	 */
	private void write(String data) throws IOException {
		_log.debug("Sending: " + data);
		_os.write(data.getBytes());
		_os.flush();
	}

}
