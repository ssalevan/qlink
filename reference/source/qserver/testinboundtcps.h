/***************************************************************************
                          testinboundtcps.h  -  description
                             -------------------
    begin                : Sat Dec 1 2001
    copyright            : (C) 2001 by Keith Henrickson
    email                : flipper@phin.com
 ***************************************************************************/

#ifndef TESTINBOUNDTCPS_H
#define TESTINBOUNDTCPS_H

#include <tcplistener.h>

/**
  *@author Keith Henrickson
  */

class TestInboundTCPS : public TCPListener  {
public: 
	TestInboundTCPS(TCPManager* pInManager);
	~TestInboundTCPS();
private: // Private methods
  /** No descriptions */
  virtual void Accept();
};

#endif
