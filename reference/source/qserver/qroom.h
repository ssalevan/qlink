/***************************************************************************
                          qroom.h  -  description
                             -------------------
    begin                : Thu Dec 13 2001
    copyright            : (C) 2001 by Keith Henrickson
    email                : flipper@phin.com
 ***************************************************************************/

#ifndef QROOM_H
#define QROOM_H


/**Implements a people connection room
  *@author Keith Henrickson
  */

class QRoomGame;

class QRoom {
public: 
	QRoom(const char* pszNewRoomName, bool fInPrivateRoom);
	~QRoom();
	
	char* GetRoomName(void);
	bool JoinRoom(QUser* pNewUser, bool fSendName);
	void SendText(QUser* pActUser, char* pszText, int nLen);
	void LeaveRoom(QUser* pActUser);
	bool IsPrivate(void) {return fPrivateRoom;};
	void MakePublic(void) {fPrivateRoom = false;};
	bool AddGame(QRoomGame* pNewGame);
	void RemoveGame(QRoomGame* pOldGame);
	int GetSeat(QUser* pActUser);
	bool RefreshRoomInfo(QUser* pThisUser);
	
private:
	char szRoomName[10];
	QUser* pUserObj[24];
	int nNumUsers;
	int nNumGames;
	bool fPrivateRoom;
	QRoomGame* pRoomGames[24];
};

#endif
