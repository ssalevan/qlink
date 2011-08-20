/***************************************************************************
                          qroom.cpp  -  description
                             -------------------
    begin                : Thu Dec 13 2001
    copyright            : (C) 2001 by Keith Henrickson
    email                : flipper@phin.com
 ***************************************************************************/

#include <stdio.h>
#include <string.h>
#include "dbaccess.h"
#include "quser.h"
#include "qroom.h"
#include "managers.h"

QRoom::QRoom(const char* pszNewRoomName, bool fInPrivateRoom){
	int nUsrCtr;

	printf("Creating new people connection room with name %s\n",pszNewRoomName);
	strncpy(szRoomName, pszNewRoomName, 10);
	szRoomName[10] = 0;
	for (nUsrCtr = 0; nUsrCtr < 24; nUsrCtr++) {
		pUserObj[nUsrCtr] = NULL;
		pRoomGames[nUsrCtr] = NULL;
	}
	nNumUsers = 0;
	nNumGames = 0;
	fPrivateRoom = fInPrivateRoom;
}

QRoom::~QRoom(){
}

char* QRoom::GetRoomName(void) {
	return szRoomName;
}

bool QRoom::JoinRoom(QUser* pNewUser, bool fSendName) {
	int nUsrCtr;
	char szOurSeatID[12];
	char szOtherSeatID[12];
	
	for (nUsrCtr = 0; nUsrCtr < 24; nUsrCtr++) {
		if (12 == nUsrCtr) {
			nUsrCtr++;
		}
		if (NULL == pUserObj[nUsrCtr]) {
			nNumUsers++;
			// Found a user slot
			pUserObj[nUsrCtr] = pNewUser;
			if (fSendName) {
				// Send the room name cause apparently the client won't know it
				pNewUser->TransmitCommand("CM", szRoomName, strlen(szRoomName));
			}
			szOurSeatID[0] = nUsrCtr + 1;
			strcpy(&szOurSeatID[1], pNewUser->GetScreenName());
			int nUsrCtr2; // This iterates through the users to send each ones name to the client
			for (nUsrCtr2 = 0; nUsrCtr2 < 24; nUsrCtr2++) {
				if ((NULL != pUserObj[nUsrCtr2]) && (nUsrCtr != nUsrCtr2)) {
					// Let the other user know this user has arrived in the room
					pUserObj[nUsrCtr2]->TransmitCommand("CA", szOurSeatID, strlen(&szOurSeatID[1]) + 1);
					szOtherSeatID[0] = nUsrCtr2 + 1;
					strcpy(&szOtherSeatID[1], pUserObj[nUsrCtr2]->GetScreenName());
					// And let this user know the other user is already there
					pNewUser->TransmitCommand("CL", szOtherSeatID, strlen(&szOtherSeatID[1]) + 1);
				}
			}
			// And let this user know they have arrived and activate the menus
			pNewUser->TransmitCommand("CE", szOurSeatID, strlen(&szOurSeatID[1]) + 1);
			return true;
		}
	}
	return false;
}

bool QRoom::RefreshRoomInfo(QUser* pThisUser) {
	int nUsrCtr;
	char szOurSeatID[12];
	char szOtherSeatID[12];
	
	for (nUsrCtr = 0; nUsrCtr < 24; nUsrCtr++) {
		if (12 == nUsrCtr) {
			nUsrCtr++;
		}
		if (pThisUser == pUserObj[nUsrCtr]) {
			// Send the room name
			pThisUser->TransmitCommand("CM", szRoomName, strlen(szRoomName));
			szOurSeatID[0] = nUsrCtr + 1;
			strcpy(&szOurSeatID[1], pThisUser->GetScreenName());
			int nUsrCtr2; // This iterates through the users to send each ones name to the client
			for (nUsrCtr2 = 0; nUsrCtr2 < 24; nUsrCtr2++) {
				if ((NULL != pUserObj[nUsrCtr2]) && (nUsrCtr != nUsrCtr2)) {
					// Let the other user know this user has arrived in the room
					szOtherSeatID[0] = nUsrCtr2 + 1;
					strcpy(&szOtherSeatID[1], pUserObj[nUsrCtr2]->GetScreenName());
					// And let this user know the other user is already there
					pThisUser->TransmitCommand("CL", szOtherSeatID, strlen(&szOtherSeatID[1]) + 1);
				}
			}
			// And let this user know they have arrived and activate the menus
			pThisUser->TransmitCommand("CE", szOurSeatID, strlen(&szOurSeatID[1]) + 1);
			return true;
		}
	}
	return false;
}

bool QRoom::AddGame(QRoomGame* pNewGame) {
	int nGameCtr;
	
	for (nGameCtr = 0; nGameCtr < 24; nGameCtr++) {
		if (12 == nGameCtr) {
			nGameCtr++;
		}
		if (NULL == pRoomGames[nGameCtr]) {
			nNumGames++;
			// Found a game slot
			pRoomGames[nGameCtr] = pNewGame;
			return true;
		}
	}
	return false;
}

void QRoom::SendText(QUser* pActUser, char* pszText, int nLen) {
	int nUsrCtr;
	char szTempString[128];
	
	for (nUsrCtr = 0; nUsrCtr < 24; nUsrCtr++) {
		if (12 == nUsrCtr) {
			nUsrCtr++;
		}
		if (pActUser == pUserObj[nUsrCtr]) {
			// Found the user's seat number
			memset(szTempString, 0, 128);
			szTempString[0] = nUsrCtr + 1;
			strncpy(&szTempString[1], pszText, nLen);
			int nUsrCtr2; // This iterates through the users to send each one the text
			for (nUsrCtr2 = 0; nUsrCtr2 < 24; nUsrCtr2++) {
				if (NULL != pUserObj[nUsrCtr2]) {
					// Send the text out to each user
					pUserObj[nUsrCtr2]->TransmitCommand("AA", szTempString, 1 + nLen);
				}
			}
		}
	}
}

void QRoom::LeaveRoom(QUser* pActUser) {
	int nUsrCtr;
	char szTempString[128];
	
	for (nUsrCtr = 0; nUsrCtr < 24; nUsrCtr++) {
		if (12 == nUsrCtr) {
			nUsrCtr++;
		}
		if (pActUser == pUserObj[nUsrCtr]) {
			// Found the user's seat number
			nNumUsers--;
			memset(szTempString, 0, 128);
			szTempString[0] = nUsrCtr + 1;
			int nUsrCtr2; // This iterates through the users to send each one the disconnecting message
			for (nUsrCtr2 = 0; nUsrCtr2 < 24; nUsrCtr2++) {
				if ((NULL != pUserObj[nUsrCtr2]) && (nUsrCtr != nUsrCtr2)) {
					// Send the text out to each user
					pUserObj[nUsrCtr2]->TransmitCommand("CB", szTempString, 1);
				}
			}
			pUserObj[nUsrCtr] = NULL;
			if (0 == nNumUsers) {
				printf("Room %s is empty.\n", szRoomName);
				DelRoomList(this);
				delete this;
			}
		}
	}
}

void QRoom::RemoveGame(QRoomGame* pOldGame) {
	int nGameCtr;
	
	for (nGameCtr = 0; nGameCtr < 24; nGameCtr++) {
		if (12 == nGameCtr) {
			nGameCtr++;
		}
		if (pOldGame == pRoomGames[nGameCtr]) {
			nNumGames--;
			pRoomGames[nGameCtr] = NULL;
		}
	}
}

int QRoom::GetSeat(QUser* pActUser) {
	int nUsrCtr;
	
	for (nUsrCtr = 0; nUsrCtr < 24; nUsrCtr++) {
		if (12 == nUsrCtr) {
			nUsrCtr++;
		}
		if (pActUser == pUserObj[nUsrCtr]) {
			return nUsrCtr + 1;
		}
	}
	return 0;
}
