/***************************************************************************
                          testoutboundtcp.cpp  -  description
                             -------------------
    begin                : Sat Dec 1 2001
    copyright            : (C) 2001 by Keith Henrickson
    email                : flipper@phin.com
 ***************************************************************************/

#include <stdio.h>
#include "testoutboundtcp.h"

TestOutboundTCP::TestOutboundTCP(TCPManager *pInManager, int  nInFD= -1)  : TCPConnection(pInManager, nInFD){
	nLineBreak = 0x0A;	
}
TestOutboundTCP::~TestOutboundTCP(){
}
/** This is called when the data is ready. */
void TestOutboundTCP::ReceiveData(unsigned char * pbRecBuffer, int nRecBufferLen){
	printf("Received: %s\n", pbRecBuffer);
}
