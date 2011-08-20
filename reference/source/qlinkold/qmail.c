#include <stdio.h>
#include <syslog.h>
#include <string.h>

#include "qmail.h"
#include "qdb.h"
#include "qfile.h"
#include "qpacket.h"
#include "qmcp.h"

extern struct UserInfo userInfo;

FILE* fpDestFile;
char szEmailFileName[1024];
int nLineNumber;
char szDestName[11];

void qmail_startemail(char* pszScreenName) {
  struct UserInfo tempUserInfo;
	char szTempStr[128];

	strcpy(tempUserInfo.szScreenName, pszScreenName);
   if (qdb_getuserbyname(&tempUserInfo)) {
      fpDestFile = qfile_createunique(szEmailFileName);
		if (NULL == fpDestFile) {
         syslog(LOG_INFO, "Cannot create the email data file.");
         transmit_command("E2", NULL, 0);
         return;
		}
      syslog(LOG_INFO, "Created file %s", szEmailFileName);
      sprintf(szTempStr,"Type your email message now...\x90%s", userInfo.szScreenName);
		nLineNumber = 0;
		strcpy(szDestName, pszScreenName);
		transmit_command("EK", szTempStr, strlen(szTempStr));
	} else {
	  /* User does not exist*/
	  transmit_command("E2", NULL, 0);
  }
}

void qmail_receiveline(char* pszEmailText, int fLastLine){

  if (nLineNumber != 1) {
    fprintf(fpDestFile, "%s\n", pszEmailText);
	}

	if (fLastLine) {
	  fclose(fpDestFile);
    qdb_sendemail(szEmailFileName, szDestName, userInfo.szScreenName);
	}

	nLineNumber++;

}

void qmail_checkmail(void) {
  if (qdb_checkemail(userInfo.szScreenName)) {
	  transmit_command("EW", NULL, 0);
  }
}

void qmail_reademail(void) {
	char  szMailID[33];

  if (qdb_getemail(userInfo.szScreenName, szMailID)) {
	  transmit_command("RN", NULL, 0);
		qdb_deleteemail(userInfo.szScreenName, szMailID);
		if (qdb_checkemail(userInfo.szScreenName)) {
		  qfile_dumpfile(szMailID, "RS", "RE", 45);
		} else {
		  qfile_dumpfile(szMailID, "RS", "RF", 45);
    }
	} else {
	  transmit_command("RD", NULL, 0);
	}
}

void qmail_startolm(char *pszRecipName) {

   if (qmcp_useronline(pszRecipName)) {
      strncpy(szDestName, pszRecipName, 11);
      transmit_command("OK", userInfo.szScreenName, strlen(userInfo.szScreenName));
   } else {
      transmit_command("OX", NULL, 0);
   }
}

void qmail_sendolm(char *pszMsgTxt, int nLastLine) {
   qmcp_sendolm(szDestName, pszMsgTxt, nLastLine);
}

void qmail_init(void) {
}
