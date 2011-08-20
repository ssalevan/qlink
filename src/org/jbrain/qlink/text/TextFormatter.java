package org.jbrain.qlink.text;

import java.util.*;

public class TextFormatter { 
	
	private static final String pad="                                        ";
	public static final int FORMAT_NONE=1;
	public static final int FORMAT_JUSTIFIED=2;
	public static final int FORMAT_CENTERED=3;
	public static final int FORMAT_PADDED=4;
	private static final int LINE_LENGTH=40;

	private ArrayList _alText = new ArrayList();
	private int _iFormat;
	private int _iWidth;

	public TextFormatter(int format) {
		this(format,LINE_LENGTH);
	}
	
	public TextFormatter() {
		this(FORMAT_NONE,LINE_LENGTH);
	}
	
	public TextFormatter(int format,int width) {
		_iFormat=format;
		_iWidth=width;
	}
	
	/**
	 * @param string
	 */
	public synchronized void add(String string) {
		String[] parts=string.replaceAll("\r","").split("\n");
		for(int i=0;i<parts.length;i++) {
			//System.out.println("Adding: " + parts[i]);
			addParagraph(parts[i],0);
		}
		if(parts.length==0) {
			//String was "" or \n.  Add empty line.
			_alText.add("");
		}
		
		
	}
	
	/**
	 * @param list
	 * @param string
	 */
	private void addParagraph(String string, int pos) {
		int start=pos;
		if(pos+_iWidth>=string.length()) {
			addLine(string.substring(pos));
			// end of string state
		} else {
			// set pos for where we want to split.
			pos+=_iWidth;
			while(pos>start && string.charAt(pos)!=' ') {
				pos--;
			}
			if(pos==start) {
				pos+=_iWidth;
				// special case, string too long.
				addLine(string.substring(start,pos));
			} else {
				// continue backing up till no space is found.
				int pos2=pos;
				while(pos2>start && string.charAt(pos2)==' ')
					pos2--;
				if(pos2!=start) 
					addLine(string.substring(start,pos2+1));
				else {
					// case '    longline......'
					// add a blank line and continue on the next line.
					addLine("");
				}
			}
			// walk forward...
			while(pos < string.length() && string.charAt(pos)==' ')
				pos++;
			if(pos<string.length())
				addParagraph(string,pos);
		}
	}

	/**
	 * @param list
	 * @param string
	 * @param format
	 */
	private void addLine(String string) {
		switch(_iFormat) {
			case FORMAT_PADDED:
				_alText.add(string+pad.substring(0,_iWidth-string.length()));
				break;
			case FORMAT_JUSTIFIED:
				_alText.add(pad.substring(0,_iWidth-string.length())+string);
				break;
			case FORMAT_CENTERED:
				_alText.add(pad.substring(0,(_iWidth-string.length())/2)+string);
				break;
			default:
				_alText.add(string);
				break;
		}
	}
	
	public List getList() {
		return Collections.unmodifiableList(_alText);
	}
	
	public static void main (String a[]) {
        TextFormatter tf=new TextFormatter(TextFormatter.FORMAT_NONE,39);
        tf.add("      " + "my1stdl.prg" + "2222222222222222222222222" );
        tf.getList();
	}
} 