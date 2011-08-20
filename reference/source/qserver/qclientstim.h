/***************************************************************************
                          qclientstim.h  -  description
                             -------------------
    begin                : Sat Oct 19 2002
    copyright            : (C) 2002 by Keith Henrickson
    email                : flipper@phin.com
 ***************************************************************************/

#ifndef QCLIENTSTIM_H
#define QCLIENTSTIM_H

#include <tcpconnection.h>

/**
  *@author Keith Henrickson
  */

class QClientStim : public TCPConnection  {
public: 
	QClientStim(TCPManager* pInManager, int nInFD);
	~QClientStim();
private: // Private methods
  /** This is called when the data is ready. */
  void ReceiveData(unsigned char * pbRecBuffer, int nRecBufferLen);
};

#endif
