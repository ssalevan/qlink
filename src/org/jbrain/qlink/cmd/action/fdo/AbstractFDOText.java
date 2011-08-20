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


public class AbstractFDOText extends AbstractFDOCommand {
	
	private String _sText;
	private int _iType;

	public AbstractFDOText(int type, String text) {
		_iType=type;
		_sText=text;
		if(text!=null && text.length()>116)
			throw new IllegalArgumentException("Text too long");
	}

	/* (non-Javadoc)
	 * @see org.jbrain.qlink.cmd.action.fdo.FDOCommand#getBytes()
	 */
	public byte[] getBytes() {
		byte[] b=getBytes(_sText.replace((char)0x0d,(char)0xff).replaceAll("\r",""));
		byte[] data=new byte[b.length+3];
		data[0]=(byte)_iType;
		data[1]=0;
		data[data.length-1]=0;
		
		System.arraycopy(b,0,data,2,b.length);
		return data;
	}

	/* (non-Javadoc)
	 * @see org.jbrain.qlink.cmd.action.fdo.FDOCommand#size()
	 */
	public int size() {
		return _sText.length()+3;
	}

}
