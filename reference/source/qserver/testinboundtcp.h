/***************************************************************************
                          testinboundtcp.h  -  description
                             -------------------
    begin                : Sat Dec 1 2001
    copyright            : (C) 2001 by Keith Henrickson
    email                : flipper@phin.com
 ***************************************************************************/

#ifndef TESTINBOUNDTCP_H
#define TESTINBOUNDTCP_H

#include <tcpconnection.h>

/**
  *@author Keith Henrickson
  */

class TestInboundTCP : public TCPConnection  {
public: 
	TestInboundTCP(TCPManager* pInManager, int nInFD = -1);
	~TestInboundTCP();
private: // Private methods
  /** This is called when the data is ready. */
  void ReceiveData(unsigned char * pbRecBuffer, int nRecBufferLen);
};

#endif
