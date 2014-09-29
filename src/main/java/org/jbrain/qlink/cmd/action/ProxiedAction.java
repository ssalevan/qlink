package org.jbrain.qlink.cmd.action;

import java.io.UnsupportedEncodingException;

import org.jbrain.qlink.cmd.ProxiedCommand;
import org.jbrain.qlink.cmd.CRCException;

public class ProxiedAction extends ProxiedCommand implements Action {
	private String _sAction;

	public static final byte CMD_ACTION=0x20;

	private static final String charSet="ISO-8859-1";

    /* ******* !!!!!!!!!! DOES NOT WORK !!!!!!!!!!!!!!!! *********** */
    /* The action code is supposed to be U\xfa but for some reason it is consistently thinking the action code is ]U, and then sends only that as its packet contents to the C64. That's very wrong! */
	public ProxiedAction(byte[] data, int start, int len) throws CRCException {
            super(extend(data, start, len), 0, len+8);
            _sAction=getString(data,start,2);
	}

    private static byte[] extend(byte[] data, int start, int len) {
        byte[] result = new byte[len+8];
        result[7] = CMD_ACTION;
        System.arraycopy(data, 0, result, 8, len);
        return result;
    }

	/**
	 * @param action
	 * @param str
	 * @return
	 */
	protected String getString(byte[] data, int i, int j) {
		try {
			return new String(data,i,j,charSet);
		} catch (UnsupportedEncodingException e) {
		}
		return new String(data,i,j);
	}
	
	protected byte[] getBytes(String str) {
		try {
			return str.getBytes(charSet);
		} catch (UnsupportedEncodingException e) {
		}
		return str.getBytes();
	}

	public String getAction() {
		return _sAction;
	}
	
	protected void finalizeCmd(byte[] data) {
		System.arraycopy(getBytes(_sAction),0,data,8,2);
		super.finalizeCmd(data);
	}
	
	public byte[] getBytes() {
		byte[] data=new byte[10];
		finalizeCmd(data);
		return data;
	}
	
	public String getName() {
		// cheesy, but it should work.
		return this.getClass().getConstructors()[0].getName() + "(" + _sAction + ")";
	}
	
}
