/***************************************************************************
                          quser.cpp  -  description
                             -------------------
    begin                : Sun Dec 2 2001
    copyright            : (C) 2001 by Keith Henrickson
    email                : flipper@phin.com
 ***************************************************************************/

#include <stdio.h>
#include <string.h>
#include "dbaccess.h"
#include "qporch.h"
#include "qclientconn.h"
#include "qroom.h"
#include "qroomgame.h"
#include "quser.h"
#include "managers.h"

QUser::QUser(QClientConn* pInCliCon){
	pCliCon = pInCliCon;
	nAllowFlags = afALLOW_PORCH; // Starting out, the user can only access the porch
	pPorch = NULL;
	pRoom = NULL;
	pGame = NULL;
	memset(szScreenName, 0, 11);
	memset(szUserID, 0, 11);
	memset(szMasterUID, 0, 11);
}
QUser::~QUser(){
		printf("Deleting the user handling object.\n");
		if (NULL != pPorch) {
			delete pPorch;
		}
		DelUserList(this);
}
/** No descriptions */
void QUser::ParseReceivedCommand(unsigned char *pbCommand, int nCommandLen){
	char szToken[3];
	unsigned char bParameter[128];
	int nParamLen;
	
	if (nCommandLen < 2) {
		printf("Command too short!  Ignoring.\n");
		return;
	}
	memcpy(szToken, pbCommand, 2);
	szToken[2] = 0;
	memcpy(bParameter, &pbCommand[2], nCommandLen - 2);
	nParamLen = nCommandLen - 2;

	printf("Token is '%s'\n", szToken);
	
	if (0 == strncmp(szToken, "SS", 2)) {
		printf("Service suspend request received.  Acknowledging and suspending.\n");
		TransmitCommand("SS", NULL, 0);
		CorkPackets();
	} else if (0 == strncmp(szToken, "SG", 2)) {
		printf("Service resume request received.  Uncorking and dispatching.\n");
		UncorkPackets();
	} else if (0 == strncmp(szToken, "DD", 2)) {
		if (nAllowFlags & afALLOW_PORCH) {
			printf("Received login request, creating porch.\n");
			pPorch = new QPorch;
			if (NULL != pPorch) {
				if (pPorch->UserAccessInfo(this, bParameter, nParamLen)) {
					strcpy(szScreenName, pPorch->GetScreenName());
					strcpy(szUserID, pPorch->GetUserID());
					if (NULL != pPorch->GetMasterUID()) {
						strcpy(szMasterUID, pPorch->GetMasterUID());
					} else {
						strcpy(szMasterUID, szUserID);
					}
					AddUserList(this);
					nAllowFlags = afALLOW_SYS;
				} 
			} else {
				printf("Couldn't build a porch!  Help!\n");
			}
		} else {
			printf("Received login request when not allowed.  HELP!\n");
		}
	} else if (0 == strncmp(szToken, "D6", 2)) {
		printf("Disk validated.\n");
		if (NULL != pPorch) {
			pPorch->DiskValidatedOK(this);
			delete pPorch;
			pPorch = NULL;
		} else {
			printf("But there is no porch, so who cares?\n");
		}
	} else if (0 == strncmp(szToken, "MR", 2)) {
		if (nAllowFlags & afALLOW_SYS) {
			if (NULL == pRoom) {
				pRoom = JoinFreeLobby(this);
			} else {
				pRoom->RefreshRoomInfo(this);
			}
		}
	} else if (0 == strncmp(szToken, "CM", 2)) {
		if (NULL != pRoom) {
			QRoom* pTempRoom;
			pTempRoom = JoinRoom(this, false, (char*)bParameter, nParamLen);
			if (NULL != pTempRoom) {
				pRoom->LeaveRoom(this);
				pRoom = pTempRoom;
			}
		}
	} else if (0 == strncmp(szToken, "CP", 2)) {
		if (NULL != pRoom) {
			QRoom* pTempRoom;
			pTempRoom = JoinRoom(this, true, (char*)bParameter, nParamLen);
			if (NULL != pTempRoom) {
				pRoom->LeaveRoom(this);
				pRoom = pTempRoom;
			}
		}
	} else if (0 == strncmp(szToken, "AA", 2)) {
		if (NULL != pRoom) {
			pRoom->SendText(this, (char*)bParameter, nParamLen);
		}
	} else if (0 == strncmp(szToken, "GI", 2)) {
		if (NULL != pRoom) {
			pGame = new QRoomGame(this, pRoom, bParameter, nParamLen);
		}
	} else if (0 == strncmp(szToken, "GU", 2)) {
		if (NULL != pGame) {
			pGame->AddUser(this, bParameter, nParamLen, false);
		}
	} else if (0 == strncmp(szToken, "GZ", 2)) {
		if (NULL != pGame) {
			pGame->AddUser(this, bParameter, nParamLen, true);
		}
	} else if (0 == strncmp(szToken, "GY", 2)) {
		if (NULL != pGame) {
			pGame->AckInvite(this, bParameter, nParamLen, true);
		}
	} else if (0 == strncmp(szToken, "GN", 2)) {
		if (NULL != pGame) {
			pGame->AckInvite(this, bParameter, nParamLen, false);
		}
	} else if (0 == strncmp(szToken, "GR", 2)) {
		if (NULL != pGame) {
			pGame->SoftwareReady(this, bParameter, nParamLen);
		}
	} else if (0 == strncmp(szToken, "GM", 2)) {
		if (NULL != pGame) {
			pGame->SendGameMove(this, bParameter, nParamLen);
		}
	} else if (0 == strncmp(szToken, "GE", 2)) {
		if (NULL != pGame) {
			pGame->EndGame(this, bParameter, nParamLen);
		}
	}
}
/** No descriptions */
void QUser::TransmitCommand(char *pszToken, char *pbParam, int nParamLen){

	unsigned char bTransmitBuf[128];
	
	bTransmitBuf[0] = 0x20;
	memcpy(&bTransmitBuf[1], pszToken, 2);
	memcpy(&bTransmitBuf[3], pbParam, nParamLen);
	pCliCon->TransmitCommand(bTransmitBuf, nParamLen+3);
}
/** No descriptions */
void QUser::CorkPackets(){
}
/** No descriptions */
void QUser::UncorkPackets(){
}
/** No descriptions */
char* QUser::GetScreenName(){
	return szScreenName;
}
/** No descriptions */
char* QUser::GetMasterUID(){
	return szMasterUID;
}
/** No descriptions */
char* QUser::GetUserID(){
	return szUserID;
}

void QUser::SendInvite(QRoomGame* pInGame){
	char szGameString[50];
	int   nPlyCtr;
	pGame = pInGame;
	
	if (pGame->GetPlayOrder()) {
		szGameString[0] = '1';
	} else {
		szGameString[0] = '0';
	}
	szGameString[1] = pRoom->GetSeat(pGame->GetInitiator());
	szGameString[2] = pGame->GetGameNumber();
	strcpy(&szGameString[3], pGame->GetLongName());
	szGameString[strlen(szGameString) + 1] = pGame->GetNumPlayers();
	for (nPlyCtr = 0; nPlyCtr < (pGame->GetNumPlayers()); nPlyCtr++) {
		szGameString[strlen(szGameString) + 2 + nPlyCtr] = pRoom->GetSeat(pGame->GetPlayer(nPlyCtr));
	}
	szGameString[strlen(szGameString)] = '\x90';
	TransmitCommand("GP", szGameString, 5 + strlen(pGame->GetLongName()) + pGame->GetNumPlayers());
}