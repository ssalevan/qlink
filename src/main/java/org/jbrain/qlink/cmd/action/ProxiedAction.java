package org.jbrain.qlink.cmd.action;

import java.io.UnsupportedEncodingException;

import org.jbrain.qlink.cmd.CRCException;

/* ProxiedActions are payloads received from external sources. This
 * includes the two-byte action code but does not include the frame
 * boundary bytes nor the CRC and sequencing information. */
public class ProxiedAction extends AbstractAction {
    public ProxiedAction(byte[] payload, int start, int len) throws CRCException {
        super(getString(payload,start,2));
        /* Command code, CRC, sequence numbers, etc. are handled for
         * us by our parent classes (command code by AbstractAction,
         * the rest by AbstractCommand). We just need to reserve the 8
         * bytes here for their use. */
        data = new byte[len+8];
        System.arraycopy(payload, start, data, 8, len);
    }

    public byte[] getBytes() {
        finalizeCmd(data);
        return data;
    }

    private byte[] data;
}
