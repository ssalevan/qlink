/***************************************************************************
                          qclientstimlstn.cpp  -  description
                             -------------------
    begin                : Sat Oct 19 2002
    copyright            : (C) 2002 by Keith Henrickson
    email                : flipper@phin.com
 ***************************************************************************/

#include "qclientstimlstn.h"
#include "qclientstim.h"

QClientStimLstn::QClientStimLstn(TCPManager* pInManager):TCPListener(pInManager){
}
QClientStimLstn::~QClientStimLstn(){
}
/** No descriptions */
void QClientStimLstn::Accept(){
	QClientStim* pInboundC;
	struct sockaddr_in sOtherSocket;
	socklen_t nAddrLen = sizeof(sOtherSocket);
	int nTempFD;

	nTempFD = accept(nFD, (struct sockaddr *)&sOtherSocket, &nAddrLen);
	if (-1 == nTempFD) {
		printf("Error accepting connection.\n");
		printf("Errno = %s\n", strerror(errno));
		return;
	}
	pInboundC = new QClientStim(pManager, nTempFD);
}
