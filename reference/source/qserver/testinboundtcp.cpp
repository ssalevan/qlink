/***************************************************************************
                          testinboundtcp.cpp  -  description
                             -------------------
    begin                : Sat Dec 1 2001
    copyright            : (C) 2001 by Keith Henrickson
    email                : flipper@phin.com
 ***************************************************************************/

#include <stdio.h>
#include "testinboundtcp.h"

TestInboundTCP::TestInboundTCP(TCPManager* pInManager, int nInFD = -1) :TCPConnection(pInManager, nInFD){
}
TestInboundTCP::~TestInboundTCP(){
}
/** This is called when the data is ready. */
void TestInboundTCP::ReceiveData(unsigned char * pbRecBuffer, int nRecBufferLen){
	printf("Received: %s\n", pbRecBuffer);
}
