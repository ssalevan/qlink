/***************************************************************************
                          qclientlstn.cpp  -  description
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
#include "qclientconn.h"
#include "qclientlstn.h"

QClientLstn::QClientLstn(TCPManager* pInManager):TCPListener(pInManager){
}
QClientLstn::~QClientLstn(){
}
/** No descriptions */
void QClientLstn::Accept(){
	QClientConn* pInboundC;
	struct sockaddr_in sOtherSocket;
	socklen_t nAddrLen = sizeof(sOtherSocket);
	int nTempFD;
	
	nTempFD = accept(nFD, (struct sockaddr *)&sOtherSocket, &nAddrLen);
	if (-1 == nTempFD) {
		printf("Error accepting connection.\n");
		printf("Errno = %s\n", strerror(errno));
		return;
	}
	pInboundC = new QClientConn(pManager, nTempFD);
}
