/***************************************************************************
                          tcpconnection.h  -  description
                             -------------------
    begin                : Tue Nov 27 2001
    copyright            : (C) 2001 by Keith Henrickson
    email                : flipper@phin.com
 ***************************************************************************/

#ifndef TCPCONNECTION_H
#define TCPCONNECTION_H


/**
  *@author Keith Henrickson
  */
class TCPManager;

class TCPConnection {
public: 
	TCPConnection(TCPManager* pInManager, int nInFD = -1);
	virtual ~TCPConnection();
  /** Returns the file descriptor assigned to this socket */
  int GetFD();
  /** Creates a new connection */
  bool Connect(char* szHostName, unsigned short nPort);
  /** Transmits some data out the TCP connection. */
  void Transmit(unsigned char* pbOutBuffer, int nOutBufferLen);
  /** Closes an existing connection */
  void Disconnect();
  /** Indicates data is ready for reading from the TCP connection. */
  void Receive();
private: // Private attributes
  /**  */
  int nFD;
  /**  */
  TCPManager* pManager;
  /**  */
 unsigned char bReceiveBuffer[4096];
  /**  */
  int nReceiveBufferSize;
public: // Public attributes
  /**  */
  unsigned char nLineBreak;
private: // Private methods
  /** This is called when the data is ready.  It must be overridden */
  virtual void ReceiveData(unsigned char* pbRecBuffer, int nRecBufferLen) = 0;
};

#endif
