#include <stdio.h>
#include <string.h>
#include <syslog.h>

#include "qpacket.h"
#include "qtelnet.h"
#include "qlogin.h"
#include "qmenus.h"
#include "qmail.h"
#include "qmcp.h"


static int nQparseMode;

void qparse_login (char *szCommand, unsigned char *pPacketBuf, int nPacketLen) {
  char szString[8][128];
  if (0 == strcmp(szCommand, "DD")) {

		memcpy(szString[1], pPacketBuf, 10);
		memcpy(szString[2], pPacketBuf+10, 4);
		szString[1][10] = 0;
		szString[2][4] = 0;

		qlogin_userlogin(szString[1], szString[2]);
  } else if (0 == strcmp(szCommand, "D1")) {
	  /*The message area has been blanked for interactive
		  sessions*/
	  qlogin_blankscreenok();
  } else if (0 == strcmp(szCommand, "D2")) {
	  /*User has pressed <F5> at a message banner*/
	  qlogin_answerok();
  } else if (0 == strcmp(szCommand, "D5")) {
	  /*Unable to save user login info to the disk*/
		qlogin_disknotupdated();
  } else if (0 == strcmp(szCommand, "D6")) {
	  /*Saved user login info to the disk*/
	  qlogin_diskupdated();
  } else if (0 == strcmp(szCommand, "ZA")) {
	  /*User has submitted a text answer*/
      syslog(LOG_INFO, "Packet buffer is: '%s'", pPacketBuf);
      syslog(LOG_INFO, "Packet len is: %d", nPacketLen);
		memcpy(szString[1], pPacketBuf, 10);
		memcpy(szString[2], pPacketBuf+11, nPacketLen - 11);
		szString[1][10] = 0;
		szString[2][nPacketLen - 11] = 0;
		qlogin_answertext(szString[1], szString[2]);
  } else if (0 == strcmp(szCommand, "ZM")) {
	  /*User has answered a yes/no question with maybe <F5>*/
		memcpy(szString[1], pPacketBuf, 10);
		szString[1][10] = 0;
		qlogin_answermaybe(szString[1]);
  } else if (0 == strcmp(szCommand, "ZN")) {
	  /*user has answered a yes/no question with no*/
		memcpy(szString[1], pPacketBuf, 10);
		szString[1][10] = 0;
		qlogin_answerno(szString[1]);
  } else if (0 == strcmp(szCommand, "ZO")) {
	  /*The client is ready to accept and display a question*/
		memcpy(szString[1], pPacketBuf, 10);
		szString[1][10] = 0;
		qlogin_questionready(szString[1]);
  } else if (0 == strcmp(szCommand, "ZY")) {
	  /*user has answered a yes/no question with yes*/
		memcpy(szString[1], pPacketBuf, 10);
		szString[1][10] = 0;
		qlogin_answeryes(szString[1]);
	}
}

void qparse_nonchat (char *szCommand, unsigned char *pPacketBuf, int nPacketLen) {

  char szTempStr[256];
  char szString[8][128];

	memset (szTempStr, 0, 256);
	strncpy(szTempStr, pPacketBuf, nPacketLen);

	syslog(LOG_INFO, "Parameter: '%s'", szTempStr);

	if (0 == strcmp(szCommand, "K1")) {
      memcpy(szString[1], pPacketBuf, 4);
      szString[1][4] = 0;
      qmenus_itemselect(szString[1]);
   } else 	if (0 == strcmp(szCommand, "EN")){
		memcpy(szString[1], pPacketBuf, 10);
		szString[1][10] = 0;
		qmail_startemail(szString[1]);
   } else  if (0 == strcmp(szCommand, "EM")){
      memcpy(szString[1], pPacketBuf, nPacketLen);
		szString[1][nPacketLen] = 0;
		qmail_receiveline(szString[1], 0);
   } else  if (0 == strcmp(szCommand, "EE")){
      memcpy(szString[1], pPacketBuf, nPacketLen);
		szString[1][nPacketLen] = 0;
		qmail_receiveline(szString[1], 1);
	} else 	if (0 == strcmp(szCommand, "ON")){
		memcpy(szString[1], pPacketBuf, 10);
		szString[1][10] = 0;
      qmail_startolm(szString[1]);
	} else 	if (0 == strcmp(szCommand, "OM")){
      memcpy(szString[1], pPacketBuf, nPacketLen);
		szString[1][nPacketLen] = 0;
      qmail_sendolm(szString[1], 0);
	} else 	if (0 == strcmp(szCommand, "OE")){
      memcpy(szString[1], pPacketBuf, nPacketLen);
		szString[1][nPacketLen] = 0;
      qmail_sendolm(szString[1], 1);
   } else  if (0 == strcmp(szCommand, "RM")){
      qmail_reademail();
   } else  if (0 == strcmp(szCommand, "Y1")){
      memcpy(szString[1], pPacketBuf, nPacketLen);
		szString[1][nPacketLen] = 0;
      qtelnet_transmit(szString[1]);
   } else  if (0 == strcmp(szCommand, "Y2")){
      qtelnet_close();
   }
}

void qparse_chat (char *szCommand, unsigned char *pPacketBuf, int nPacketLen) {
  char szTempStr[256];
  char szString[8][128];

	memset (szTempStr, 0, 256);
	strncpy(szTempStr, pPacketBuf, nPacketLen);

	syslog(LOG_INFO, "Parameter: '%s'", szTempStr);

   if (0 == strcmp(szCommand, "EN")){
		memcpy(szString[1], pPacketBuf, 10);
		szString[1][10] = 0;
		qmail_startemail(szString[1]);
   } else  if (0 == strcmp(szCommand, "EM")){
      memcpy(szString[1], pPacketBuf, nPacketLen);
		szString[1][nPacketLen] = 0;
		qmail_receiveline(szString[1], 0);
   } else  if (0 == strcmp(szCommand, "EE")){
      memcpy(szString[1], pPacketBuf, nPacketLen);
		szString[1][nPacketLen] = 0;
		qmail_receiveline(szString[1], 1);
	} else 	if (0 == strcmp(szCommand, "ON")){
      //transmit_command("OK", "Type your message\x90KEITH 2061", 28);
      transmit_command("ON", NULL, 0);
   } else  if (0 == strcmp(szCommand, "RM")){
      qmail_reademail();
   } else  if (0 == strcmp(szCommand, "AA")){
      memcpy(szString[1], pPacketBuf, nPacketLen);
		szString[1][nPacketLen] = 0;
      qmcp_sendtalk(szString[1]);
   } else  if (0 == strcmp(szCommand, "CM")){
      memcpy(szString[1], pPacketBuf, nPacketLen);
		szString[1][nPacketLen] = 0;
      qmcp_sendjoin(szString[1]);
   } else if (0 == strcmp(szCommand, "MX")){
      transmit_command("MC", NULL, 0);
   }
}

void qparse_handlepacket (unsigned char *pPacketBuf, int nPacketLen){

  char szCommand[3];

	/*Extract the command*/
	szCommand[0] = pPacketBuf[0];
	szCommand[1] = pPacketBuf[1];
	szCommand[2] = 0;

	syslog(LOG_INFO, "Command %s received.", szCommand);

	/* Handle general cases here */

  if (0 == strcmp(szCommand, "SS")) {
	  /*Service has been suspended by client, outgoing packets must be corked*/
		qpp_cork();
		transmit_command("SS", NULL, 0);
		return;
	} else if (0 == strcmp(szCommand, "SG")) {
	  /*Service has been resumed by client, outgoing packets may now be sent*/
		qpp_uncork();
		return;
	} else if (0 == strcmp(szCommand, "MR")) {
	  /*User has moved to People Connection*/
		nQparseMode = 2;
      qmcp_sendjoin("");
		return;
	} else if (0 == strcmp(szCommand, "ML")) {
      /*User has moved to a non-chat area*/
      nQparseMode = 1;
      qmail_checkmail();
      qmenus_init();
      transmit_command("MC", NULL, 0);
	}

	/*Deal with any mode specific commands here*/
	if (nQparseMode == 0) {
	  qparse_login(szCommand, pPacketBuf + 2, nPacketLen-2);
	} else if (nQparseMode == 1) {
	  qparse_nonchat(szCommand, pPacketBuf + 2, nPacketLen-2);
	} else if (nQparseMode == 2) {
	  qparse_chat(szCommand, pPacketBuf + 2, nPacketLen-2);
	}
}

void qparse_init (void) {
  nQparseMode = 0;
}
