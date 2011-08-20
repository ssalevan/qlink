/***************************************************************************
                          qroomgame.h  -  description
                             -------------------
    begin                : Sat Dec 15 2001
    copyright            : (C) 2001 by Keith Henrickson
    email                : flipper@phin.com
 ***************************************************************************/

#ifndef QROOMGAME_H
#define QROOMGAME_H


/**Tracks games that are played in a
standard people connection room.
  *@author Keith Henrickson
  */

enum PlayerState {
	psNULL,
	psINVITED,
	psACCEPTED,
	psSTARTING,
	psLOADING,
	psREADY,
	psPLAYING,
	psDECLINED,
};

class QRoomGame {
public: 
	QRoomGame(QUser* pThisUser, QRoom* pInRoom, unsigned char* pParam, int nParamLen);
	~QRoomGame();
	void AddUser(QUser* pThisUser, unsigned char* pParam, int nParamLen, bool fLastUser);
	bool GetPlayOrder(void) { return fRandomPlay; }
	QUser* GetInitiator(void) { return pInitiator; }
	int GetGameNumber(void) { return nGameNumber; }
	char* GetLongName(void) { return szLongName ; }
	int GetNumPlayers(void) { return nNumPlayers ; }
	QUser* GetPlayer(int nUserNum) { return pPlayers[nUserNum]; }
	void AckInvite(QUser* pThisUser, unsigned char* pParam, int nParamLen, bool fAccepted);
	void SendGameMove(QUser* pThisUser, unsigned char* pParam, int nParamLen);
	void SoftwareReady(QUser* pThisUser, unsigned char* pParam, int nParamLen);
	void EndGame(QUser* pThisUser, unsigned char* pParam, int nParamLen);

private:
	QRoom* pParentRoom;
	bool fRandomPlay;
	unsigned char nGameNumber;
	char szShortName[5];
	char szLongName[11];
	QUser* pInitiator;
	QUser* pPlayers[24];
	PlayerState ePlayerState[24];
	int nNumPlayers;
};

#endif
