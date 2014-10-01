package org.jbrain.qlink.connection;

import java.io.InputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;
import java.util.Vector;

import org.apache.log4j.Logger;
import org.jbrain.qlink.QConfig;
import org.jbrain.qlink.QLinkServer;
import org.jbrain.qlink.QSession;
import org.jbrain.qlink.cmd.*;
import org.jbrain.qlink.cmd.action.*;
import org.jbrain.qlink.user.QHandle;

import org.jbrain.qlink.cmd.CRCException;

public class HabitatConnection {

    private static Logger _log=Logger.getLogger(HabitatConnection.class);
    private QLinkServer _server;

    public HabitatConnection(QLinkServer server) {
        this(QConfig.getInstance().getString("qlink.habitat.host"),
             QConfig.getInstance().getInt("qlink.habitat.port"),
             server);
    }

    public class HabitatReader extends Thread {
        public HabitatReader(InputStream i) { is = i; setDaemon(true); alive = true;}
        public boolean alive;
        public void run() {
            _log.info("Initiating Habitat Reader thread");
            int i = 0, start = 0, len = 0;
            byte data[] = new byte[512];
            CommandFactory factory = new CommandFactory();
            try {
                /* Shamelessly copy-pasted from QConnection.run() - that code could do with being abstracted */
                while(alive && (i=is.read(data,len,512-len))>0) {
                    // should optimize this to not scan all over again each time.
                    len+=i;
                    for(i=0;i<len;i++) {
                        if(data[i]==QConnection.FRAME_END) {
                            // we have a valid packet, process.
                            
                            if(_log.isDebugEnabled()) {
                                QConnection.trace("Received Habitat Packet: ",data,start,i-start);
                            }
                            // TODO: THIS IS A FAKE FORMAT //
                            // username:raw frame info
                            for (int j = start; j < i; ++j) {
                                if (data[j] == ':') {
                                    String username = new String(data, start, j-start);
                                    QSession session = findSession(username);
                                    Action cmd = new ProxiedAction(data, j+1, i-j-1);
                                    if (session != null && cmd != null) {
                                        session.send(cmd);
                                    } else {
                                        _log.warn("Cannot send received Habitat packet to '" + username + "'");
                                    }
                                    break;
                                }
                            }
                            start = i+1;
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

        private QSession findSession(String key) {
            /* The actual key is a QHandle, so we need to do a more tedious search. */
            Map map = _server.getSessionMap();
            synchronized(map) {
                Iterator i = map.entrySet().iterator();
                while (i.hasNext()) {
                    Map.Entry e = (Map.Entry)(i.next());
                    if (key.equalsIgnoreCase(e.getKey().toString())) {
                        return (QSession)e.getValue();
                    }
                }
            }
            _log.warn("Received a habitat session for unknown user " + key);
            return null;
        }

        private InputStream is;
    }

    public HabitatConnection(String server, int port, QLinkServer serverobj) {
        _server = serverobj;
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

    public synchronized void send(byte[] msg, String user) {
        try {
            if (outputStream != null) {
                if(_log.isDebugEnabled()) {
                    QConnection.trace("Sending Habitat Packet: ",msg,0,msg.length);
                }
                /* This part is bogus for now; it's just the username and a colon */
                byte[] usermsg = user.getBytes("UTF8");
                outputStream.write(usermsg, 0, usermsg.length);
                byte[] colon = new byte[1];
                colon[0] = ':';
                outputStream.write(colon, 0, 1);
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
