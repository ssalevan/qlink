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
	Created on Aug 31, 2005
	
 */
package org.jbrain.qlink.io;

import java.io.FilterInputStream;
import java.io.IOException;
import java.io.InputStream;


public class EscapedInputStream extends FilterInputStream implements QStream {
	private int _iEscape;
	
	public EscapedInputStream(InputStream is) {
		super(is);
	}
	
	public int read(byte[] b, int start, int len) throws IOException {
		// we need to make sure we call our own read() method, not the underlying transport's.
		if (b == null) {
		    throw new NullPointerException();
		} else if ((start < 0) || (start > b.length) || (len < 0) ||
			   ((start + len) > b.length) || ((start + len) < 0)) {
		    throw new IndexOutOfBoundsException();
		} else if (len == 0) {
		    return 0;
		}

		int c = read();
		if (c == -1) {
		    return -1;
		}
		b[start] = (byte)c;

		int i = 1;
		try {
		    for (; i < len ; i++) {
				c = read();
				if (c == -1) {
				    break;
				}
				if (b != null) {
				    b[start + i] = (byte)c;
				}
		    }
		} catch (IOException e) { }
		return i;
	}
	
	public int read() throws IOException {
		int rc;
		
		if(_iEscape>-1) {
			rc=_iEscape ^ ESCAPE_XOR;
			_iEscape=-1;
		} else {
			rc=super.read();
			switch(rc) {
				case 0x00:
				case 0x0d:
				case 0x0e:
				case 0x5d:
				case 0xff:
					_iEscape=rc;
					rc=ESCAPE;
					break;
			}
		}
		return rc;
	}
	
	public int available() throws IOException {
		return super.available()+(_iEscape!=-1?1:0);
	}
	
	public boolean markSupported() {
		return false;
	}
}
