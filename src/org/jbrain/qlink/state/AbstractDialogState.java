package org.jbrain.qlink.state;

import java.io.IOException;

import org.apache.log4j.Logger;
import org.jbrain.qlink.*;
import org.jbrain.qlink.cmd.action.*;
import org.jbrain.qlink.dialog.AbstractDialog;


public abstract class AbstractDialogState extends AbstractPhaseState {
	private static Logger _log=Logger.getLogger(AbstractDialogState.class);
	public static final int PHASE_ALLOCATE = 2;
	public static final int PHASE_RESPONSE = 3;

	/**
	 * 
	 * @uml.property name="_dialog"
	 * @uml.associationEnd multiplicity="(1 1)"
	 */
	protected AbstractDialog _dialog;

	/**
	 * 
	 * @uml.property name="_callback"
	 * @uml.associationEnd multiplicity="(1 1)"
	 */
	protected DialogCallBack _callback;

	public AbstractDialogState(QSession session, AbstractDialog d, DialogCallBack callback) {
		super(session,PHASE_ALLOCATE);
		_dialog=d;
		_callback=callback;
	}
	
	public void activate() throws IOException {
		//_log.info("PHASE: Initiating dialog:" + _dialog.getName());
    	//_session.send(new ClearScreen());
		// acknowledge dialog state.
		_session.send(_dialog.getPrepAction());
		if(_log.isInfoEnabled())
			_log.info("PHASE: Allocating dialog: " + _dialog.getName());
    	super.activate();
	}

	public boolean execute(Action a) throws IOException {
		QState state;
		boolean rc=false;

		// put global action handlers here...
		switch(getPhase()) {
			case PHASE_ALLOCATE:
				if(a instanceof ClearScreen) {
					// ignore this.
					rc=true;
				} else if(a instanceof DialogAllocated || 
					a instanceof ChatDialogAllocated) {
					// dialog has been allocated, send data
					_log.debug("Sending dialog data");
		        	_session.send(_dialog.getTextActions());
		        	_session.send(_dialog.getResponseAction());
					_log.info("PHASE: Waiting for dialog response");
					setPhase(PHASE_RESPONSE);
					rc=true;
				} 
				break;
			case PHASE_RESPONSE:
				_log.debug("Executing Dialog callback");
				rc=_callback.handleResponse(_dialog,a);
				break;
		}
		if(!rc)
			rc=super.execute(a);
		return rc;
	}
}
