package org.jbrain.qlink.connection;

import java.io.InputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.Socket;
import java.net.SocketException;
import java.util.ArrayList;
import java.util.Map;

import org.apache.log4j.Logger;
import org.jbrain.qlink.QConfig;
import org.jbrain.qlink.QLinkServer;
import org.jbrain.qlink.QSession;
import org.jbrain.qlink.cmd.action.*;
import org.jbrain.qlink.user.QHandle;

public class HabitatConnection {

  public static final int MAX_SEND_RETRIES = 15;

  public static final byte FRAME_START = -85;
  public static final byte FRAME_END = -70;
  public static final byte ESCAPE_BYTE = 94;

  private static Logger _log = Logger.getLogger(HabitatConnection.class);
  private QLinkServer _qServer;
  private String _serverHost;
  private int _serverPort;
  private boolean _useFraming;
  private String _username;
  private QSession _qSession;

  private HabitatReader inputThread;
  private OutputStream outputStream;
  private Socket serverSocket;

  public HabitatConnection(QLinkServer server) {
    this(
        System.getenv("QLINK_HABITAT_HOST"),
        System.getenv("QLINK_HABITAT_PORT"),
        server,
        null,
        null,
        System.getenv("QLINK_HABITAT_USE_FRAMING"));
  }

  public HabitatConnection(QLinkServer server, QSession qSession, String username) {
    this(
        System.getenv("QLINK_HABITAT_HOST"),
        System.getenv("QLINK_HABITAT_PORT"),
        server,
        qSession,
        username,
        System.getenv("QLINK_HABITAT_USE_FRAMING"));
  }

  public class HabitatReader extends Thread {
    public static final int BUFFER_LENGTH = 512;

    public HabitatReader(InputStream i, QSession qSession) {
      is = i;
      setDaemon(true);
      alive = true;
      _shutdown = false;
      _qSession = qSession;
    }

    public boolean alive;

    private boolean _shutdown;
    private InputStream is;

    public QSession getQSession(String username) {
      /* The actual key is a QHandle, so we need to do a more tedious search. */
      String handleSessionLookupKey = new QHandle(username).getKey();
      return (QSession) _qServer.getSessionMap().get(handleSessionLookupKey);
    }

    public void shutdown() {
      _shutdown = true;
    }

    public void run() {
      _log.info("Initiating Habitat Reader thread");
      int i = 0, start = 0, len = 0;
      byte data[] = new byte[BUFFER_LENGTH];
      try {
        /* Shamelessly copy-pasted from QConnection.run() - that code could do with being abstracted */
        while (!_shutdown && (i = is.read(data, len, BUFFER_LENGTH - len)) > 0) {
          // should optimize this to not scan all over again each time.
          len += i;
          for (i = 0; i < len; i++) {
            if (data[i] == QConnection.FRAME_END) {
              // we have a valid packet, process.
              if (_log.isDebugEnabled()) {
                QConnection.trace("Received Habitat Packet: ", data, start, i - start);
              }

              // username:raw frame info
              for (int j = start; j < i; ++j) {
                if (data[j] == ':') {
                  String username = new String(data, start, j - start);
                  QSession session = getQSession(username);
                  Action cmd = new ProxiedAction(data, j + 1, i - j - 1);
                  if (session != null) {
                    session.send(cmd);
                  } else {
                    _log.warn("Cannot send received Habitat packet");
                  }
                  break;
                }
              }
              start = i + 1;
              if (start != 0) {
                // move additional data to front of buffer.
                len = len - start;
                if (len > 0) System.arraycopy(data, start, data, 0, len);
                start = 0;
              }
            }
          }
        }
      } catch (IOException e) {
        if (!_shutdown) {
          // link error.
          _log.error("Link error", e);
        }
      } catch (Exception e) {
        _log.error("Unchecked Exception error", e);
      } finally {
        try {
          is.close();
        } catch (IOException e) {
          _log.error("Close error", e);
        }
      }
      alive = false;
    }
  }

  public HabitatConnection(
      String server, String port, QLinkServer serverobj, QSession qSession, String username,
      String useFraming) {
    if (server == null) {
      server = QConfig.getInstance().getString("qlink.habitat.host");
    }

    if (port == null) {
      port = QConfig.getInstance().getString("qlink.habitat.port");
    }

    if (useFraming.toLowerCase() == "true") {
      _useFraming = true;
    }

    _qServer = serverobj;
    _qSession = qSession;
    _serverHost = server;
    _serverPort = Integer.parseInt(port);
    _username = username;
  }

  public void connect() {
    try {
      serverSocket = new Socket(_serverHost, _serverPort);
      inputThread = new HabitatReader(serverSocket.getInputStream(), _qSession);
      outputStream = serverSocket.getOutputStream();
      inputThread.start();
    } catch (IOException e) {
      _log.warn("Failed to connect to Habitat server. U messages will fall into the void.");
      _log.warn("Exception details:", e);
      close();
    }
  }

  public void reconnect() {
    close();
    connect();
  }

  public synchronized void send(byte[] msg, String user) {
    if (user == null || user.equals("UNKNOWN")) {
      user = _username;
    }

    for (int retries = 0; retries < MAX_SEND_RETRIES; retries++) {
      try {
        if (outputStream != null) {
          if (_log.isDebugEnabled()) {
            QConnection.trace("Sending Habitat Packet: ", msg, 0, msg.length);
          }
          /* This part is bogus for now; it's just the username and a colon */
          byte[] usermsg = user.getBytes("UTF8");
          byte[] fullmsg = new byte[usermsg.length + 1 + msg.length];
          System.arraycopy(usermsg, 0, fullmsg, 0, usermsg.length);
          fullmsg[usermsg.length] = ':';
          System.arraycopy(msg, 0, fullmsg, usermsg.length + 1, msg.length);
          if (_useFraming) {
            ArrayList<Byte> escapedMsg = new ArrayList<Byte>();
            for (byte curByte : msg) {
              if (curByte == FRAME_START || curByte == FRAME_END || curByte == ESCAPE_BYTE) {
                escapedMsg.add(ESCAPE_BYTE);
                escapedMsg.add(curByte);
                continue;
              }
              escapedMsg.add(curByte);
            }
            Integer msgSize = escapedMsg.size();
            ArrayList<Byte> framedMsg = new ArrayList<Byte>();
            framedMsg.add(FRAME_START);
            framedMsg.add(msgSize.byteValue());
            framedMsg.addAll(escapedMsg);
            framedMsg.add(FRAME_END);
            byte[] framedMsgArray = new byte[framedMsg.size()];
            for (int i = 0; i < framedMsgArray.length; i++) {
              framedMsgArray[i] = framedMsg.get(i);
            }
            outputStream.write(framedMsgArray, 0, framedMsgArray.length);
          } else {
            outputStream.write(fullmsg, 0, fullmsg.length);
            outputStream.flush();
          }
        } else {
          _log.warn("Tried to send to a nonexistent Habitat server.");
          reconnect();
          continue;
        }
      } catch (IOException e) {
        _log.warn("Habitat send error", e);
        reconnect();
        continue;
      }
      return;
    }
    _log.error(
        "Unable to send Habitat packet to user " + user + " after " + MAX_SEND_RETRIES + "retries");
  }

  public void close() {
    if (inputThread != null) {
      inputThread.shutdown();
    }
    if (outputStream != null) {
      try {
        outputStream.close();
      } catch (IOException e) {
        _log.error("Habitat socket close error", e);
      }
      outputStream = null;
    }
    if (serverSocket != null) {
      try {
        serverSocket.close();
      } catch (IOException e) {
        _log.error("Unable to close Habitat server socket", e);
      }
    }
  }
}
