/***************************************************************************
                          testoutboundtcp.h  -  description
                             -------------------
    begin                : Sat Dec 1 2001
    copyright            : (C) 2001 by Keith Henrickson
    email                : flipper@phin.com
 ***************************************************************************/

#ifndef TESTOUTBOUNDTCP_H
#define TESTOUTBOUNDTCP_H

#include <tcpconnection.h>

/**This class is to test if we can make outbound connections
  *@author Keith Henrickson
  */

class TestOutboundTCP : public TCPConnection  {
public: 
	TestOutboundTCP(TCPManager*pInManager, int nInFD = -1);
	~TestOutboundTCP();
private: // Private methods
  /** This is called when the data is ready. */
  void ReceiveData(unsigned char * pbRecBuffer, int nRecBufferLen);
};

#endif
