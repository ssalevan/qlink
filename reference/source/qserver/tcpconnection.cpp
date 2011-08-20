/***************************************************************************
                          tcpconnection.cpp  -  description
                             -------------------
    begin                : Tue Nov 27 2001
    copyright            : (C) 2001 by Keith Henrickson
    email                : flipper@phin.com
 ***************************************************************************/

#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netdb.h>
#include <string.h>
#include <unistd.h>

#include "dbllinklist.h"
#include "dbllinklistitem.h"
#include "tcpmanager.h"
#include "tcpconnection.h"

TCPConnection::TCPConnection(TCPManager* pInManager, int nInFD = -1){
	nFD = -1;
	pManager = pInManager;
	nLineBreak = 0;
	nReceiveBufferSize = 0;
	if (-1 != nInFD) {
		// If this socket already exists, create it as such
		nFD = nInFD;
		pManager->AddDataList(this);
	}
}

TCPConnection::~TCPConnection(){
}
/** Returns the file descriptor assigned to this socket */
int TCPConnection::GetFD(){
	return nFD;
}
/** No descriptions */
bool TCPConnection::Connect(char* pszHostName, unsigned short nPort){
	struct sockaddr_in sDestSock;
	struct hostent *hp;
	
	if (-1 != nFD) {
		printf("Socket is already open.\n");
		return false;
	}
	nFD = socket(AF_INET, SOCK_STREAM, 0);
	if (-1 == nFD) {
		printf("Error opening outgoing socket.\n");
		return false;
	}
	sDestSock.sin_family = AF_INET;
	hp = gethostbyname(pszHostName);
	if (0 == hp) {
		printf("Error getting host by name for %s\n", pszHostName);
		return false;
	}
	bcopy((void *)hp->h_addr, (void *)&sDestSock.sin_addr, hp->h_length);
	sDestSock.sin_port = htons(nPort);
	
	if (connect(nFD, (struct sockaddr *)&sDestSock, sizeof(sDestSock)) < 0) {
		printf("Cannot connect to %s\n", pszHostName);
		return false;
	}

	pManager->AddDataList(this);
	nReceiveBufferSize = 0;
	return true;
}

/** Disconnects an existing connection */
void TCPConnection::Disconnect(){
	if (-1 == nFD) {
		printf("Attempting to disconnect a non-open socket.\n");
		return;
	}
	close(nFD);
	pManager->DelDataList(this);
	printf("TCP connection has been closed.\n");
	nReceiveBufferSize = 0;
	delete this;
}
/** Transmits some data out the TCP connection. */
void TCPConnection::Transmit(unsigned char* pbOutBuffer, int nOutBufferLen){
	send(nFD, pbOutBuffer, nOutBufferLen, 0);
}

/** Indicates data is ready for reading from the TCP connection. */
void TCPConnection::Receive(){
	int nCharsRead;
	char *pbTemp;
	
	nCharsRead = recv(nFD, &bReceiveBuffer[nReceiveBufferSize], 4096 - nReceiveBufferSize, 0);
	if (-1 == nCharsRead) {
		printf("Error reading from TCP connection.\n");
		return;
	}
	if (0 == nCharsRead) {
		Disconnect();
		return;
	}
	
	if (0 == nLineBreak) {
		ReceiveData(bReceiveBuffer, nCharsRead);
	} else {
		nReceiveBufferSize += nCharsRead;
		pbTemp = (char *) memchr(bReceiveBuffer, nLineBreak, nReceiveBufferSize);
		while (NULL != pbTemp) {
			*pbTemp = 0;
			if ((0x0A == nLineBreak) && (0x0D == *(pbTemp - 1))){
				*(pbTemp - 1) = 0;
			}
			ReceiveData(bReceiveBuffer, pbTemp - (char *)&bReceiveBuffer[0]);
			nReceiveBufferSize -= ((pbTemp - (char *)&bReceiveBuffer[0]) + 1);
			memmove(bReceiveBuffer, pbTemp + 1, nReceiveBufferSize);
			pbTemp = (char *)memchr(bReceiveBuffer, nLineBreak, nReceiveBufferSize);
		}
	}
}
