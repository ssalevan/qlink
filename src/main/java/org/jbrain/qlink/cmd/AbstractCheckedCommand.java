/*
Copyright Jim Brain and Brain Innovations, 2005.

This file is part of QLink.

QLink is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

QLink is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with QLink; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

@author Jim Brain
Created on Jul 14, 2005

*/
package org.jbrain.qlink.cmd;

public abstract class AbstractCheckedCommand extends AbstractCommand {

  // you call this to create a command
  public AbstractCheckedCommand(byte cmd) {
    super(cmd);
  }

  /**
   * @param cmd_ping
   * @param data
   * @param start
   * @param len
   */
  // you call this on receipt of data
  public AbstractCheckedCommand(byte[] data, int start, int len) throws CRCException {
    super(data, start, len);
    if (_iReportedCRC != _iCalculatedCRC) {
      throw new CRCException(_iReportedCRC + "!=" + _iCalculatedCRC);
    }
  }
}
