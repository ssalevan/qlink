#include <stdio.h>
#include <string.h>
#include <syslog.h>

#include <mysql.h>

#include "config.h"
#include "qdb.h"

MYSQL msDataObject;

int qdb_getuserbyID(struct UserInfo* pUserInfo){

   MYSQL_RES* msResult;
   MYSQL_ROW  msRow;

   char szTempString[128];

   sprintf(szTempString, "SELECT * FROM users WHERE UserID = '%s'", pUserInfo->szUserID);

   syslog(LOG_INFO, "Querying from database: %s", szTempString);

   if (0 != mysql_query(&msDataObject, szTempString)) {
     syslog(LOG_ERR, "Error querying database: %s", mysql_error(&msDataObject));
     return 0;
   }

   msResult = mysql_store_result(&msDataObject);
   if (msResult == NULL) {
     syslog(LOG_ERR, "Error reading database: %s", mysql_error(&msDataObject));
     return 0;
  }

   while ((msRow = mysql_fetch_row(msResult))) {
      unsigned long* lengths;

      lengths = mysql_fetch_lengths(msResult);
      memset(pUserInfo->szScreenName, 0, 11);
      memset(pUserInfo->szPin, 0x20, 4);
      pUserInfo->szPin[4] = 0;
      strncpy(pUserInfo->szScreenName, msRow[1], lengths[1]);
      syslog(LOG_INFO, "Found user: %s", pUserInfo->szScreenName);
      if (0 == strncmp("NEWDISK", msRow[2], lengths[2])) {
		  pUserInfo->accountType = uatNewDisk;
			syslog(LOG_INFO, "New disk on system");
		} else if (0 == strncmp("NORMAL", msRow[2], lengths[2])) {
		  pUserInfo->accountType = uatNormal;
			syslog(LOG_INFO, "Normal user account");
		}
		strncpy(pUserInfo->szPin, msRow[3], lengths[3]);
		mysql_free_result(msResult);
		return 1;
	}
	return 0;
}

int qdb_getuserbyname(struct UserInfo* pUserInfo){

  MYSQL_RES* msResult;
	MYSQL_ROW  msRow;

  char szTempString[128];

	sprintf(szTempString, "SELECT * FROM users WHERE ScreenName = '%s'", pUserInfo->szScreenName);

	syslog(LOG_INFO, "Querying from database: %s", szTempString);

	if (0 != mysql_query(&msDataObject, szTempString)) {
	  syslog(LOG_ERR, "Error querying database: %s", mysql_error(&msDataObject));
		return 0;
	}

	msResult = mysql_store_result(&msDataObject);
	if (msResult == NULL) {
	  syslog(LOG_ERR, "Error reading database: %s", mysql_error(&msDataObject));
		return 0;
  }

	while ((msRow = mysql_fetch_row(msResult))) {
	  unsigned long* lengths;

		lengths = mysql_fetch_lengths(msResult);
		memset(pUserInfo->szPin, 0x20, 4);
		pUserInfo->szPin[4] = 0;
    strncpy(pUserInfo->szUserID, msRow[0], lengths[0]);
		syslog(LOG_INFO, "Found user ID: %s", pUserInfo->szUserID);
    if (0 == strncmp("NEWDISK", msRow[2], lengths[2])) {
		  pUserInfo->accountType = uatNewDisk;
		} else if (0 == strncmp("NORMAL", msRow[2], lengths[2])) {
		  pUserInfo->accountType = uatNormal;
		}
		strncpy(pUserInfo->szPin, msRow[3], lengths[3]);
		mysql_free_result(msResult);
		return 1;
	}
	return 0;
}

int qdb_createuser(struct UserInfo* pUserInfo) {
	struct UserInfo TempUserInfo;
	unsigned long long ullUserID;

	char szTempString[128];

	strcpy(TempUserInfo.szScreenName, pUserInfo->szScreenName);

	if (qdb_getuserbyname(&TempUserInfo)) {
	  syslog(LOG_NOTICE, "Screen name '%s' is already in use.", pUserInfo->szScreenName);
		return -1;
	}

	sprintf(szTempString, "INSERT INTO users VALUES(NULL, '%s', 'NORMAL', '%s')", pUserInfo->szScreenName, pUserInfo->szPin);

	syslog(LOG_INFO, "Inserting into database: %s", szTempString);

	if (0 != mysql_query(&msDataObject, szTempString)) {
	  syslog(LOG_ERR, "Error inserting into database: %s", mysql_error(&msDataObject));
		return 0;
	}

	ullUserID = mysql_insert_id(&msDataObject);

	sprintf(pUserInfo->szUserID, "%llu", ullUserID);
	syslog(LOG_INFO, "Created user with UID: '%s'", pUserInfo->szUserID);
  return 1;
}

int qdb_sendemail(char* pszEmailFileName, char* pszDestName, char* pszSrcName) {

  char szTempString[128];

	sprintf(szTempString, "INSERT INTO email VALUES('%s', '%s', '%s')", pszDestName, pszSrcName, pszEmailFileName);

  syslog(LOG_INFO, "Inserting into database: %s", szTempString);

	if (0 != mysql_query(&msDataObject, szTempString)) {
	  syslog(LOG_ERR, "Error inserting into database: %s", mysql_error(&msDataObject));
		return 0;
	}

  return 1;
}

int qdb_checkemail(char* pszScreenName){

  MYSQL_RES* msResult;
	MYSQL_ROW  msRow;

  char szTempString[128];

	sprintf(szTempString, "SELECT * FROM email WHERE ToUser = '%s'", pszScreenName);

	syslog(LOG_INFO, "Querying from database: %s", szTempString);

	if (0 != mysql_query(&msDataObject, szTempString)) {
	  syslog(LOG_ERR, "Error querying database: %s", mysql_error(&msDataObject));
		return 0;
	}

	msResult = mysql_store_result(&msDataObject);
	if (msResult == NULL) {
	  syslog(LOG_ERR, "Error reading database: %s", mysql_error(&msDataObject));
		return 0;
  }

	while ((msRow = mysql_fetch_row(msResult))) {
		return 1;
	}
	return 0;
}

int qdb_deleteemail(char* pszToName, char* pszFileID){

  char szTempString[128];

	sprintf(szTempString, "DELETE FROM email WHERE ToUser = '%s' AND FileID = '%s'", pszToName, pszFileID);

	syslog(LOG_INFO, "Querying from database: %s", szTempString);

	if (0 != mysql_query(&msDataObject, szTempString)) {
	  syslog(LOG_ERR, "Error querying database: %s", mysql_error(&msDataObject));
		return 0;
	}

  return 1;
}

int qdb_getemail(char* pszScreenName, char* pszFileID){

  MYSQL_RES* msResult;
	MYSQL_ROW  msRow;

  char szTempString[128];

	sprintf(szTempString, "SELECT * FROM email WHERE ToUser = '%s' LIMIT 1", pszScreenName);

	syslog(LOG_INFO, "Querying from database: %s", szTempString);

	if (0 != mysql_query(&msDataObject, szTempString)) {
	  syslog(LOG_ERR, "Error querying database: %s", mysql_error(&msDataObject));
		return 0;
	}

	msResult = mysql_store_result(&msDataObject);
	if (msResult == NULL) {
	  syslog(LOG_ERR, "Error reading database: %s", mysql_error(&msDataObject));
		return 0;
  }

	while ((msRow = mysql_fetch_row(msResult))) {
	  unsigned long* lengths;

		lengths = mysql_fetch_lengths(msResult);
		memset(pszFileID, 0, 33);
    strncpy(pszFileID, msRow[2], lengths[2]);
		syslog(LOG_INFO, "Found email message ID: %s", pszFileID);
		return 1;
	}
	return 0;
}

/*This function initializes database access*/
int qdb_init(void) {
  mysql_init(&msDataObject);
  if (!mysql_real_connect(&msDataObject, DB_HOSTNAME, DB_USER, DB_PASS, "quantumlink", 0, NULL, 0)) {
	  syslog(LOG_ERR, "Error connecting to database server: %s", mysql_error(&msDataObject));
		return 0;
	}
  return 1;
}
