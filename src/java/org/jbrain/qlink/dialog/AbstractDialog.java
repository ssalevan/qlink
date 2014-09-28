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
	Created on Jul 28, 2005
	
 */
package org.jbrain.qlink.dialog;

import java.util.*;

import org.jbrain.qlink.cmd.action.*;
import org.jbrain.qlink.text.TextFormatter;


public abstract class AbstractDialog {
	public static final int FORMAT_CENTERED = TextFormatter.FORMAT_CENTERED;
	public static final int FORMAT_NONE = TextFormatter.FORMAT_NONE;
	public static final int FORMAT_JUSTIFIED = TextFormatter.FORMAT_JUSTIFIED;
	public static final int TYPE_LOGIN = 1;
	public static final int TYPE_MENU = 2;
	public static final int TYPE_CHAT = 3;

	private String _sName;
	protected TextFormatter _text;

	protected int _iFormat;
	private int _iType;

	public AbstractDialog(String name, int dialogType) {
		this(name, dialogType, FORMAT_NONE);
	}
	
	public AbstractDialog(String name, int dialogType, int format) {
		_sName=name;
		_text=new TextFormatter(format);
		_iFormat=format;
		_iType=dialogType;
	}
	
	public String getName() {
		return _sName;
	}

	public void addText(String text) {
		_text.add(text);
	}
	
	public Action getPrepAction() {
		switch(_iType) {
			case TYPE_CHAT:
				return new CreateChatDialog(_sName);
			default:
				return new CreateDialog(_sName);
		}
	}

	public Action[] getTextActions() {
		List l=_text.getList();
		int size=l.size()-1;
		Action[] a=new Action[size];
		for(int i=0;i<size;i++) {
			switch(_iType) {
				case TYPE_CHAT:
					a[i]=new ChatDialogText(_sName,(String)l.get(i));
					break;
				default:
					a[i]=new DialogText(_sName,(String)l.get(i));
				break;
			}
		}
		return a;
	}
	
	public int getDialogType() {
		return _iType;
	}

	public abstract Action getResponseAction();

	public Action[] getSuccessResponse(String string) {
		TextFormatter tf=new TextFormatter();
		tf.add(string);
		tf.add("\n         <PRESS F5 TO CONTINUE>");
		List l=tf.getList();
		int size=l.size();
		Action[] actions=new Action[size];
		for(int i=0;i<(size-1);i++) {
			actions[i]=new DialogText(getName(),(String)l.get(i));
		}
		actions[size-1]=new PauseRequest(getName(),(String)l.get(size-1));
		return actions;
	}
	
	
}
