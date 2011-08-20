/***************************************************************************
                          testinboundtcps.cpp  -  description
                             -------------------
    begin                : Sat Dec 1 2001
    copyright            : (C) 2001 by Keith Henrickson
    email                : flipper@phin.com
 ***************************************************************************/

#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <errno.h>
#include <string.h>
#include "testinboundtcp.h"
#include "testinboundtcps.h"

TestInboundTCPS::TestInboundTCPS(TCPManager* pInManager) : TCPListener(pInManager){
}
TestInboundTCPS::~TestInboundTCPS(){
}
/** No descriptions */
void TestInboundTCPS::Accept(){
	TestInboundTCP* pInboundC;
	struct sockaddr_in sOtherSocket;
	socklen_t nAddrLen = sizeof(sOtherSocket);
	int nTempFD;
	
	nTempFD = accept(nFD, (struct sockaddr *)&sOtherSocket, &nAddrLen);
	if (-1 == nTempFD) {
		printf("Error accepting connection.\n");
		printf("Errno = %s\n", strerror(errno));
		return;
	}
	
pInboundC = new TestInboundTCP(pManager, nTempFD);
}
