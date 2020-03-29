package org.jbrain.qlink;

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
*/

import org.apache.log4j.Logger;
import org.jbrain.qlink.chat.ChatProfile;
import org.jbrain.qlink.chat.Game;
import org.jbrain.qlink.chat.QRoom;
import org.jbrain.qlink.chat.RoomManager;
import org.jbrain.qlink.connection.QConnection;
import org.jbrain.qlink.state.PlayGame;
import org.jbrain.qlink.state.QState;
import org.jbrain.qlink.user.QHandle;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;

public class HabilinkListener extends Thread {
  private static Logger _log = Logger.getLogger(HabilinkListener.class);
  private int _iPort;
  private String _sAddress;
  private QLinkServer _server;

  class ProxyThread extends Thread {
    Socket _socket;

    public ProxyThread(QLinkServer server, Socket s) {
      _server = server;
      _socket = s;
      setDaemon(true);
      start();
    }

    public void run() {
      InputStream clientInput;
      OutputStream clientOutput;
      QConnection conn;
      QSession session;

      try {
        clientInput = _socket.getInputStream();
        clientOutput = _socket.getOutputStream();

        // Waits for a successful login from the thin client.
        HabilinkProxy proxy = new HabilinkProxy(clientInput, clientOutput);
        String username = proxy.login();

        // Thin client now exec()s the original Habitat client, so rigs up a QuantumLink environment
        // and protocol for the logged-in Habitat user.
        if (username != null) {
          _log.debug("Habilink user '" + username + "' logged in; starting QConnection/QSession");
          conn =
              new QConnection(
                  clientInput,
                  clientOutput,
                  _server,
                  username,
                  QConnection.SEQ_LOW,
                  QConnection.SEQ_LOW);

          QHandle qHandle = new QHandle(username);

          session = new QSession(_server, conn, qHandle);
          _server.addSession(session);
        } else {
          _log.error("Unable to find username for Habilink connection");
        }
      } catch (IOException e) {
        _log.error(e);
      }
    }
  }

  /**
   * @param server
   * @param port
   */
  public HabilinkListener(QLinkServer server, String address, int port) {
    _iPort = port;
    _sAddress = address;
    _server = server;
    start();
  }

  public void run() {
    int rc = 0;
    ArrayList servers = new ArrayList();
    QConnection conn;
    QSession session;
    ServerSocket serverSocket = null;
    Socket clientSocket = null;

    if (rc == 0) {
      try {
        serverSocket = new ServerSocket();
        serverSocket.bind(new InetSocketAddress(InetAddress.getByName(_sAddress), _iPort));
      } catch (IOException e) {
        _log.fatal("Could not listen on port " + _iPort, e);
        rc = -1;
      }
    }
    if (rc == 0) {
      try {
        while (true) {
          clientSocket = serverSocket.accept();
          _log.info("Incoming connection received");
          new ProxyThread(_server, clientSocket);
        }
      } catch (IOException e) {
        _log.fatal("TCP/IP accept failed.", e);
        rc = -1;
      }
    }
    _log.info("Terminating TCPListener for port " + _iPort);
  }
}
