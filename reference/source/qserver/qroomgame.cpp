/***************************************************************************
                          qroomgame.cpp  -  description
                             -------------------
    begin                : Sat Dec 15 2001
    copyright            : (C) 2001 by Keith Henrickson
    email                : flipper@phin.com
 ***************************************************************************/

#include <stdio.h>
#include <string.h>
#include "quser.h"
#include "qroom.h"
#include "qroomgame.h"
#include "dbaccess.h"
#include "managers.h"

QRoomGame::QRoomGame(QUser* pThisUser, QRoom* pInRoom, unsigned char* pParam, int nParamLen){
	char* pcStrTrm;
	
	printf("Initiating game.\n");
	pParentRoom = pInRoom;
	pInRoom->AddGame(this);
	pInitiator = pThisUser;
	nNumPlayers = 0;
	if (pParam[0] == '0') {
		fRandomPlay = false;
		printf("Game play is fixed order.\n");
	} else {
		fRandomPlay = true;
		printf("Game play is random order.\n");
	}
	nGameNumber = pParam[1];
	printf("Playing gane #: %d\n", nGameNumber);
	pcStrTrm = (char*)memchr((void*)pParam, '\x90',  nParamLen);
	if (NULL != pcStrTrm) {
		*pcStrTrm = '\0';
		strncpy(szLongName, (char*)&pParam[2], 10);
		szLongName[10] = 0;
		printf("Name: %s\n", szLongName);
		strncpy(szShortName, pcStrTrm + 1, 4);
		szShortName[4] = 0;
		printf("Code: %s\n", szShortName);
	}
}
QRoomGame::~QRoomGame(){
}
void QRoomGame::AddUser(QUser* pThisUser, unsigned char* pParam, int nParamLen, bool fLastUser){
	char szUserName[11];
	int nPlrCtr;
	
	memset(szUserName, 0, 11);
	strncpy(szUserName, (char*)&pParam[1], nParamLen-1);
	if (fLastUser) {
		printf("Adding %s to the game and sending invites.\n", szUserName);
		pPlayers[nNumPlayers] = FindUserByScreenName(szUserName);
		nNumPlayers++;
		ePlayerState[nNumPlayers] = psINVITED;
		for (nPlrCtr = 0; nPlrCtr < nNumPlayers; nPlrCtr++) {
			if (pPlayers[nPlrCtr] != pInitiator) {
				pPlayers[nPlrCtr]->SendInvite(this);
			} else {
				int nTmpCtr;
				char szAckString[50];
				
				szAckString[0] = nNumPlayers;
				for (nTmpCtr = 0; nTmpCtr < nNumPlayers; nTmpCtr++) {
					szAckString[nTmpCtr+1] = pParentRoom->GetSeat(pPlayers[nTmpCtr]);
				}
				pPlayers[nPlrCtr]->TransmitCommand("GO", szAckString, nNumPlayers+1);
				ePlayerState[nPlrCtr] = psSTARTING;
			}
		}
	} else {
		printf("Adding %s to the game.\n", szUserName);
		pPlayers[nNumPlayers] = FindUserByScreenName(szUserName);
		ePlayerState[nNumPlayers] = psINVITED;
		nNumPlayers++;
	}
}

void QRoomGame::AckInvite(QUser* pThisUser, unsigned char* pParam, int nParamLen, bool fAccepted){
	bool fReady = true;
	int nPlrCtr;
	char szDeclineBuf[2];
	
	if (fAccepted) {
		for (nPlrCtr = 0; nPlrCtr < nNumPlayers; nPlrCtr++) {
			if (pPlayers[nPlrCtr] == pThisUser) {
				ePlayerState[nPlrCtr] = psACCEPTED;
			} else if ((ePlayerState[nPlrCtr] != psACCEPTED) && (ePlayerState[nPlrCtr] != psSTARTING)) {
				fReady = false;
			}
		}
		if (fReady) {
			for (nPlrCtr = 0; nPlrCtr < nNumPlayers; nPlrCtr++) {
				ePlayerState[nPlrCtr] = psLOADING;
				pPlayers[nPlrCtr]->TransmitCommand("GL", NULL, 0);
			}
		}
	} else {
		for (nPlrCtr = 0; nPlrCtr < nNumPlayers; nPlrCtr++) {
			if (pPlayers[nPlrCtr] == pThisUser) {
				ePlayerState[nPlrCtr] = psDECLINED;
				szDeclineBuf[0] = pParentRoom->GetSeat(pThisUser);
				szDeclineBuf[1] = 0;
				pInitiator->TransmitCommand("G5", szDeclineBuf, 1);
			} else if ((ePlayerState[nPlrCtr] != psDECLINED) && (ePlayerState[nPlrCtr] != psSTARTING)) {
				fReady = false;
			}
		}
		if (fReady) {
			for (nPlrCtr = 0; nPlrCtr < nNumPlayers; nPlrCtr++) {
				if (pThisUser != pPlayers[nPlrCtr]) {
					pPlayers[nPlrCtr]->DetatchGame();
				}
			}
			pParentRoom->RemoveGame(this);
		}
	}
}

void QRoomGame::SoftwareReady(QUser* pThisUser, unsigned char* pParam, int nParamLen){
	bool fReady = true;
	int nPlrCtr;
	char szTempStr[50];
		
	for (nPlrCtr = 0; nPlrCtr < nNumPlayers; nPlrCtr++) {
		if (pPlayers[nPlrCtr] == pThisUser) {
			ePlayerState[nPlrCtr] = psREADY;
		} else if (ePlayerState[nPlrCtr] != psREADY) {
			fReady = false;
		}
	}
	if (fReady) {
		strcpy(szTempStr, "GAME\x90");
		szTempStr[5] = nNumPlayers;
		for (nPlrCtr = 0; nPlrCtr < nNumPlayers; nPlrCtr++) {
			szTempStr[6 + nPlrCtr] = pParentRoom->GetSeat(pPlayers[nPlrCtr]);
		}
		for (nPlrCtr = 0; nPlrCtr < nNumPlayers; nPlrCtr++) {
			ePlayerState[nPlrCtr] = psPLAYING;			
			pPlayers[nPlrCtr]->TransmitCommand("GB", szTempStr, 6 + nNumPlayers);
		}
	}
}

void QRoomGame::SendGameMove(QUser* pThisUser, unsigned char* pParam, int nParamLen){
	
	int nPlrCtr;
	int nThisSeat = pParentRoom->GetSeat(pThisUser);
	char szMoveText[128];
	
	szMoveText[0] = nThisSeat;
	memcpy(&szMoveText[1], pParam, nParamLen);
	
	for (nPlrCtr = 0; nPlrCtr < nNumPlayers; nPlrCtr++) {
		if (pThisUser != pPlayers[nPlrCtr]) {
			pPlayers[nPlrCtr]->TransmitCommand("GM", szMoveText, 1 + nParamLen);
		}
	}	
}

void QRoomGame::EndGame(QUser* pThisUser, unsigned char* pParam, int nParamLen){
	
	int nPlrCtr;
	int nThisSeat = pParentRoom->GetSeat(pThisUser);
	char szEndText[128];
	
	szEndText[0] = nThisSeat;
	for (nPlrCtr = 0; nPlrCtr < nNumPlayers; nPlrCtr++) {
		if (pThisUser != pPlayers[nPlrCtr]) {
			pPlayers[nPlrCtr]->DetatchGame();
			pPlayers[nPlrCtr]->TransmitCommand("GE", szEndText,  1);
		}
	}
	pParentRoom->RemoveGame(this);
	delete this;	
}