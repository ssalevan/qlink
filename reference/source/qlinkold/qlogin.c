#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <syslog.h>

#include "config.h"
#include "qpacket.h"
#include "qlogin.h"
#include "qnewuser.h"
#include "qmcp.h"
#include "qdb.h"

enum eQuestionType {
  qtAcknowledge,
  qtYesNoMaybe,
  qtArbitrary,
  qtInvalid,
	qtFreeze,
};

struct UserInfo userInfo;

char szCurQuestionName[11];   /*Holds the name of the currently pending question*/
char szCurQuestFileName[128]; /*Holds the filename to display to ask the pending question*/
enum eQuestionType eqtCurQuestType; /*Holds the type of the current question*/

/*Forward declarations*/

/*Functions*/

/*This function is called with the user ID and pin given
  by the client in the login command*/
void qlogin_userlogin(char* pszUserID, char* pszPin) {

   syslog(LOG_INFO, "Login received.  UserID = %s, Pin = %s", pszUserID, pszPin);

	strcpy(userInfo.szUserID, pszUserID);
	if (qdb_getuserbyID(&userInfo)) {
      syslog(LOG_INFO, "PIN '%s'", userInfo.szPin);
      if (0 != strncmp(userInfo.szPin, pszPin, 4)) {
         qlogin_baduserorpass();
			return;
	   }
	   if (userInfo.accountType == uatNormal) {
         if (qmcp_connectuser(userInfo.szScreenName)) {
	         qlogin_updatedisk(pszPin);
         } else {
            qlogin_acctinuse();
         }
	  } else {
  	      qlogin_blankscreen("NUSERBLANK");
	  }
   } else {
	   qlogin_baduserorpass();
		return;
	}
}


/*This function sends a request to the client to blank the message
  area so that interactive question/answer stuff may occurr*/
void qlogin_blankscreen(char* pszQuestionName){
  strncpy(szCurQuestionName, pszQuestionName, 10);
	transmit_command("D1", NULL, 0);
}

/*This function is called when the client has blanked the screen*/
void qlogin_blankscreenok(void){
  syslog(LOG_INFO, "ID=%s: Client has blanked the screen for interactive mode.", userInfo.szUserID);

	if (0 == strncmp("NUSERBLANK", szCurQuestionName, 10)) {
	  qnewuser_beginscript();
	}
}

/*This function saves the new pincode to the disk along with any
  user account changes that have been made*/
void qlogin_updatedisk(char* pszPinCode){

  transmit_command("D3", pszPinCode, 4);
}

/*This function resets the disks user information and gives it a
  primary user account*/
void qlogin_setprimaryuser(char* pszScreenName, char* pszUserID){

  char szTempString[128];

	strncpy(szTempString, pszUserID, 10);
  szTempString[10] = 0;
  strncat(szTempString, pszScreenName, 10);
	memset(szTempString+strlen(szTempString), 0x20, 128-strlen(szTempString));
  szTempString[20] = 0;
	transmit_command("D7", NULL, 0);
  transmit_command("D4", szTempString, 20);
}

/*This function is called when the user login info could not be saved*/
void qlogin_disknotupdated(void) {

  syslog(LOG_ERR, "ID=%s: Login information could not save to the client disk.", userInfo.szUserID);

	transmit_command("D!", NULL, 0);
}

/*This function is called when the user login info has been saved properly
  to the client disk*/
void qlogin_diskupdated(void) {

  syslog(LOG_INFO, "ID=%s: Login information saved to the client disk.", userInfo.szUserID);

	qlogin_bulletin("Bulletin.txt");
}

/*This function adds a user to the disk so that the user will be
  prompted in future logins*/
void qlogin_addsecondaryuser(char* pszScreenName, char* pszUserID){
  char szTempString[128];

  strncpy(szTempString, pszUserID, 10);
  szTempString[10] = 0;
  strncat(szTempString, pszScreenName, 10);
  szTempString[20] = 0;
  transmit_command("D8", szTempString, 20);
}

/*This function sends the code to the client to tell it to display
  the bad username or password screen*/
void qlogin_baduserorpass(void) {
  transmit_command("DK", NULL, 0);
}

/*This function sends the code to the client to tell it to display
  the account in use screen*/
void qlogin_acctinuse(void) {
  transmit_command("DA", NULL, 0);
}

/*This function sends the code to the client to tell it to display
  the account invalidated*/
void qlogin_acctinvalidated(void) {
  transmit_command("DX", NULL, 0);
}

/*This function takes a file name and displays it as the final
  bulletin before the main menu */
void qlogin_bulletin(char* pszFilename){
  FILE* fpMessageFile;
  char  szTempString[1024];
  char  szReadBuffer[128];
  int   nNumLines;

  strcpy (szTempString, DATA_DIR);
  strncat (szTempString, pszFilename, 1024-strlen(szTempString));

  fpMessageFile = fopen(szTempString, "r");
  if (fpMessageFile == NULL) {
    transmit_command("DO", NULL, 0);
    return;
  }

  nNumLines = 0;
  while (NULL != fgets(szReadBuffer, 128, fpMessageFile)) {
    szReadBuffer[40] = 0;
    transmit_command("SM", szReadBuffer, strlen(szReadBuffer));
    nNumLines++;
    if (nNumLines == 10) {
      break;
    }
  }
  fclose(fpMessageFile);

  if (nNumLines == 0) {
    transmit_command("DO", NULL, 0);
  } else {
    transmit_command("SE", "         Press <F5> to continue.        ", 40);
  }
}

/*This function actually sends the first packet needed for
  the question session*/
int qlogin_startquestion(char* pszQuestionName, char* pszFilename){
  FILE* fpMessageFile;
  char  szTempString[1024];

  strcpy(szTempString, DATA_DIR);
  strcat(szTempString, pszFilename);

  fpMessageFile = fopen(szTempString, "r");
  if (fpMessageFile == NULL) {
	  syslog(LOG_NOTICE, "ID=%s: Could not open file %s", userInfo.szUserID, pszFilename);
  	return 0;
  }
  fclose(fpMessageFile);

  syslog(LOG_INFO, "ID=%s: Starting question %s", userInfo.szUserID, pszQuestionName);

  strcpy(szCurQuestFileName, pszFilename);

	if (0 == strcmp(pszQuestionName, szCurQuestionName)) {
	  qlogin_questionready(pszQuestionName);
	} else {
    transmit_command("ZM", pszQuestionName, 10);
  	strcpy(szCurQuestionName, pszQuestionName);
	}
  return 1;
}

/*This function sets things up and sends the first packet
  to display some information to the user and ask them to
  press <F5> to continue*/
int qlogin_askforacknowledge(char *pszQuestionName, char *pszFilename){
  eqtCurQuestType = qtAcknowledge;
  return qlogin_startquestion(pszQuestionName, pszFilename);
}

/*This function sets things up and sends the first packet
  to display some information to the user and ask them to
  enter yes or no or <F5> for maybe*/
int qlogin_askforyesnomaybe(char *pszQuestionName, char *pszFilename){
  eqtCurQuestType = qtYesNoMaybe;
  return qlogin_startquestion(pszQuestionName, pszFilename);
}

/*This function sets things up and sends the first packet
  to display some information to the user and ask them to
  enter an arbitrary text string*/
int qlogin_askforanswer(char *pszQuestionName, char *pszFilename){
  eqtCurQuestType = qtArbitrary;
  return qlogin_startquestion(pszQuestionName, pszFilename);
}

/*This function sets things up and sends the first packet
  to display some information to the user and ask them to
  retry their last response cause it was invalid*/
int qlogin_sendinvalid(char *pszQuestionName, char *pszFilename){
  eqtCurQuestType = qtInvalid;
  return qlogin_startquestion(pszQuestionName, pszFilename);
}

/*This function sets things up and sends the first packet
  to display some information to the user and freezes*/
int qlogin_sendfreeze(char *pszQuestionName, char *pszFilename){
  eqtCurQuestType = qtFreeze;
  return qlogin_startquestion(pszQuestionName, pszFilename);
}

/*This function is called to tell us that the client is ready for
  the question text along with the question type command*/
void qlogin_questionready(char *pszQuestionName) {
  FILE* fpMessageFile;
  char  szTempString[1024];
  char  szReadBuffer[128];
  int   nNumLines;

	syslog(LOG_INFO, "ID=%s: Asking question %s", userInfo.szUserID, pszQuestionName);

  strcpy (szTempString, DATA_DIR);
  strncat (szTempString, szCurQuestFileName, 1024-strlen(szTempString));

  fpMessageFile = fopen(szTempString, "r");
  if (fpMessageFile == NULL) {
		strcpy(szTempString, szCurQuestionName);
		strcat(szTempString, "\x90");
		strcat(szTempString, "  An internal server inconsistency has  ");
    transmit_command("ZT", szTempString, 51);
		strcpy(szTempString, szCurQuestionName);
		strcat(szTempString, "\x90");
		strcat(szTempString, "been detected.  Please contact customer ");
    transmit_command("ZT", szTempString, 51);
		strcpy(szTempString, szCurQuestionName);
		strcat(szTempString, "\x90");
		strcat(szTempString, "      service for more information.     ");
    transmit_command("ZT", szTempString, 51);
    return;
  }

	nNumLines = 0;
  while (NULL != fgets(szReadBuffer, 128, fpMessageFile)) {
    szReadBuffer[40] = 0;
		strcpy(szTempString, szCurQuestionName);
		strcat(szTempString, "\x90");
		strcat(szTempString, szReadBuffer);
		if (eqtCurQuestType == qtInvalid) {
		  transmit_command("ZH", szTempString, strlen(szTempString));
		} else {
      transmit_command("ZT", szTempString, strlen(szTempString));
		}
    nNumLines++;
    if (nNumLines == 10) {
      break;
    }
  }
  fclose(fpMessageFile);

  if (nNumLines == 0) {
		strcpy(szTempString, szCurQuestionName);
		strcat(szTempString, "\x90");
		strcat(szTempString, "  An internal server inconsistency has  ");
    transmit_command("ZT", szTempString, 51);
		strcpy(szTempString, szCurQuestionName);
		strcat(szTempString, "\x90");
		strcat(szTempString, "been detected.  Please contact customer ");
    transmit_command("ZT", szTempString, 51);
		strcpy(szTempString, szCurQuestionName);
		strcat(szTempString, "\x90");
		strcat(szTempString, "      service for more information.     ");
    transmit_command("ZT", szTempString, 51);
  } else {
    if (eqtCurQuestType == qtAcknowledge) {
      strcpy(szTempString, szCurQuestionName);
      strcat(szTempString, "\x90");
      strcat(szTempString, "         Press <F5> to continue.        ");
      transmit_command("ZZ", szTempString, 51);
    } else if (eqtCurQuestType == qtYesNoMaybe) {
      strcpy(szTempString, szCurQuestionName);
      strcat(szTempString, "\x90");
      strcat(szTempString, "Please answer the question 'yes' or 'no'");
      transmit_command("ZE", szTempString, 51);
    } else if (eqtCurQuestType == qtInvalid) {
      strcpy(szTempString, szCurQuestionName);
      strcat(szTempString, "\x90");
      strcat(szTempString, "  Press <F5> to go back and try again.  ");
      transmit_command("ZI", szTempString, 51);
    } else if (eqtCurQuestType == qtArbitrary) {
      strcpy(szTempString, szCurQuestionName);
      strcat(szTempString, "\x90""ello\x90");
      strcat(szTempString, "         Please type your answer.       ");
      transmit_command("ZQ", szTempString, 56);
    }
  }
}

/*This function is called when the user presses <F5> at a question banner*/
void qlogin_answerok(void){
  syslog(LOG_INFO, "ID=%s: User acknowledged a question banner.", userInfo.szUserID);

  if (0 == strncmp("NUSER", szCurQuestionName, 5)) {
	  qnewuser_scriptok(szCurQuestionName);
  }
}

void qlogin_answermaybe(char* pszQuestionName){

  syslog(LOG_INFO, "ID=%s: User answered maybe to question %s, and it's done.", userInfo.szUserID, pszQuestionName);

  if (0 == strncmp("NUSER", pszQuestionName, 5)) {
	  qnewuser_scriptmaybe(pszQuestionName);
  }
}

void qlogin_answerno(char* pszQuestionName){

  syslog(LOG_INFO, "ID=%s: User answered no to question %s, and it's done.", userInfo.szUserID, pszQuestionName);

  if (0 == strncmp("NUSER", pszQuestionName, 5)) {
	  qnewuser_scriptno(pszQuestionName);
  }
}

void qlogin_answeryes(char* pszQuestionName){

  syslog(LOG_INFO, "ID=%s: User answered yes to question %s.", userInfo.szUserID, pszQuestionName);

  if (0 == strncmp("NUSER", pszQuestionName, 5)) {
	  syslog(LOG_INFO, "Calling qnewuser_scriptyes()");
	  qnewuser_scriptyes(pszQuestionName);
  }
}

void qlogin_answertext(char* pszQuestionName, char* pszText){

  syslog(LOG_ERR, "ID=%s: User answered question %s: %s", userInfo.szUserID, pszQuestionName, pszText);

  if (0 == strncmp("NUSER", pszQuestionName, 5)) {
	  qnewuser_scripttext(pszQuestionName, pszText);
  }
}


