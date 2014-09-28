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
	Created on Aug 24, 2005
	
 */
package org.jbrain.qlink.util;

import java.util.StringTokenizer;


public class QuotedStringTokenizer extends StringTokenizer {
	private int _iPos;
	private String delims;
	private String str;
	
	public QuotedStringTokenizer(String arg0) {
		super(arg0);
		delims=" ";
		str=arg0;
		_iPos=0;
	}
	
	public boolean hasMoreTokens() {
		return _iPos!=str.length();
	}
	
	public int countTokens() {
		int i=0;
		int keep=_iPos;
		while(hasMoreTokens()) {
			nextToken();
			i++;
		}
		_iPos=keep;
		return i;
	}
	
	public String nextToken(String delim) {
		delims=delim;
		return nextToken();
	}
	
	public String nextToken() {
		boolean bQuotes=(_iPos<str.length()&&str.charAt(_iPos)=='"');
		if(bQuotes) {
			_iPos++;
		}
		int start=_iPos;
		int len=str.length();
		char ch;
		
		while(_iPos<len) {
			ch=str.charAt(_iPos);
			if(_iPos==start && delims.indexOf(str.charAt(_iPos))>-1)
				start++;
			else if(ch=='"' && bQuotes) {
				if(_iPos+1==len || delims.indexOf(str.charAt(_iPos+1))>-1)
					return str.substring(start,(_iPos+=2)-2);
			} else if(delims.indexOf(ch)>-1 && !bQuotes)
					return str.substring(start,(++_iPos)-1);
			_iPos++;
		}
		if(_iPos!=start)
			return str.substring(start,_iPos);
		else
			throw new java.util.NoSuchElementException();
	}
	
	
	public static void main(String[] args) {
		String text="/msg \"QTEST Jim\" Hi There";
		
		QuotedStringTokenizer t=new QuotedStringTokenizer(text);
		while(t.hasMoreTokens())
			System.out.println(t.nextToken(" "));
	}
}
