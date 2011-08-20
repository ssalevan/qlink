/***************************************************************************
                          dbaccess.cpp  -  description
                             -------------------
    begin                : Sat Dec 8 2001
    copyright            : (C) 2001 by Keith Henrickson
    email                : flipper@phin.com
 ***************************************************************************/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "dbaccess.h"

DBAccess::DBAccess(){
	mysql_init(&msDataObject);
}

DBAccess::~DBAccess(){
}
/** This function makes the initial connection to the DB */
bool DBAccess::Connect(char* pszHostName, char* pszUserName, char* pszPassword){
	if (!mysql_real_connect(&msDataObject, pszHostName, pszUserName, pszPassword, "quantumlink", 0, NULL, 0)) {
		return false;
	}
	return true;
}
/** No descriptions */
bool DBAccess::FindUser(SearchKey skKey, UserDBData& UserData){
	MYSQL_RES* msResult;
	MYSQL_ROW  msRow;
	char szTempString[128];
	
	if (skUSER_ID == skKey) {
		sprintf(szTempString, "SELECT * FROM users WHERE UserID = '%s'", UserData.pszUserID);
		free(UserData.pszUserID);
	} else {
		sprintf(szTempString, "SELECT * FROM users WHERE ScreenName = '%s'", UserData.pszScreenName);
		free(UserData.pszScreenName);
	}
	if (0 != mysql_query(&msDataObject, szTempString)) {
		printf("Error querying database.\n");
		return false;
	}
	msResult = mysql_store_result(&msDataObject);
	if (NULL == msResult) {
		printf("Error storing result from database.\n");
		return false;
	}
	msRow = mysql_fetch_row(msResult);
	if (NULL != msRow) {
		unsigned long *lengths;
		lengths = mysql_fetch_lengths(msResult);
		UserData.pszUserID = strndup(msRow[0], 10);
		UserData.pszScreenName = strndup(msRow[1], 10);
		if (NULL != msRow[3]) {
			UserData.pszPin = strndup(msRow[3], 4);
		}
		if (NULL != msRow[4]) {
			UserData.pszMasterUID = strndup(msRow[4], 10);
		}
		if (0 == strcmp(msRow[2], "NORMAL")) {
			UserData.accountType = atNORMAL;
		} else if (0 == strcmp(msRow[2], "NEWDISK")) {
			UserData.accountType = atNEW_DISK;
		} else if (0 == strcmp(msRow[2], "DEMO")) {
			UserData.accountType = atDEMO;
		} else if (0 == strcmp(msRow[2], "DISABLED")) {
			UserData.accountType = atDISABLED;
		}
		mysql_free_result(msResult);
		return true;
	}
	return false;
}
/** No descriptions */
bool DBAccess::SetPIN(char* pszUserID, char* pszPin){
	char szTempString[128];
	
	sprintf(szTempString, "UPDATE users SET PIN='%s' WHERE UserID = '%s'", pszPin, pszUserID);
	if (0 != mysql_query(&msDataObject, szTempString)) {
		printf("Error setting PIN for user '%s'.\n", pszUserID);
		return false;
	}
	return true;
}
