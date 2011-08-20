/***************************************************************************
                          qclientconn.cpp  -  description
                             -------------------
    begin                : Sat Dec 1 2001
    copyright            : (C) 2001 by Keith Henrickson
    email                : flipper@phin.com
 ***************************************************************************/

#include <stdio.h>
#include "quser.h"
#include "qclientconn.h"

QClientConn::QClientConn(TCPManager* pInManager, int nInFD):TCPConnection(pInManager, nInFD){
	printf("Creating new client handling object...\n");
	nLineBreak = 0x0D;
	fProtocolStarted = false;
	nCliSeq = 0x10;
	nSerSeq = 0x7F;
	nCliFreeSeq = 0x7F;
	pUser = NULL;
}
QClientConn::~QClientConn(){
	printf("Deleting QClientConn\n");
	if (NULL != pUser) {
		delete pUser;
	}
}

/*Compute CRC for a packet.  The packet data including sequence numbers and
  the packet type must be present.  The framing characters and CRC bytes should
  not be present at all. */
unsigned short QClientConn::compute_crc(unsigned char *pszPacketDataBuf, int nPacketLen){

  int nByteCounter;
  int nBitCounter;
  unsigned short nTempCRC;
  unsigned char nCRCHigh;
  unsigned char nCRCLow;

  nCRCHigh = 0;
  nCRCLow  = 0;

  for (nByteCounter = 0; nByteCounter < nPacketLen; nByteCounter++){
    /*Set a counter to 8 times*/
    nTempCRC = (nCRCLow << 8);
    for (nBitCounter = 0; nBitCounter < 8; nBitCounter++) {
      /*Move low bit of new byte to C, high bit of new byte becomes 0
        Move C into low bit of A, Move high bit of A into C
        Mask off all of A except new bit */
      nTempCRC = ((nTempCRC & 0xFF00) | ((pszPacketDataBuf[nByteCounter] & (1 << nBitCounter)) >> nBitCounter));
      /*Xor CRChigh into A*/
      nTempCRC = nTempCRC ^ nCRCHigh;
      /*Move low bit of CRClow into C, high bit of CRC low becomes 0
        Move C into high bit of A, move low bit of A into C
        If C is not set, not ready to xor in CRC polynomial */
      if (nTempCRC & 1) {
        nTempCRC = nTempCRC >> 1;
        /*Get CRClow
          Xor in polylow
          Store CRClow */
        nTempCRC = ((nTempCRC & 0x00FF) | (((nTempCRC >> 8) ^ 0xA0) << 8));
        /*Xor in polyhigh
          Store CRChigh */
        nTempCRC = nTempCRC ^ 0x01;
        nCRCHigh = nTempCRC & 0x00FF;
      } else {
        nTempCRC = nTempCRC >> 1;
        nCRCHigh = nTempCRC & 0x00FF;
      }
    }
    nCRCLow = nTempCRC >> 8;
  }
  return ((nCRCHigh << 8) | nCRCLow);
}

/** This is called when the data is ready. */
void QClientConn::ReceiveData(unsigned char * pbRecBuffer, int nRecBufferLen){
	unsigned short nRecCRC;
	unsigned short nCalcCRC;
	unsigned char  nRecCliSeq;
	unsigned char  nRecSerFreeSeq;
	unsigned char  nType;
	int nCounter;
	
	printf("Received a packet...\n");
#ifdef _DEBUG_DUMP
	printf("Received: ");
	for (nCounter = 0; nCounter < nRecBufferLen; nCounter++) {
		printf("%02X ", pbRecBuffer[nCounter]);
	}
	printf("\n");
#endif
	if (0x5A != pbRecBuffer[0]) {
		printf("Packet identifier was 0x%02X (expected 0x5A), ignoring.\n", pbRecBuffer[0]);
		return;
	}
	nRecCRC = ((((pbRecBuffer[3] & 0xF0) | (pbRecBuffer[4] & 0x0F)) << 8) |
		(((pbRecBuffer[1] & 0xF0) | (pbRecBuffer[2] & 0x0F))));
	nCalcCRC = compute_crc(&pbRecBuffer[5], nRecBufferLen-5);
	nRecCliSeq = pbRecBuffer[5];
	nRecSerFreeSeq = pbRecBuffer[6];
	nType = pbRecBuffer[7];

#ifdef _DEBUG_DUMP
	printf("Received CRC: 0x%04X\n", nRecCRC);
	printf("Calculated CRC: 0x%04X\n", nCalcCRC);
	printf("Received client sequence number: 0x%02X\n", nRecCliSeq);
	printf("Received server free OK number: 0x%02X\n", nRecSerFreeSeq);
	printf("Packet type: 0x%02X\n", nType);
#endif

	if (nCalcCRC != nRecCRC) {
		printf("Packet has CRC error.  Ignoring.\n");
		return;
	}
	
	switch (nType) {
		case 0x21:
			printf("Client packet retransmission queue full.\n");
			TransmitCommand((unsigned char *)"\x22", 1);
		break;
		case 0x22:
			printf("Server packet retransmission queue may be cleared.\n");
		break;
		case 0x23:
			if (fProtocolStarted) {
				printf("Client reports protocol error.\n");
			} else {
				nProtoMajor = pbRecBuffer[9];
				nProtoMinor = pbRecBuffer[8];
				printf("Protocol started, client is version %d.%d\n", nProtoMajor, nProtoMinor);
				pUser = new QUser(this);			
				TransmitCommand((unsigned char *)"\x24", 1);
			}
		break;
		case 0x24:
			printf("Command 0x24 is not valid on server side.\n");
		break;
		case 0x25:
			printf("Packet sequence error detected.\n");
		break;
		case 0x26:
			printf("Keepalive packet received.\n");
			TransmitCommand((unsigned char *)"\x24", 1);
		break;
		case 0x20:
			printf("Data packet received for layer 3.\n");
			if (nRecCliSeq != nCliSeq) {
				printf("Packet ordering error!\n");
				TransmitCommand((unsigned char *)"\x25", 1);
			}
			nCliFreeSeq=nCliSeq;
			nCliSeq++;
			if (0x80 == nCliSeq) {
				nCliSeq = 0x10;
			}
			pUser->ParseReceivedCommand(&pbRecBuffer[8], nRecBufferLen-8);
		break;
		default:
			printf("Unknown packet type 0x%02X received.\n", nType);
	}
}
/** No descriptions */
void QClientConn::TransmitCommand(unsigned char* pbOutCommand, int nOutCommandLen){
	unsigned char szTempBuf[1024];
	unsigned short nCRC;
	int nCounter;

	szTempBuf[0] = 0x5A;

	memcpy(&szTempBuf[7], pbOutCommand, nOutCommandLen);
	if (0x20 == szTempBuf[7]) {
		nSerSeq++;
		if (0x80 == nSerSeq) {
			nSerSeq = 0x10;
		}
	}
	szTempBuf[5] = nSerSeq;
	szTempBuf[6] = nCliFreeSeq;
	nCRC = compute_crc(&szTempBuf[5], nOutCommandLen+2);
	szTempBuf[1] = (nCRC & 0x00F0) | 0x01;
	szTempBuf[2] = (nCRC & 0x000F) | 0x40;
	szTempBuf[3] = ((nCRC >> 8)& 0x00F0) | 0x01;
	szTempBuf[4] = ((nCRC >> 8)& 0x000F) | 0x40;
	szTempBuf[nOutCommandLen + 7] = 0x0D;

#ifdef _DEBUG_DUMP
	printf("Sending: ");
	for (nCounter = 0; nCounter < nOutCommandLen + 8; nCounter++) {
		printf("%02X ", szTempBuf[nCounter]);
	}
	printf("\n");
#endif
	Transmit(szTempBuf, nOutCommandLen + 8);
}
