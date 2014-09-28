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
	Created on Aug 12, 2005
	
 */
package org.jbrain.qlink.cmd.action;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class PostingItem extends AbstractAction {
	private static final String pad="                        (R";
	public static final int NEXT = 1;
	public static final int PAUSE = 2;
	public static final int LAST = 3;
	private String _sTitle;
	private String _sAuthor;
	private int _iReplies;
	private Date _date;
	boolean _bHeading=false;
	private int _iID;

	
	/**
	 * @param id
	 * @param title
	 * @param author
	 * @param replies
	 * @param date
	 * @param b
	 */
	public PostingItem(int id, String title, String author, int replies, Date date, int type) {
		super(type==NEXT?"KF":type==LAST?"KG":"KK");
		_iID=id;
		_sTitle=title;
		_sAuthor=author;
		_iReplies=replies;
		_date=date;
	}

	/**
	 * @param string
	 * @param last2
	 */
	public PostingItem(String title, int type) {
		super(type==NEXT?"KF":type==LAST?"KG":"KK");
		_sTitle=title;
		_bHeading=true;
	}

	private String makeString(int id, String title, String author, int replies, Date date) {
		StringBuffer sb=new StringBuffer();
		sb.append("    SUBJ: ");
		if(replies>0) {
			if(title.length()> 23) {
				sb.append(title.substring(0,20).trim());
				sb.append("... (");
			} else {
				sb.append(title);
				sb.append(pad.substring(title.length()));
			}
			sb.append(replies);
			sb.append(")");
		} else if(title.length()>29) {
			sb.append(title.substring(0,26).trim());
			sb.append("...");
		} else
			sb.append(title);
		sb.append((char)0xff);
		sb.append("     FROM: ");
		sb.append(author);
		sb.append(pad.substring(0,11-author.length()));
		SimpleDateFormat sdf= new SimpleDateFormat("MM/dd");
		sb.append(sdf.format(date));
		sb.append("  S#: ");
		DecimalFormat df=new DecimalFormat("000000");
		sb.append(df.format(id));
		return sb.toString();
	}
	
	public byte[] getBytes() {
		byte[] b;
		if(_bHeading)
			b=getBytes("    " + _sTitle);
		else
			b=getBytes(makeString(_iID,_sTitle,_sAuthor,_iReplies,_date));
		byte[] data=new byte[10 + b.length];
		System.arraycopy(b,0,data,10,b.length);
		finalizeCmd(data);
		return data;
	}	
	
}
