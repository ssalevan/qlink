/***************************************************************************
                          qclientstimlstn.h  -  description
                             -------------------
    begin                : Sat Oct 19 2002
    copyright            : (C) 2002 by Keith Henrickson
    email                : flipper@phin.com
 ***************************************************************************/

#ifndef QCLIENTSTIMLSTN_H
#define QCLIENTSTIMLSTN_H

#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <errno.h>
#include <string.h>
#include <tcplistener.h>

/**
  *@author Keith Henrickson
  */

class QClientStimLstn : public TCPListener  {
public: 
	QClientStimLstn(TCPManager* pInManager);
	~QClientStimLstn();
private: // Private methods
  /** No descriptions */
  void Accept();
};

#endif
