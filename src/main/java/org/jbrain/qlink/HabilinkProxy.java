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

import java.io.*;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class HabilinkProxy {
  private static Logger _log = Logger.getLogger(HabilinkProxy.class);

  private static final Pattern USERNAME_REGEX = Pattern.compile("\"name\":\\s*\"(.*)\"");

  private String _username;

  private InputStream _clientInput;
  private OutputStream _clientOutput;

  private UsernameScanningProxyThread _usernameScanner;

  class UsernameScanningProxyThread extends Thread {
    private BufferedReader clientInputReader;
    private HabilinkProxy proxy;

    private boolean shutdown;

    public UsernameScanningProxyThread(HabilinkProxy proxy, InputStream clientInput) {
      try {
        clientInputReader = new BufferedReader(new InputStreamReader(clientInput, "ISO-8859-1"));
        this.proxy = proxy;
      } catch (UnsupportedEncodingException e) {
        _log.fatal("US-ASCII is not supported", e);
      }
      setDaemon(true);
    }

    public void shutdown() {
      shutdown = true;
    }

    public void run() {
      String line;
      String username = null;
      try {
        do {
          // Proxies the line to the Neohabitat server.
          line = clientInputReader.readLine();

          _log.debug("Received Habilink line: " + line);
          if (line == null) {
            _log.error("Connection prematurely terminated");
          } else if (username != null) {
            proxy.notifyLogin(username);
            return;
          } else {
            Matcher usernameMatcher = USERNAME_REGEX.matcher(line);
            if (usernameMatcher.find()) {
              username = usernameMatcher.group(1);
            }
          }
        } while (line != null && !shutdown);
      } catch (IOException e) {
        _log.error("Received error during packet negotiation", e);
      }
    }
  }

  public HabilinkProxy(InputStream clientInput, OutputStream clientOutput) {
    _clientInput = clientInput;
    _clientOutput = clientOutput;
  }

  private synchronized void notifyLogin(String username) {
    _log.debug("New Habilink login with username: " + username);
    _username = username;
    this.notifyAll();
  }

  /** @return Username of the logged-in Habitat user. */
  public synchronized String login() {
    _usernameScanner = new UsernameScanningProxyThread(this, _clientInput);
    _usernameScanner.start();

    // Waits up to 5 minutes to detect a username.
    try {
      wait(300000);
    } catch (InterruptedException e) {
      _log.debug("Habilink wait was interrupted");
    }
    _usernameScanner.shutdown();

    if (_username == null) {
      _log.warn("Unable to find Habilink username within 60 seconds");
    }

    return _username;
  }
}
