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
	Created on Jul 22, 2005
	
 */
package org.jbrain.qlink.cmd.action;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.jbrain.qlink.cmd.CRCException;


public class SelectDateReply extends AbstractMenuItem {

	public static final String MNEMONIC = "K2";
	private Date _date;
	/**
	 * @param data
	 * @param start
	 * @param len
	 * @throws CRCException
	 */
	public SelectDateReply(byte[] data, int start, int len) throws CRCException {
		super(data, start, len);
		_iID=decode(data,start+10);
		SimpleDateFormat sdf=new SimpleDateFormat("MM/dd/yy");
		try {
			_date=sdf.parse(getString(data,start+15,len-15));
		} catch (ParseException e) {
			// TODO What should we send back
			throw new IllegalArgumentException("Invalid Date String");
		}
	}
	/**
	 * @return
	 */
	public int getID() {
		return _iID;
	}
	/**
	 * @return
	 */
	public Date getDate() {
		return _date;
	}
	
}
