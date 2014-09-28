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
package org.jbrain.qlink.connection;

import java.io.*;
import java.util.ArrayList;
import java.util.Timer;
import java.util.TimerTask;
import java.util.Vector;

import org.apache.log4j.Logger;
import org.jbrain.qlink.cmd.*;
import org.jbrain.qlink.cmd.action.*;



// this class handles all comm to from client.
public class QConnection extends Thread {
	private static final int MAX_CONSECUTIVE_ERRORS=20;
	private static Logger _log=Logger.getLogger(QConnection.class);
	private static Timer _timer=new Timer();
	private static TimerTask _pingTimer=null;;
	public static byte FRAME_END=0x0d;

	private Vector _listeners = new Vector();
	private ArrayList _alSendQueue = new ArrayList();
	private int _iConsecutiveErrors=0;
	private int _iQLen;
	private byte _inSequence;
	private byte _outSequence;
	private boolean _bRunning=false;
	private InputStream _is;
	private OutputStream _os;
	private static final int QSIZE = 16;
	private KeepAliveTask _keepAliveTask;
	private SuspendWatchdog _suspendWatchdog;

	private int _iVersion;
	private int _iRelease;
	private static final byte SEQ_DEFAULT = 0x7f;
	private static final byte SEQ_LOW = 0x10;
	private class PingTask extends TimerTask {
		public void run() {
			try {
				write(new Ping());
			} catch (IOException e) {
				if(_bRunning) {
					// link error.
					_log.error("Link error",e);
				}
				close();
			}
		}
	};
	private class KeepAliveTask extends TimerTask {
		private boolean _outStandingPing=false;
		public void run() {
			if(_outStandingPing) {
				_log.debug("KeepAlive ping went unanswered, closing link");
				close();
			} else {
				try {
					write(new Ping());
					_outStandingPing=true;
				} catch (IOException e) {
					if(_bRunning) {
						// link error.
						_log.error("Link error",e);
					}
					close();
				}
			}
		}
		
		public void reset() {
			_outStandingPing=false;
		}
	};

	private class SuspendWatchdog extends TimerTask {
		public void run() {
			// we never came back from suspend, close link.
			close();
		}
	};
	public QConnection(InputStream is, OutputStream os) {
		init();
		_is=is;
		_os=os;
		this.setDaemon(true);
		resumeLink();
	}
	
	// listen for data to arrive, create Event, and dispatch.
	public void run() {
		CommandFactory factory=new CommandFactory();
		Command cmd;
		byte[] data=new byte[256];
		int start=0;
		int len=0;
		int i;
		byte inSeq=_inSequence;
		_log.info("Starting link thread");
		_bRunning=true;
		
		try {
			while(_bRunning && (i=_is.read(data,len,256-len))>0) {
				// should optimize this to not scan all over again each time.
				len+=i;
				for(i=0;i<len;i++) {
					if(data[i]==FRAME_END) {
						// we have a valid packet, process.
						
						try {
							if(_log.isDebugEnabled())
								trace("Received packet: ",data,start,i-start);
							cmd=factory.newInstance(data,start,i-start);
							if(cmd!=null) {
								if(_keepAliveTask!=null)
									_keepAliveTask.reset();	
								_log.debug("Received " + cmd.getName());
								if(cmd instanceof Reset) {
									if(((Reset)cmd).isSuperQ()) {
										_log.debug("SuperQ/Music Connection special RESET received");
									}
									_log.debug("Issuing RESET Ack command");
									init();
									this.write(new ResetAck());
									_iVersion=((Reset)cmd).getVersion();
									_iRelease=((Reset)cmd).getRelease();
								} else {
									// get the sequence number of the received packet.
									inSeq=cmd.getRecvSequence();
									if(cmd instanceof Action && incSeq(_inSequence)!=inSeq) {
										_log.info("Sequence out of order, sending sequence error");
										if(++_iConsecutiveErrors == MAX_CONSECUTIVE_ERRORS)
											_bRunning=false;
										else
											write(new SequenceError());
									} else {
										_iConsecutiveErrors=0;
										_inSequence=inSeq;
										freePackets(cmd.getSendSequence(),SequenceError.CMD==cmd.getCommand());
										switch(cmd.getCommand()) {
											case WindowFull.CMD_WINDOWFULL:
												write(new Ack());
												break;
											case Ping.CMD_PING:
												// not sure what you are supposed to do.
												write(new ResetAck());
												break;
											case AbstractAction.CMD_ACTION:
												if(cmd instanceof Action)
													processActionEvent(new ActionEvent(this,(Action)cmd));
												else
													_log.error("Tried to process action " + cmd.getName());
												break;
											case ResetAck.CMD_RESETACK:
												break;
											case SequenceError.CMD:
												break;
										}
									}
								}
							} else {
								_log.warn("Unknown packet received");
							}
						} catch (CRCException e) {
							_log.info("CRC check failed, sending sequence error",e);
							if(++_iConsecutiveErrors == MAX_CONSECUTIVE_ERRORS)
								_bRunning=false;
							else
								write(new SequenceError());
							// cheesy, we should now dump all packets in the window, but no
							// idea how to do that.
						}
						// skip over framing end.
						start=Math.min(i+1,len);
					}
				}
				if(start!=0) {
					// move additional data to front of buffer.
					len=len-start;
					if(len>0)
						System.arraycopy(data,start,data,0,len);
					start=0;
				}
			}
		} catch (IOException e) {
			if(_bRunning) {
				// link error.
				_log.error("Link error",e);
			}
		} catch (Exception e) {
			_log.error("Unchecked Exception error",e);
		} finally {
			close();
		}
	}
	
	/**
	 * @param sendSequence
	 */
	private synchronized void freePackets(byte sequence, boolean bResend) throws IOException {
		int seq;
		boolean done=false;

		// we need our drain our SendQueue.
		_log.debug("Received incoming packet with sequence number: " + sequence);
		if(_iQLen>0) {
			seq=((Action)_alSendQueue.get(0)).getSendSequence();
			done=!(sequence>= seq || seq-sequence > QSIZE);
			while (_iQLen>0 && !done) {
				seq=((Action)_alSendQueue.remove(0)).getSendSequence();
				// decrease number of unacks
				_iQLen--;
				_log.debug("Freed sequence number: " + seq );
				if(sequence ==seq) {
					done=true;
				}
			}
		}
		stopTimer();
		if(bResend) {
			_log.debug("Resetting counters");
			_outSequence=sequence;
			_iQLen=0;
		}
		drainQueue();
	}

	/**
	 * @param resend
	 */
	private void drainQueue() throws IOException {
		
		if(!_bSuspend) {
			// can we send more?
			int seq=0;
			_log.debug("Sending Queued Actions");
			while(_iQLen<QSIZE && _iQLen<_alSendQueue.size()) {
				write((Command)_alSendQueue.get(_iQLen));
			}
			if(_alSendQueue.size()>QSIZE) {
				addTimer();
			}
		}
	}

	/*
	 * This can be called from the server
	 * From the timertask
	 * from the keep alive task
	 * from the thread run.
	 */
	public synchronized void close() {
		// we only want to call close once
		if(_bRunning) {
			_bRunning=false;
			stopTimer();
			if(_keepAliveTask!=null)
				_keepAliveTask.cancel();
			_log.debug("Sending Disconnect Action to server");
			try {
				processActionEvent(new ActionEvent(this,new LostConnection()));
			} catch (Exception e) {
				_log.error("Unchecked Exception",e);
			}
			_log.debug("Terminating link");
			if(_os!=null) {
				try {
					_os.close();
					_is.close();
				} catch (IOException e) {
				}
			}
		}
	}

	/**
	 * 
	 */
	private synchronized void init() {
		stopTimer();
		_inSequence=SEQ_DEFAULT;
		_outSequence=SEQ_DEFAULT;
		// we need to dump buffers, if any.
		_alSendQueue.clear();
		_iQLen=0;
		_iConsecutiveErrors=0;
		
		
	}

	public synchronized void send(Action a) throws IOException {
		_alSendQueue.add(a);
		if(_iQLen<QSIZE && !_bSuspend) {
			// sending next item in queue
			write((Command)_alSendQueue.get(_iQLen));
		} else {
			_log.debug("Queuing " + a.getName());
			// we need an ack, so queue this, and start the timer to ping client
			addTimer();
		}
	}
		
	public void write(Command cmd) throws IOException {
		byte[] data;
		// set sequences
		if(cmd instanceof Action) {
			_iQLen++;
			_outSequence=incSeq(_outSequence);
		}
		cmd.setSendSequence(_outSequence);
		cmd.setRecvSequence(_inSequence);
		
		data=cmd.getBytes();
		_log.debug("Sending " + cmd.getName());
		if(_log.isDebugEnabled())
			trace("Sending packet data: ",data,0,data.length);
		byte[] d2=new byte[data.length+1];
		System.arraycopy(data,0,d2,0,data.length);
		d2[data.length]=FRAME_END;
		//_os.write(data);
		_os.write(d2);
		//_os.write(FRAME_END);
	}
	
	/**
	 * @param sequence
	 * @return
	 */
	private byte incSeq(byte sequence) {
		if(sequence==SEQ_DEFAULT)
			sequence=SEQ_LOW;
		else
			sequence++;
		return sequence;
	}

	/**
	 * 
	 */
	private void addTimer() {
		if(_pingTimer==null) {
			_log.debug("Starting PING timer");
			_pingTimer=new PingTask();
			_timer.scheduleAtFixedRate(_pingTimer,2000,2000);
		}
	}

	/**
	 * 
	 */
	private synchronized void stopTimer() {
		if(_pingTimer!=null) {
			_log.debug("Stopping PING timer");
			_pingTimer.cancel();
			_pingTimer=null;
		}
	}

	/**
	 * @param data
	 * @param i
	 * @param length
	 */
	
	private static String _hex="0123456789ABCDEF";
	private boolean _bSuspend;
	public static void trace(String prefix, byte[] data, int i, int length) {
		StringBuffer sb=new StringBuffer(length*3+prefix.length());
		sb.append(prefix);
		byte d;
		while(length>0) {
			d=data[i++];
			length--;
			sb.append(_hex.charAt((d>>4)&0x0f));
			sb.append(_hex.charAt(d&0x0f));
			sb.append(" ");
		}
		_log.debug(sb.toString());
	}

	public void addEventListener(ConnEventListener listener) {
		_listeners.add(listener);
	}

	public void removeEventListener(ConnEventListener listener) {
		if(_listeners.contains(listener)) {
			_listeners.remove(listener);
		}
	}

	protected void processActionEvent(ActionEvent event) {
		if(event != null && _listeners.size() > 0) {
			for(int i=0,size=_listeners.size();i<size;i++) {
				((ConnEventListener)_listeners.get(i)).actionOccurred(event);
			}
		}
	}

	/**
	 * 
	 */
	public synchronized void suspendLink() {
		// remove ping timer.
		stopTimer();
		if(_keepAliveTask!=null)
			_keepAliveTask.cancel();
		else
			_log.error("Suspending, but KeepAliveTask is null!");
		_keepAliveTask=null;
		_bSuspend=true;
		
		// but, we need to add a longer timer, or otherwise, the link could hang here.
		
		_suspendWatchdog=new SuspendWatchdog();
		_log.debug("Scheduling suspend watchdog for 5 minutes");
		_timer.schedule(_suspendWatchdog,5*60000);
		
	}

	/**
	 * 
	 */
	public synchronized void resumeLink() {
		// killing watchdog.
		if(_suspendWatchdog!=null)
			_suspendWatchdog.cancel();
		_suspendWatchdog=null;
		if(_keepAliveTask==null) {
			_log.debug("Creating keep alive timer");
			_keepAliveTask=new KeepAliveTask();
			_log.debug("Scheduling keep alive timer for 60 second intervals");
			_timer.scheduleAtFixedRate(_keepAliveTask,60000,60000);
		} else
			_log.warn("Resuming, but KeepAliveTask alreayd active");
		_bSuspend=false;
		try {
			// need to drain queue.
			drainQueue();
		} catch (IOException e) {
			if(_bRunning) {
				// link error.
				_log.error("Link error",e);
			}
			close();
		}
	}


}
