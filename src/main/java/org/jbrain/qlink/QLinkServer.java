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
	Created on Oct 5, 2005
	
 */
package org.jbrain.qlink;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import org.apache.commons.cli.PosixParser;
import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.CommandLineParser;
import org.apache.commons.cli.HelpFormatter;
import org.apache.commons.cli.Option;
import org.apache.commons.cli.OptionBuilder;
import org.apache.commons.cli.Options;
import org.apache.commons.cli.ParseException;

import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;
import org.jbrain.qlink.cmd.action.Action;
import org.jbrain.qlink.cmd.action.Toss;
import org.jbrain.qlink.db.DBUtils;
import org.jbrain.qlink.extensions.RoomAuditor;
import org.jbrain.qlink.user.QHandle;


public class QLinkServer {

	public static final int DEFAULT_QTCP_PORT = 5190;
	public static final String DEFAULT_QTCP_HOST = "0.0.0.0";

	public static final int DEFAULT_HABILINK_PORT = 1986;
	public static final String DEFAULT_HABILINK_HOST = "0.0.0.0";

	private static Logger _log=Logger.getLogger(QLinkServer.class);
	private static PropertiesConfiguration _config = null;
	private Vector _vSessions=new Vector();
	private Hashtable _htSessions=new Hashtable();
	private Date _started=new Date();
	private Date _newest;
	private static int _iSessionCount=0;
	private static int _iErrorCount=0;

	private SessionEventListener _listener=new SessionEventListener() {

		public void userNameChanged(UserNameChangeEvent event) {
			if(event.getOldHandle() !=null) {
				// we are changing names...
				_log.info("Changing online user from '" + event.getOldHandle() +"' to '" + event.getNewHandle() + "' in online user list");
			} else {
				_log.info("Adding '" + event.getNewHandle() + "' to online user list");
			}
			changeUserName(event.getSession(),event.getOldHandle(),event.getNewHandle());
		}
		public void stateChanged(StateChangeEvent event) {
		}
		public void sessionTerminated(TerminationEvent event) {
			removeSession(event.getSession());
		}
	};
	/**
	 * @param session
	 */
	public void addSession(QSession session) {
		if(!_vSessions.contains(session)) {
			_log.info("Adding session to session list: " + session.getHandle().getKey());
			_vSessions.add(session);
			_newest=new Date();
			_iSessionCount++;
			session.addEventListener(_listener);
		}
		if(session != null && session.getHandle() != null && !_htSessions.contains(session.getHandle().getKey())) {
			_log.info("Adding session to session map: " + session.getHandle().getKey());
			_htSessions.put(session.getHandle().getKey(), session);
		}
	}

	/**
	 * @param session
	 */
	public void removeSession(QSession session) {
		_log.info("Removing session from session list: " + session.getHandle().getKey());
		if(session.getHandle()!=null) {
			_log.info("Removing '" + session.getHandle() + "' from online user list");
			_htSessions.remove(session.getHandle().getKey());
		} else {
			_iErrorCount++;
		}
		_vSessions.remove(session);
		session.removeEventListener(_listener);
	}

	/**
	 * @param msg
	 */
	public void sendSYSOLM(String msg) {
		QSession s;
		
		synchronized(_htSessions) {
			Iterator i=_htSessions.values().iterator();
			while(i.hasNext()) {
				s=(QSession)i.next();
				s.sendSYSOLM(msg);
			}
			
		}
	}

	/**
	 * @param name
	 */
	public boolean killSession(QHandle handle) {
		QSession s=getSession(handle);
		if(s!=null) {
			s.terminate();
			return true;
		}
		return false;
	}
	
	public boolean canReceiveOLMs(QHandle handle) {
		QSession session=getSession(handle);
		return (session != null && session.canReceiveOLMs());
	}

	public List getSessionList() {
		return _vSessions;
	}
	
	public Map getSessionMap() {
		return _htSessions;
	}

	public Map getAttributes() {
		HashMap m=new HashMap();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		m.put("OpenSessions",new Integer(_vSessions.size()));
		m.put("UsersLoggedIn",new Integer(_htSessions.size()));
		m.put("ServerStarted",df.format(_started));
		m.put("NewestSession",df.format(_newest));
		m.put("SessionCount",new Integer(_iSessionCount));
		m.put("ErrorCount",new Integer(_iErrorCount));
		
		return m;
	}

	/**
	 * @param recipient
	 * @param objects
	 */
	public void sendOLM(QHandle handle, String[] olm) {
		QSession s=getSession(handle);
		if(s!= null && s.canReceiveOLMs()) {
			s.sendOLM(olm);
		}
	}

	/**
	 * @return
	 */
	public boolean isUserOnline(QHandle handle) {
		return getSession(handle) != null;
	}

	public boolean sendToUser(QHandle handle, Action a) {
		QSession s=getSession(handle);
		_log.debug("Attempting to send action to another user: " + handle);
		if(s!=null) {
			return s.send(a);
		}
		return false;
	}

	private QSession getSession(QHandle handle) {
		return (QSession)_htSessions.get(handle.getKey());
	}

	/**
	 * @param session
	 * @param oldHandle
	 * @param handle
	 */
	private void changeUserName(QSession session, QHandle oldHandle, QHandle handle) {
		synchronized(_htSessions) {
			if(oldHandle!=null)
				_htSessions.remove(oldHandle.getKey());
			_htSessions.put(handle.getKey(),session);
		}
	}

	/**
	 * @param args
	 */
	private void launch(CommandLine args) {
		// Initializes the database.
		_log.info("Starting server");
		try {
			DBUtils.init();
		} catch (Exception e) {
			_log.fatal("Could not initialize DB", e);
			System.exit(-1);
		}

		// Creates the QTCP QuantumLink-over-TCP protocol listener.
		int qctpPort = DEFAULT_QTCP_PORT;
		if (args.getOptionValue("qtcpPort") != null) {
			qctpPort = Integer.parseInt(args.getOptionValue("qtcpPort"));
		}
		String qctpHost = DEFAULT_QTCP_HOST;
		if (args.getOptionValue("qtcpHost") != null) {
			qctpHost = args.getOptionValue("qtcpHost");
		}
		_log.info("QTCP protocol listening on " + qctpHost + ":" + qctpPort);
		new QTCPListener(this, qctpHost, qctpPort);

		// Creates the Habilink protocol listener.
		int habilinkPort = DEFAULT_HABILINK_PORT;
		if (args.getOptionValue("habilinkPort") != null) {
			habilinkPort = Integer.parseInt(args.getOptionValue("habilinkPort"));
		}
		String habilinkHost = DEFAULT_HABILINK_HOST;
		if (args.getOptionValue("habilinkHost") != null) {
			habilinkHost = args.getOptionValue("habilinkHost");
		}
		_log.info("Habilink protocol listening on " + habilinkHost + ":" + habilinkPort);
		new HabilinkListener(this, habilinkHost, habilinkPort);

		// at this point, we should load the extensions...
		// TODO make extensions flexible.
		new RoomAuditor(this);
	}

	private static CommandLine parseArgs(String[] args) {
		Options options = new Options();
		Option configFile = OptionBuilder.withArgName("configFile")
			.hasArg()
			.withDescription("Location of the QLink Reloaded configuration file")
			.create("configFile");
		Option port = OptionBuilder.withArgName("qtcpPort")
			.hasArg()
			.withDescription("Port to serve QLink Reloaded service on (default 5190)")
			.create("qtcpPort");
		Option host = OptionBuilder.withArgName("qtcpHost")
			.hasArg()
			.withDescription("Host to serve QLink Reloaded service on (default 0.0.0.0)")
			.create("qtcpHost");
		Option habilinkPort = OptionBuilder.withArgName("habilinkPort")
			.hasArg()
			.withDescription("Port to serve Habilink proxy on (default 1986)")
			.create("habilinkPort");
		Option habilinkHost = OptionBuilder.withArgName("habilinkHost")
			.hasArg()
			.withDescription("Host to serve Habilink proxy on (default 0.0.0.0)")
			.create("habilinkHost");
		options.addOption(configFile);
		options.addOption(port);
		options.addOption(host);
		options.addOption(habilinkPort);
		options.addOption(habilinkHost);
		// create the parser
		CommandLineParser parser = new PosixParser();
		try {
			// Return parsed command line arguments.
			return parser.parse(options,args);
		}
		catch( ParseException exp ) {
			// Print
			System.err.println("Parsing failed.  Reason: " + exp.getMessage() );
			HelpFormatter formatter = new HelpFormatter();
			formatter.printHelp("qlink", options);
			System.exit(1);
		}
		return null;
	}

	/**
	 * 
	 */
	public void reboot(String text) {
		_log.info("Rebooting the server");
		QSession session;
		if(text==null || text.length()==0) {
			SimpleDateFormat df=new SimpleDateFormat("HH:mm");
			text="The system has shut down.  It will be back up at " + df.format(new Date()) + " Central.";
		}
		synchronized(_htSessions) {
			Iterator i=_htSessions.values().iterator();
			while(i.hasNext()) {
				session=(QSession)i.next();
				session.send(new Toss(text));
			}
			_log.info("Exitting the server to launch again");
			System.exit(0);
		}
	}

	public static void main(String[] args) {
		// Parses command-line arguments.
		CommandLine parsedArgs = QLinkServer.parseArgs(args);
		// Parses configuration from provided file if specified.
		if (parsedArgs.getOptionValue("configFile") != null) {
			// Reads in configuration file.
			QConfig.readConfigurationFromFile(parsedArgs.getOptionValue("configFile"));
		} else {
			QConfig.readDefaultConfiguration();
		}
		// Initializes the QLink server.
		new QLinkServer().launch(parsedArgs);
	}
}
