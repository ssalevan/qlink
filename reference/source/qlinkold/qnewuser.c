#include <stdio.h>
#include <syslog.h>
#include <string.h>

#include "config.h"
#include "qlogin.h"
#include "qnewuser.h"
#include "qdb.h"

/*Login script module*/

extern struct UserInfo userInfo;

int nScriptState;

void qnewuser_scriptok(char* pszQuestionName){

  switch (nScriptState) {
	  case 3:
		  /*User acked thank you, so save info and go on*/
			nScriptState = 4;
			qnewuser_doscript();
			break;
  }
}

void qnewuser_scriptno(char* pszQuestionName){

  switch (nScriptState) {
	  case 0:
		  /*The user doesn't want an account, so we tell them they
			  need one and freeze*/
      nScriptState = 1;
			qnewuser_doscript();
			break;
	}
}

void qnewuser_scriptmaybe(char* pszQuestionName){

	switch (nScriptState) {
	  case 0:
		  /*The user doesn't want an account, so we tell them they
			  need one and freeze*/
      nScriptState = 1;
			qnewuser_doscript();
			break;
	}
}

void qnewuser_scriptyes(char* pszQuestionName){

  syslog(LOG_INFO, "qnewuser_scriptyes() called");
	switch (nScriptState) {
	  case 0:
		  /*The user wants an account, and has one, so we start
			  asking away*/
      nScriptState = 2;
			qnewuser_doscript();
			break;
	}
}

void qnewuser_scripttext(char* pszQuestionName, char* pszText){

	switch (nScriptState) {
	  case 2:
		  /*The user typed in a screen name, thank the user for registering*/
      strcpy(userInfo.szScreenName, pszText);

			if (qdb_getuserbyname(&userInfo)) {
			  qlogin_sendinvalid("NUSERCREA1", "NUser/ScreenNameUsed.txt");
			} else {
			  nScriptState = 3;
			  qnewuser_doscript();
      }
			break;
	}
}

void qnewuser_doscript(void) {
	int nStatus;

	syslog(LOG_INFO, "Handling script state %d.", nScriptState);

  switch (nScriptState) {
	  case 0:
  		/*Greet user and find out if they want to create an account*/
		  qlogin_askforyesnomaybe("NUSERCREA1", "NUser/Greetings.txt");
		  break;
    case 1:
      qlogin_sendfreeze("NUSERCREA2", "NUser/AccountNeeds.txt");
			break;
    case 2:
      qlogin_askforanswer("NUSERCREA1", "NUser/AskScreenName.txt");
			break;
    case 3:
			qlogin_askforacknowledge("NUSERCREA1", "NUser/Thankyou.txt");
			break;
		case 4:
		  strcpy(userInfo.szPin, "1234");
			nStatus = qdb_createuser(&userInfo);
      if (0 == nStatus) {
			  qlogin_sendfreeze("NUSERCREA1", "NUser/DatabaseError.txt");
      } else {
			  qlogin_setprimaryuser(userInfo.szScreenName, userInfo.szUserID);
			  qlogin_updatedisk(userInfo.szPin);
			}
			break;
  }
}

/*This function starts the new user script
  that gets the basic information from the user*/
void qnewuser_beginscript(void) {

  nScriptState = 0;

	qnewuser_doscript();
}
