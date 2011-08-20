/***************************************************************************
                          main.cpp  -  description
                             -------------------
    begin                : Tue Nov 27 23:39:08 SST 2001
    copyright            : (C) 2001 by Keith Henrickson
    email                : flipper@phin.com
 ***************************************************************************/

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "dbaccess.h"
#include "quser.h"
#include "managers.h"
#include "dbllinklist.h"
#include "dbllinklistitem.h"
#include "tcpconnection.h"
#include "tcplistener.h"
#include "tcpmanager.h"
#include "qclientlstn.h"
#include "qclientstimlstn.h"

int main(int argc, char *argv[])
{
	srand(time(NULL));
	pDBManager = new DBAccess;
	pDBManager->Connect("localhost", "qlink", "creideiki");
	
	TCPManager* pTCPManager = new TCPManager;
	QClientLstn* pInBound = new QClientLstn(pTCPManager);
	pInBound->Listen(8888);
	QClientStimLstn* pStimInBound = new QClientStimLstn(pTCPManager);
	pStimInBound->Listen(8889);
	
	while(1) {
		pTCPManager->Manage();
	}
}
