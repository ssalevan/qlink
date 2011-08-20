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
	Created on Jul 23, 2005
	
 */
package org.jbrain.qlink.state;

import java.io.*;
import java.net.ConnectException;
import java.net.Socket;
import java.net.UnknownHostException;

import org.apache.log4j.Logger;
import org.jbrain.qlink.QSession;
import org.jbrain.qlink.cmd.action.*;


public class GatewayState extends AbstractState implements Runnable {
	private static Logger _log=Logger.getLogger(GatewayState.class);

	/**
	 * 
	 * @uml.property name="_intState"
	 * @uml.associationEnd multiplicity="(0 1)"
	 */
	private QState _intState;

	private String _sHost;
	private int _iPort;
	private boolean _bRunning;
	private InputStream _is;
	private OutputStreamWriter _w;

	public GatewayState(QSession session, String host, int port) {
		super(session);
		_sHost=host;
		_iPort=port;
	}
	
	public void activate() throws IOException {
		boolean bOpen=false;
		
		try {
			Socket sock=new Socket(_sHost,_iPort);
			_is=sock.getInputStream();
			_w = new OutputStreamWriter(sock.getOutputStream(),"ISO-8859-1");
			_log.debug("Starting Gateway receive thread");
			Thread t=new Thread(this);
			_intState=_session.getState();
			super.activate();
			t.setDaemon(true);
			t.start();
			bOpen=true;
		} catch (UnknownHostException e) {
			_log.error("Gateway service error",e);
			_session.send(new GatewayExit("service unavailable"));
		} catch (ConnectException e) {
			_log.error("Gateway service error",e);
			_session.send(new GatewayExit("service unavailable"));
		} catch (IOException e) {
			_log.error("Gateway service error",e);
			_session.send(new GatewayExit("service unavailable"));
		}
		if(bOpen) {
			_session.send(new GatewayEnter());
			_session.send(new DisableEcho());
		}
	}

	public boolean execute(Action a) throws IOException {
		QState state;
		boolean rc=false;
		
		if(a instanceof GatewayRecv) {
			String data=((GatewayRecv)a).getData();
			_log.debug("Sending '" + data + "' to gateway service");
			try {
				_w.write(data);
				_w.write("\r\n");
				_w.flush();
			} catch (IOException e) {
				exit("gateway service disconnected");
			}
			rc=true;
		} else if(a instanceof GatewayMoreAck) {
			// dunno.
			rc=true;
		} else if(a instanceof GatewayDisconnect) {
			exit("gateway service disconnected");
			rc=true;
		}
		if(!rc)
			rc=_intState.execute(a);
		return rc;
	}

	/* (non-Javadoc)
	 * @see java.lang.Runnable#run()
	 */
	public void run() {
		String ESC_CR="" + (char)0x7f;
		byte[] data=new byte[100];
		int len;
		String line;

		_bRunning=true;
		try {
			while(_bRunning) {
				
				len=_is.read(data);
				if(len<0 && _bRunning) {
					exit("Server disconnected");
				} else {
					line=new String(data,0,len,"ISO-8859-1");
					line=line.replaceAll("\r",ESC_CR);
					line=line.replaceAll("\n","");
					_session.send(new GatewaySend(line));
				}
			}
			// someone shut us down..
		} catch (UnsupportedEncodingException e) {
			_log.error("ASCII not supported?",e);
			exit("Gateway service error");
		} catch (IOException e) {
			if(_bRunning) {
				_log.debug("Gateway encountered IO error",e);
				exit("gateway service disconnected");
			}
		}
		
	}
	
	private void exit(String text) {
		_session.send(new GatewayExit(text));
		_session.setState(_intState);
		close();
	}

	/**
	 * 
	 */
	private void close() {
		_bRunning=false;
		try {
			_is.close();
			_w.close();
		} catch (IOException e) { }
	}
	
	public void terminate() {
		close();
		_intState.terminate();
	}

}
