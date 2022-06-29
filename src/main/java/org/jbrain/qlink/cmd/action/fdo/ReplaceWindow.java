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
Created on Oct 11, 2005

*/
package org.jbrain.qlink.cmd.action.fdo;

public class ReplaceWindow implements FDOWindowType {
  private int _iType;

  public ReplaceWindow(int type) {
    _iType = type;
  }

  public byte[] getBytes() {
    byte[] b = new byte[2];
    b[0] = (byte) CMD_WINDOW_TYPE;
    b[1] = (byte) _iType;
    return b;
  }

  public int size() {
    return 2;
  }
}
