/***************************************************************************
                          qporch.cpp  -  description
                             -------------------
    begin                : Sat Dec 8 2001
    copyright            : (C) 2001 by Keith Henrickson
    email                : flipper@phin.com
 ***************************************************************************/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "assists.h"
#include "dbaccess.h"
#include "quser.h"
#include "managers.h"
#include "qporch.h"

QPorch::QPorch(){
	uddInfo.pszUserID = NULL;
	uddInfo.pszScreenName = NULL;
	uddInfo.pszPin = NULL;
	uddInfo.pszMasterUID = NULL;
}
QPorch::~QPorch(){
	printf("Porch is being deleted.\n");
	if (NULL != uddInfo.pszUserID) {
		free(uddInfo.pszUserID);
	}
	if (NULL != uddInfo.pszScreenName) {
		free(uddInfo.pszScreenName);
	}
	if (NULL != uddInfo.pszPin) {
		free(uddInfo.pszPin);
	}
	if (NULL != uddInfo.pszMasterUID) {
		free(uddInfo.pszMasterUID);
	}
}
/** No descriptions */
bool QPorch::UserAccessInfo(QUser* pParent, unsigned char *bParameter, int nParamLen){
	char szWriteBackUID[11];
	char szUserID[11];
	char szPin[5];
	
	memcpy(szUserID, bParameter, 10);
	szUserID[10] = 0;
	memcpy(szPin, &bParameter[10], 4);
	szPin[4] = 0;
	
	uddInfo.pszUserID = strndup(szUserID, 10);
	if (!pDBManager->FindUser(skUSER_ID, uddInfo)) {
		printf("UserID not found in database.\n");
		pParent->TransmitCommand("DK", NULL, 0);
		return false;
	}
	printf("Located user '%s' with UID '%s'\n", uddInfo.pszScreenName, uddInfo.pszUserID);
	if (NULL == uddInfo.pszMasterUID) {
		printf("Account is a master account.\n");
		strncpy(szWriteBackUID, uddInfo.pszUserID, 10);
		szWriteBackUID[10] = 0;
	} else {
		struct UserDBData uddMasterInfo;
		printf("Account is slaved to '%s'\n", uddInfo.pszMasterUID);
		strncpy(szWriteBackUID, uddInfo.pszMasterUID, 10);
		szWriteBackUID[10] = 0;
		uddMasterInfo.pszUserID = strndup(szWriteBackUID, 10);
		if (!pDBManager->FindUser(skUSER_ID, uddMasterInfo)) {
			printf("Master account does not exist in database.\n");
			pParent->TransmitCommand("DK", NULL, 0);
			return false;
		}
		uddInfo.pszPin = strndup(uddMasterInfo.pszPin, 4);
	}
	if (0 != strncmp(szPin, uddInfo.pszPin, 4)) {
		printf("Client PIN '%s' does not match server PIN '%s'\n", szPin, uddInfo.pszPin);
		pParent->TransmitCommand("DK", NULL, 0);
		return false;
	} else {
		if (atNEW_DISK == uddInfo.accountType) {
			printf("New disk detected.  Not yet supported.\n");
		} else if (atDEMO == uddInfo.accountType) {
			printf("Demo disk detected.  Not yet supported.\n");
		} else if (atDISABLED == uddInfo.accountType) {
			printf("Account has been disabled.\n");
			pParent->TransmitCommand("DX", NULL, 0);
		} else if (atNORMAL == uddInfo.accountType) {
			if (NULL != FindUserByMasterUID(szWriteBackUID)) {
				pParent->TransmitCommand("DA", NULL, 0);
				return false;
			}
			strncpy(szPin, itob64(random()), 4);
			printf("Client authorized.  Saving new PIN '%s'.\n", szPin);
			if (!pDBManager->SetPIN(szWriteBackUID, szPin)) {
				printf("Error setting PIN in database.  Aborting.\n");
				pParent->TransmitCommand("D!", NULL, 0);
				return false;
			}		
			pParent->TransmitCommand("D3", szPin, 4);
		}
	}
	return true;
}
/** This function handles all needs after the disk has been validated. */
void QPorch::DiskValidatedOK(QUser* pParent){
	// We don't support questionaires yet, so just jump to the main menu
	pParent->TransmitCommand("DO", NULL, 0);
}
/** No descriptions */
char* QPorch::GetUserID(){
	return uddInfo.pszUserID;
}
/** No descriptions */
char* QPorch::GetPIN(){
	return uddInfo.pszPin;
}
/** No descriptions */
char* QPorch::GetScreenName(){
	return uddInfo.pszScreenName;
}
/** No descriptions */
char* QPorch::GetMasterUID(){
	return uddInfo.pszMasterUID;
}
