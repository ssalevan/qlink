/***************************************************************************
                          qclientlstn.h  -  description
                             -------------------
    begin                : Sat Dec 1 2001
    copyright            : (C) 2001 by Keith Henrickson
    email                : flipper@phin.com
 ***************************************************************************/

#ifndef QCLIENTLSTN_H
#define QCLIENTLSTN_H

#include <tcplistener.h>

/**This class listens for new qlink client connections
  *@author Keith Henrickson
  */

class QClientLstn : public TCPListener  {
public: 
	QClientLstn(TCPManager* pInManager);
	~QClientLstn();
private: // Private methods
  /** No descriptions */
  void Accept();
};

#endif
