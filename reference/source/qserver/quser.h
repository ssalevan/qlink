/***************************************************************************
                          quser.h  -  description
                             -------------------
    begin                : Sun Dec 2 2001
    copyright            : (C) 2001 by Keith Henrickson
    email                : flipper@phin.com
 ***************************************************************************/

#ifndef QUSER_H
#define QUSER_H


/**This handles all interaction with a user, allowing other portions
of the program to send the user messages as well as interpreting
all commands send by the user to the server.

  *@author Keith Henrickson
  */

const unsigned int afALLOW_PORCH = 0x00000001; // Allow access to the porch
const unsigned int afALLOW_SYS       = 0x00000002; // Allow access to the main system

class QClientConn;
class QPorch;
class QRoom;
class QRoomGame;
class QUser {
public: 
	QUser(QClientConn* pInCliCon);
	~QUser();
  /** No descriptions */
  void ParseReceivedCommand(unsigned char *pbCommand, int nCommandLen);
  /** No descriptions */
  void TransmitCommand(char *pszToken, char *pbParam, int nParamLen);
  /** No descriptions */
  char* GetScreenName();
  /** No descriptions */
  char* GetMasterUID();
  /** No descriptions */
  char* GetUserID();
  void SendInvite(QRoomGame* pInGame);
  void DetatchGame(void) { pGame = NULL; }
private: // Private attributes
  /** Holds a pointer to the actual TCP connection object. */
  QClientConn* pCliCon;
  /**  Holds flags indicating what a user is allowed to do at this point*/
  unsigned int nAllowFlags;
  /**  */
  QPorch* pPorch;
  QRoom* pRoom;
  QRoomGame* pGame;
  /**  */
  char szScreenName[11];;
  /**  */
  char szUserID[11];
  /**  */
  char szMasterUID[11];
private: // Private methods
  /** No descriptions */
  void UncorkPackets();
private: // Private methods
  /** No descriptions */
  void CorkPackets();
};

#endif
