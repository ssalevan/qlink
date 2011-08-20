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
	Created on Oct 14, 2005
	
 */
package org.jbrain.qlink.cmd.action.fdo;


public class FDOStringResponse extends AbstractFDOResponse {
	
	private String _sText;

	public FDOStringResponse(String cmd, String text) {
		super(cmd,0x02);
		_sText=text;
		if(_sText==null) 
			throw new NullPointerException("Text is null");
	}

	/* (non-Javadoc)
	 * @see org.jbrain.qlink.cmd.action.fdo.FDOCommand#getBytes()
	 */
	public byte[] getBytes() {
		byte[] data = new byte[size()];
		byte[] b=this.getBytes(_sText);
		System.arraycopy(b,0,data,4,b.length);
		data[size()-1]=0;
		finalizeResponse(data);
		return data;
	}

	/* (non-Javadoc)
	 * @see org.jbrain.qlink.cmd.action.fdo.FDOCommand#size()
	 */
	public int size() {
		return 5+_sText.length();
	}

}
