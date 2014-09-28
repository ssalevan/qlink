package org.jbrain.qlink.cmd.action;

import org.jbrain.qlink.cmd.CRCException;

import java.io.InputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.Socket;


public class HabitatAction extends AbstractAction {

  public static final String MNEMONIC = "U";

  public static final String HABITAT_SERVER = "a.habitat.server";
  public static final int HABITAT_PORT = 1337;

  public HabitatAction(byte[] data, int start, int len) throws CRCException {
    super(HabitatAction.MNEMONIC);
  }

  public void sendToHabitatServer() throws IOException {
    byte[] toSend = this.getBytes();

    while (true) {
      Socket client = null, server = null;
      try {
        // Make a connection to the real server.
        // If we cannot connect to the server, send an error to the
        // client, disconnect, and continue waiting for connections.
        try {
          server = new Socket(HabitatAction.HABITAT_SERVER,
              HabitatAction.HABITAT_PORT);
        } catch (IOException e) {
          continue;
        }

        // Get server streams.
        final OutputStream streamToServer = server.getOutputStream();

        streamToServer.write(toSend, 0, toSend.length);
        streamToServer.flush();

        // The server closed its connection to us, so we close our
        // connection to our client.
        streamToServer.close();
      } catch (IOException e) {
        System.err.println(e);
      } finally {
        try {
          if (server != null)
            server.close();
          if (client != null)
            client.close();
        } catch (IOException e) {
        }
      }
    }
  }

}
