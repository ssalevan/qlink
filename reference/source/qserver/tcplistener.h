/***************************************************************************
                          tcplistener.h  -  description
                             -------------------
    begin                : Tue Nov 27 2001
    copyright            : (C) 2001 by Keith Henrickson
    email                : flipper@phin.com
 ***************************************************************************/

#ifndef TCPLISTENER_H
#define TCPLISTENER_H


/**
  *@author Keith Henrickson
  */
class TCPManager;
class TCPListener {
public: 
	TCPListener(TCPManager* pInManager);
	virtual ~TCPListener();
  /** Returns the file descriptor assigned to this socket. */
  int GetFD();
  /** No descriptions */
  bool Listen(unsigned short nPort);
  /** No descriptions */
  virtual void Accept() = 0;
private: // Private attributes
protected:
  /** Keep track of the file descriptor assigned to this socket */
  int nFD;
  /**  */
  TCPManager* pManager;
private: // Private methods
};

#endif
