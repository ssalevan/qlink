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
	Created on Sep 30, 2005
	
 */
package org.jbrain.qlink.user;


public class UserInfo {

	private String _sCity;
	private String _sState;
	private String _sName;
	private String _sCountry;
	private String _sEmail;

	/**
	 * 
	 */
	public UserInfo(String name, String city, String state, String country,String email) {
		_sName=name;
		_sCity=city;
		_sState=state;
		_sCountry=country;
		_sEmail=email;
	}

	/**
	 * @return
	 */
	public String getCity() {
		return _sCity;
	}

	/**
	 * @return
	 */
	public String getState() {
		return _sState;
	}

	/**
	 * @return
	 */
	public String getName() {
		return _sName;
	}

	/**
	 * @return
	 */
	public String getCountry() {
		return _sCountry;
	}

	
}
