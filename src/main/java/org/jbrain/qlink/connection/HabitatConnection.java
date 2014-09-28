package org.jbrain.qlink.connection;

import java.io.InputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.ArrayList;
import java.util.Timer;
import java.util.TimerTask;
import java.util.Vector;

import org.apache.log4j.Logger;
import org.jbrain.qlink.cmd.*;
import org.jbrain.qlink.cmd.action.*;

import org.jbrain.qlink.cmd.CRCException;

public class HabitatConnection {

    public static final String HABITAT_SERVER = "192.168.0.45";
    public static final int HABITAT_PORT = 1337;
    private static Logger _log=Logger.getLogger(HabitatConnection.class);

    public HabitatConnection() {
        this(HABITAT_SERVER, HABITAT_PORT);
    }

    public static class HabitatReader extends Thread {
        public HabitatReader(InputStream i) { is = i; setDaemon(true); alive = true;}
        public boolean alive;
        public void run() {
            _log.info("Initiating Habitat Reader thread");
            int i = 0, start = 0, len = 0;
            byte data[] = new byte[256];
            try {
                while(alive && (i=is.read(data,len,256-len))>0) {
                    // should optimize this to not scan all over again each time.
                    len+=i;
                    for(i=0;i<len;i++) {
                        if(data[i]==QConnection.FRAME_END) {
                            // we have a valid packet, process.
                            
                            if(_log.isDebugEnabled()) {
                                QConnection.trace("Received Habitat Packet: ",data,start,i-start);
                            }
                            // TODO: ACTUALLY PROCESS PACKET ENOUGH TO FIGURE OUT WHO TO SEND IT TO //
                            if(start!=0) {
                                // move additional data to front of buffer.
                                len=len-start;
                                if(len>0)
                                    System.arraycopy(data,start,data,0,len);
                                start=0;
                            }
                        }
                    }
                }
            } catch (IOException e) {
                if(alive) {
                    // link error.
                    _log.error("Link error",e);
                }
            } catch (Exception e) {
                _log.error("Unchecked Exception error",e);
            } finally {
                try {
                    is.close();
                } catch (IOException e) {
                    _log.error("Close error", e);
                }
            }
        }
        private InputStream is;
    }

    public HabitatConnection(String server, int port) {
        try {
            serverSocket = new Socket(server, port);
            inputThread = new HabitatReader(serverSocket.getInputStream());
            outputStream = serverSocket.getOutputStream();
            inputThread.start();
        } catch (IOException e) {
            _log.warn("Failed to connect to habitat server. U messages will fall into the void.");
            _log.warn("Exception details: " + e.toString());
            serverSocket = null;
            inputThread = null;
            outputStream = null;
        }
    }

    public synchronized void send(byte[] msg) {
        try {
            if (outputStream != null) {
                if(_log.isDebugEnabled()) {
                    QConnection.trace("Sending Habitat Packet: ",msg,0,msg.length);
                }
                outputStream.write(msg, 0, msg.length);
                outputStream.flush();
            } else {
                _log.warn("Tried to send to a nonexistent Habitat server.");
            }
        } catch (IOException e) {
            _log.error("Habitat send error",e);
        }
    }

    public synchronized void close() {
        if (inputThread != null) {
            inputThread.alive = false;  // Signal to the reader thread that it's time to shut down
        }
        if (outputStream != null) {
            try {
                outputStream.close();
            } catch (IOException e) {
                _log.error("Habitat socket close error",e);
            }
            outputStream = null;
        }
    }

    private Socket serverSocket;
    private HabitatReader inputThread;
    private OutputStream outputStream;
}
