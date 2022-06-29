package org.jbrain.qlink.cmd.action;

import org.jbrain.qlink.cmd.CRCException;

import java.io.InputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.Socket;

public class HabitatAction extends AbstractAction {

  // Habitat actually uses the full suite of mnemonics that start with U, not just "U".
  public static final String MNEMONIC = "U";

  public static final String HABITAT_SERVER = "127.0.0.1";
  public static final int HABITAT_PORT = 1337;

  public HabitatAction(byte[] data, int start, int len) throws CRCException {
    super(data, start, len);
  }
}
