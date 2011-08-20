/*
	Copyright Jim Brain and Brain Innovations, 2005.

	This file is part of QLink.

	QLink is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	QLink is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with QLink; if not, write to the Free Software
	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

	@author Jim Brain
	Created on Jul 13, 2005
	
 */
package org.jbrain.qlink.util;

import java.util.zip.Checksum;


public class CRC16 implements Checksum {
	private int crc;
	private static int poly=0xa001; 

	public long getValue() {
		return crc;
	}

	public void reset() {
		crc=0;
	}

	public void update(int data) {
		boolean carry;
		//The checksum is interesting, and I invite folks to help with the algorithm or math equation: byte is assumed in .A, 

		//.C:bccf   8D FE BC   STA $BCFE	; work storage
		//.C:bcd2   98         TYA	; save off Y
		//.C:bcd3   48         PHA
		//.C:bcd4   A2 08      LDX #$08	; loop through 8 bits
		for(int k=0;k<8;k++) {
		//.C:bcd6   4E FE BC   LSR $BCFE	; shift byte right, grab low bit in carry
			crc=crc^(data&1);
			data=data>>1;
			
		//.C:bcd9   2A         ROL A	; put low back in .A
		//.C:bcda   29 01      AND #$01	; mask off bit
		//.C:bcdc   4D 00 BD   EOR $BD00	; eor with bd00 byte of checksum
			
		//.C:bcdf   4E FF BC   LSR $BCFF	; shift bcff checksum byte right
		//.C:bce2   6A         ROR A	; grab low bit of bd00 into .A
		//.C:bce3   90 0E      BCC $BCF3	; if high bit was 0 before, bypass high byte
			if((crc&1)!=0) {
				
		//.C:bce5   A8         TAY	; save A
		//.C:bce6   AD FF BC   LDA $BCFF	; load $bcff checksum byte
				crc=crc>>1;
				crc=crc^poly;
		//.C:bce9   4D FC BC   EOR $BCFC	; eor 
		//.C:bcec   8D FF BC   STA $BCFF	; put it back
			} else {
				crc=crc>>1;
			}
		//.C:bcef   98         TYA	; restore a
		//.C:bcf0   4D FD BC   EOR $BCFD	; eor
		//.C:bcf3   8D 00 BD   STA $BD00	; stuff in high byte
		//.C:bcf6   CA         DEX	; have we looped 8 times
		}
		//.C:bcf7   D0 DD      BNE $BCD6	; no
		//.C:bcf9   68         PLA	; restore .Y
		//.C:bcfa   A8         TAY
		//.C:bcfb   60         RTS	; return
		//.C:bcfc   A0 01      LDY #$01	; tmp storage bytes
		//.C:bcfe   00         BRK
		//.C:bcff   00         BRK
		//.C:bd00   00         BRK
		
	}

	public void update(byte[] data, int start, int len) {
		for(int i=0;i<len;i++) {
			update(data[i+start]);
		}
		
	}
}

