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
	Created on Jul 23, 2005
	
 */
package org.jbrain.qlink.state;

import java.io.IOException;

import org.apache.log4j.Logger;
import org.jbrain.qlink.*;
import org.jbrain.qlink.cmd.action.*;
import org.jbrain.qlink.dialog.*;
import org.jbrain.qlink.user.UserManager;


public class GetUserInfoState extends AbstractState {
	private static Logger _log=Logger.getLogger(GetUserInfoState.class);
	private static EntryDialog _nameDialog;
	private static EntryDialog _cityDialog;
	private static EntryDialog _stateDialog;
	private static EntryDialog _countryDialog;
	private EntryDialog _verifyDialog;
	//private YesNoDialog _verifyDialog;
	private String _sName;
	private String _sCity;
	private String _sState;
	private String _sCountry;
	private boolean _bGoodData;

	private DialogCallBack _nameCallBack = new DialogCallBack() {
		public boolean handleResponse(AbstractDialog d, Action a) throws IOException {
			_log.debug("We received " + a.getName() + " from entry dialog");
			if (a instanceof ZA) {
				_sName = ((ZA) a).getResponse().trim();
				if(_sName.equals("")) {
					_session.send(((EntryDialog) d).getErrorResponse("Please enter a valid name."));
				} else {
					_log.debug("User entered Name: " + _sName);
					_session.send(((EntryDialog) d).getSuccessResponse("Thank you."));
			    	return true;
				}
			} else if (a instanceof D2) {
				_log.debug("We received Dialog closing");
		    	EntryDialogState state=new EntryDialogState(_session,_cityDialog,_cityCallBack);
		    	state.activate();
				return true;
			}
			return false;
		}
	};

	private DialogCallBack _cityCallBack = new DialogCallBack() {
		public boolean handleResponse(AbstractDialog d, Action a) throws IOException {
			_log.debug("We received " + a.getName() + " from entry dialog");
			if (a instanceof ZA) {
				_sCity = ((ZA) a).getResponse().trim();
				if(_sCity.equals("")) {
					_session.send(((EntryDialog) d).getErrorResponse("Please enter a valid city."));
				} else {
					_log.debug("User entered City: " + _sCity);
					_session.send(((EntryDialog) d).getSuccessResponse("Thank you."));
			    	return true;
				}
			} else if (a instanceof D2) {
				_log.debug("Closing city dialog, opening state dialog");
		    	EntryDialogState state=new EntryDialogState(_session,_stateDialog,_stateCallBack);
		    	state.activate();
				return true;
			}
			return false;
		}
	};

	private DialogCallBack _stateCallBack = new DialogCallBack() {
		public boolean handleResponse(AbstractDialog d, Action a) throws IOException {
			_log.debug("We received " + a.getName() + " from entry dialog");
			if (a instanceof ZA) {
				_sState = ((ZA) a).getResponse().trim();
				if(_sState.equals("")) {
					_session.send(((EntryDialog) d).getErrorResponse("Please enter a valid state/province."));
				} else {
					_session.send(((EntryDialog) d).getSuccessResponse("Thank you."));
					_log.debug("User entered State: " + _sState);
			    	return true;
				}
			} else if (a instanceof D2) {
				_log.debug("Closing state dialog, opening country dialog");
		    	EntryDialogState state=new EntryDialogState(_session,_countryDialog,_countryCallBack);
		    	state.activate();
				return true;
			}
			return false;
		}
	};
	
	private DialogCallBack _countryCallBack = new DialogCallBack() {
		public boolean handleResponse(AbstractDialog d, Action a) throws IOException {
			_log.debug("We received " + a.getName() + " from entry dialog");
			if (a instanceof ZA) {
				_sCountry = ((ZA) a).getResponse().trim();
				if(_sCountry.equals("")) {
					_session.send(((EntryDialog) d).getErrorResponse("Please enter a valid state/province."));
				} else {
					_session.send(((EntryDialog) d).getSuccessResponse("Thank you."));
					_log.debug("User entered Country: " + _sCountry);
			    	return true;
				}
			} else if (a instanceof D2) {
				_log.debug("We received Dialog closing");
				//_verifyDialog=new YesNoDialog("DATAOK", YesNoDialog.TYPE_LOGIN, YesNoDialog.FORMAT_NONE);
				_verifyDialog=new EntryDialog("DATAOK", YesNoDialog.TYPE_LOGIN, YesNoDialog.FORMAT_NONE);
				_verifyDialog.addText("You provided the following information:");
				_verifyDialog.addText("\n");
				_verifyDialog.addText("Name   : " + _sName);
				_verifyDialog.addText("City   : " + _sCity);
				_verifyDialog.addText("State  : " + _sState);
				_verifyDialog.addText("Country: " + _sCountry);
				_verifyDialog.addText("\nIs this information correct ('yes' or 'no')?");
		    	//QState state=new YesNoMaybeDialogState(_session,_verifyDialog,_verifyCallBack);
		    	QState state=new EntryDialogState(_session,_verifyDialog,_verifyCallBack);
		    	state.activate();
				return true;
			}
			return false;
		}
	};

	private DialogCallBack _verifyCallBack = new DialogCallBack() {

		public boolean handleResponse(AbstractDialog d, Action a) throws IOException {
			_log.debug("We received " + a.getName() + " from entry dialog");
			/*if (a instanceof DialogYes) {
				_session.send(((YesNoDialog)d).getSuccessResponse("Thank you."));
				_log.debug("User states data is correct");
		    	QState state=new MainMenu(_session);
		    	state.activate();
		    	return true;
			} else if (a instanceof DialogNo) {
				_log.debug("User states data in not correct");
		    	EntryDialogState state=new EntryDialogState(_session,_nameDialog,_nameCallBack);
		    	state.activate();
				return true;
			}*/
			if (a instanceof ZA) {
				if(((ZA)a).getResponse().trim().toLowerCase().startsWith("y")) {
					_session.send(((EntryDialog)d).getSuccessResponse("Thank you."));
					_log.debug("User states data is correct");
					_bGoodData=true;
			    	return true;
				} else if (((ZA)a).getResponse().trim().toLowerCase().startsWith("n")) {
					_log.debug("User states data in not correct");
					_session.send(((EntryDialog)d).getSuccessResponse("Starting over."));
					_bGoodData=false;
			    	return true;
				} else {
					_session.send(((EntryDialog)d).getErrorResponse("Answer the question with 'yes' or 'no'"));
				}
			} else if(a instanceof D2) {
				QState state;
				if(_bGoodData) {
					try {
						UserManager.updateUserInfo(_session.getUserID(),_sName,_sCity,_sState,_sCountry);
					} catch (Exception e) {
						_log.error("Could not add user information...");
					}
					state=new MainMenu(_session);
				} else
			    	state=new EntryDialogState(_session,_nameDialog,_nameCallBack);
		    	state.activate();
			}
			return false;
		}
	};

	private QState _intState;

	static {
		// define a static dialog for this.
		_log.debug("Defining ADDNAME dialog");
		_nameDialog=new EntryDialog("ADDNAME", EntryDialog.TYPE_LOGIN, EntryDialog.FORMAT_NONE);
		_nameDialog.addText("Before you begin your Q-Link experience, we need to ask you a few questions about yourself.  Please enter correct information to the following questions.\n\nPlease enter your first and last name.");
		_log.debug("Defining ADDCITY dialog");
		_cityDialog=new EntryDialog("ADDCITY", EntryDialog.TYPE_LOGIN, EntryDialog.FORMAT_NONE);
		_cityDialog.addText("Please enter your city of residence.");
		_log.debug("Defining ADDSTATE dialog");
		_stateDialog=new EntryDialog("ADDSTATE", EntryDialog.TYPE_LOGIN, EntryDialog.FORMAT_NONE);
		_stateDialog.addText("Please enter the your state/province of residence. You may either enter the state/province abbrevation or the complete name");
		_log.debug("Defining ADDCNTY dialog");
		_countryDialog=new EntryDialog("ADDCNTY", EntryDialog.TYPE_LOGIN, EntryDialog.FORMAT_NONE);
		_countryDialog.addText("Please enter your country of residence.  Abbrevations (like USA) may be used in lieu of the entire country name.");
		_log.debug("Defining DATAOK dialog");
	}
	
	public GetUserInfoState(QSession session) {
		super(session);
	}
	
	public void activate() throws IOException {
    	_session.send(new ClearScreen());
    	super.activate();
	}
	
	public boolean execute(Action a) throws IOException {
		if(a instanceof ClearScreen) {
	    	EntryDialogState state=new EntryDialogState(_session,_nameDialog,_nameCallBack);
	    	state.activate();
	    	return true;
		} else {
			return super.execute(a);
		}
	}
}
