/***************************************************************************
                          tcpmanager.h  -  description
                             -------------------
    begin                : Thu Nov 29 2001
    copyright            : (C) 2001 by Keith Henrickson
    email                : flipper@phin.com
 ***************************************************************************/

#ifndef TCPMANAGER_H
#define TCPMANAGER_H
#include "tcpconnection.h"
#include "tcplistener.h"

/**
  *@author Keith Henrickson
  */

class TCPConnection;
class TCPListener;

class TCPManager {
public: 
	TCPManager();
	~TCPManager();
  /** This function will process any incoming connections as well as any incoming or outgoing data. */
  void Manage();
  /** No descriptions */
  void DelDataList(TCPConnection*);
  /** No descriptions */
  void AddDataList(TCPConnection*);
  /** No descriptions */
  void DelLstnList(TCPListener*);
  /** No descriptions */
  void AddLstnList(TCPListener*);
private: // Private attributes
  /**  List of sockets sending and receiving data*/
  DblLinkList<TCPConnection*> lDataSocketList;
  /**  List of sockets waiting for connections*/
  DblLinkList<TCPListener*> lLstnSocketList;
};

#endif
