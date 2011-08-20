/***************************************************************************
                          tcplistener.cpp  -  description
                             -------------------
    begin                : Tue Nov 27 2001
    copyright            : (C) 2001 by Keith Henrickson
    email                : flipper@phin.com
 ***************************************************************************/

#include <stdio.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <string.h>
#include "dbllinklist.h"
#include "dbllinklistitem.h"
#include "tcpmanager.h"
#include "tcplistener.h"

TCPListener::TCPListener(TCPManager* pInManager){
	pManager = pInManager;
}
TCPListener::~TCPListener(){
}
/** Returns the file descriptor assigned to this socket. */
int TCPListener::GetFD(){
	return nFD;
}
/** No descriptions */
bool TCPListener::Listen(unsigned short nPort){
	int nStatus;
	int nTempFD;
	int nOn = 1;
	struct sockaddr_in sServerSock;
	struct linger linger = {0};
	
	nTempFD = socket(AF_INET, SOCK_STREAM, 0);
	if (nTempFD < 0) {
		printf("Error creating listener socket.\n");
		return false;
	}
	
	nStatus = setsockopt(nTempFD, SOL_SOCKET, SO_REUSEADDR, (const char *)&nOn, sizeof(nOn));
	if (-1 == nStatus) {
		printf("Could not set SO_REUSEADDR.\n");
		return false;
	}
	
	linger.l_onoff = 1;
	linger.l_linger = 30;
	nStatus = setsockopt(nTempFD, SOL_SOCKET, SO_LINGER, (const char *)&linger, sizeof(linger));
	if (-1 == nStatus) {
		printf("Could not set SO_LINGER.\n");
		return false;
	}
	
	sServerSock.sin_family = AF_INET;
	sServerSock.sin_addr.	s_addr = INADDR_ANY;
	sServerSock.sin_port = htons(nPort);
	
	nStatus = bind(nTempFD, (struct sockaddr *)&sServerSock, sizeof(sServerSock));
	if (-1 == nStatus) {
		printf("Could not bind server socket to port.\n");
		return false;
	}
	
	nStatus = listen(nTempFD, 5);
	if (-1 == nStatus) {
		printf("Cannot listen to server socket.\n");
		return false;
	}
	
	nFD = nTempFD;
	pManager->AddLstnList(this);
	return true;
}
