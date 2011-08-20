#include <stdio.h>

/*Compute CRC for a packet.  The packet data including sequence numbers and
  the packet type must be present.  The framing characters and CRC bytes should
  not be present at all. */
unsigned short compute_CRC(unsigned char *pszPacketDataBuf, int nPacketLen){

  int nByteCounter;
  int nBitCounter;
  unsigned short nTempCRC;
  unsigned char nCRCHigh;
  unsigned char nCRCLow;

  nCRCHigh = 0;
  nCRCLow  = 0;

  for (nByteCounter = 0; nByteCounter < nPacketLen; nByteCounter++){
    /*Set a counter to 8 times*/
    nTempCRC = (nCRCHigh << 8);
    for (nBitCounter = 0; nBitCounter < 8; nBitCounter++) {
      /*Move low bit of new byte to C, high bit of new byte becomes 0
        Move C into low bit of A, Move high bit of A into C
		Mask off all of A except new bit */
		nTempCRC = ((nTempCRC & 0xFF00) | ((pszPacketDataBuf[nByteCounter] & (1 << nBitCounter)) >> nBitCounter));
		/*Xor CRClow into A*/
		nTempCRC = nTempCRC ^ nCRCLow;
		/*Move low bit of CRChigh into C, high bit of CRChigh becomes 0
		Move C into high bit of A, move low bit of A into C
		If C is not set, not ready to xor in CRC polynomial */
		if (nTempCRC & 1) {
			nTempCRC = nTempCRC >> 1;
//			nTempCRC = ((nTempCRC & 0x00FF) | (((nTempCRC >> 8) ^ 0xA0) << 8));
//
//			nTempCRC = nTempCRC ^ 0x01;
			nTempCRC ^= 0xA001;
			nCRCLow = nTempCRC & 0x00FF;
		} else {
			nTempCRC = nTempCRC >> 1;
			nCRCLow = nTempCRC & 0x00FF;
		}
    }
    nCRCHigh = nTempCRC >> 8;
  }
  return ((nCRCHigh << 8) | nCRCLow);
}

unsigned short compute_CRC2(unsigned char *pszPacketDataBuf, int nPacketLen){
	unsigned short nCalcCRC = 0;

	int nByteCounter;
	int nBitCounter;

	for (nByteCounter = 0; nByteCounter < nPacketLen; nByteCounter++){
	    for (nBitCounter = 0; nBitCounter < 8; nBitCounter++) {
			nCalcCRC ^= ((pszPacketDataBuf[nByteCounter] & (1 << nBitCounter)) >> nBitCounter);
			if (nCalcCRC & 0x0001) {
				nCalcCRC >>= 1;
				nCalcCRC ^= 0xA001;
			} else {
				nCalcCRC >>= 1;
			}
		}
	}
	return nCalcCRC;
}

void main (void) {
	unsigned short nCRC1;
	unsigned short nCRC2;

	nCRC1 = compute_CRC("123456789", 9);
	nCRC2 = compute_CRC2("123456789", 9);
	nCRC1 = nCRC1;
}