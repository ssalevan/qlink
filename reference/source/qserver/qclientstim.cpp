/***************************************************************************
                          qclientstim.cpp  -  description
                             -------------------
    begin                : Sat Oct 19 2002
    copyright            : (C) 2002 by Keith Henrickson
    email                : flipper@phin.com
 ***************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "quser.h"
#include "qroom.h"
#include "dbaccess.h"
#include "managers.h"
#include "qclientstim.h"

QClientStim::QClientStim(TCPManager* pInManager, int nInFD):TCPConnection(pInManager, nInFD){
	nLineBreak = 0x0A;
}
QClientStim::~QClientStim(){
}
/** This is called when the data is ready. */
void QClientStim::ReceiveData(unsigned char * pbRecBuffer, int nRecBufferLen){
	char szUserName[11];
	char szCommand[3];
	char szParameter[129];
	char szCookedParam[129];
	char szCookedWork[3];

	char* pszStartPtr;
	char* pszEndPtr;

	memset(szUserName, 0, 11);
	memset(szCommand, 0, 3);
	memset(szParameter, 0, 129);

	pszStartPtr = (char*)pbRecBuffer;

	pszEndPtr = strchr(pszStartPtr, '|');
	strncpy(szUserName, pszStartPtr, pszEndPtr - pszStartPtr);
	pszStartPtr = pszEndPtr + 1;
	pszEndPtr = strchr(pszStartPtr, '|');
	strncpy(szCommand, pszStartPtr, pszEndPtr - pszStartPtr);
	pszStartPtr = pszEndPtr + 1;
	pszEndPtr = (char*)pbRecBuffer + nRecBufferLen;
	strncpy(szParameter, pszStartPtr, pszEndPtr - pszStartPtr);

	memset(szCookedParam, 0, 129);
	szCookedWork[3] = 0;
	pszStartPtr = szParameter;
	pszEndPtr = szCookedParam;
	
	while (0 != *pszStartPtr) {
		if ('\\' != *pszStartPtr) {
			*pszEndPtr = *pszStartPtr;
			pszStartPtr++;
			pszEndPtr++;
		} else {
			pszStartPtr++;
			szCookedWork[0] = *pszStartPtr;
			pszStartPtr++;
			szCookedWork[1] = *pszStartPtr;
			*pszEndPtr = (char)strtol(szCookedWork, NULL, 16);
			pszStartPtr++;
			pszEndPtr++;
		}
	}

	printf("Got STIM for %s, command %s, param %s\n", szUserName, szCommand, szCookedParam);

	QUser* pTempUser = FindUserByScreenName(szUserName);
	if (NULL != pTempUser) {
		pTempUser->TransmitCommand(szCommand, szCookedParam, strlen(szCookedParam));
	}
}
