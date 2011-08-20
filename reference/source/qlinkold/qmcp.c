#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <string.h>
#include <syslog.h>
#include <netdb.h>

#include "qpacket.h"
#include "qio.h"

int sock;
char szClientBuffer[4096];
int nBufferSize;
int nOlmStatus;

int qmcp_connect(char *pszHostName, unsigned short nPort) {
   struct sockaddr_in server;
   struct hostent *hp, *gethostbyname();

   /* Create socket */
   sock = socket(AF_INET, SOCK_STREAM, 0);
   if (sock < 0) {
      syslog(LOG_ERR, "Cannot create MCP socket.\n");
      return 0;
   }

   server.sin_family = AF_INET;
   hp = gethostbyname(pszHostName);
   if (hp == 0) {
      syslog(LOG_ERR, "Cannot get MCP hostname.\n");
      return 0;
   }
   bcopy((void *)hp->h_addr, (void *)&server.sin_addr, hp->h_length);
   server.sin_port = htons(nPort);

   if (connect(sock, (struct sockaddr *)&server, sizeof(server)) < 0) {
      syslog(LOG_ERR, "Cannot connect MCP socket.\n");
      return 0;
   }

   qio_register_fd(sock, ssQMCP);
   return 1;
}

void qmcp_close(void) {

   close(sock);
   qio_unregister_fd(sock);
}

void qmcp_clientcommand(char *pszCommand){

   char szTempStr[4096];
   char *pszComTokn;
   char *pszComParam1;
   char *pszComParam2;
   char *pszComParam3;

   syslog(LOG_INFO, "Received: %s", pszCommand);
   pszComTokn = strtok(pszCommand, "|");
   if (0 == strncmp(pszComTokn, "OLM", 4096)) {
      pszComParam1 = strtok(NULL, "|");
      pszComParam2 = strtok(NULL, "|");
      if ((NULL != pszComParam1) && (NULL != pszComParam2)) {
         if ('1' == pszComParam2[0]) {
            sprintf(szTempStr, "ONLMESSAGE\x90%s", pszComParam1);
            transmit_command("OE", szTempStr, strlen(szTempStr));
            nOlmStatus = 0;
         } else {
            if (0 == nOlmStatus) {
               sprintf(szTempStr, "ONLMESSAGE");
               transmit_command("ON", szTempStr, strlen(szTempStr));
               nOlmStatus = 1;
            }
            sprintf(szTempStr, "ONLMESSAGE\x90%s", pszComParam1);
            transmit_command("OM", szTempStr, strlen(szTempStr));
         }
      }
   } else if (0 == strncmp(pszComTokn, "JOIN", 4096)) {
      pszComParam1 = strtok(NULL, "|");
      transmit_command("CM", pszComParam1, strlen(pszComParam1));
   } else if (0 == strncmp(pszComTokn, "ARRIVE", 4096)) {
      pszComParam1 = strtok(NULL, "|");
      pszComParam2 = strtok(NULL, "|");
      pszComParam3 = strtok(NULL, "|");
      szTempStr[0] = atoi(pszComParam2);
      szTempStr[1] = 0;
      strcat(szTempStr, pszComParam3);
      if (0 == atoi(pszComParam1)) {
         transmit_command("CL", szTempStr, strlen(szTempStr));
      } else {
         transmit_command("CE", szTempStr, strlen(szTempStr));
      }
   } else if (0 == strncmp(pszComTokn, "ENTER", 4096)) {
      pszComParam1 = strtok(NULL, "|");
      pszComParam2 = strtok(NULL, "|");
      szTempStr[0] = atoi(pszComParam1);
      szTempStr[1] = 0;
      strcat(szTempStr, pszComParam2);
      transmit_command("CA", szTempStr, strlen(szTempStr));
   } else if (0 == strncmp(pszComTokn, "LEAVE", 4096)) {
      pszComParam1 = strtok(NULL, "|");
      pszComParam2 = strtok(NULL, "|");
      szTempStr[0] = atoi(pszComParam1);
      szTempStr[1] = 0;
      strcat(szTempStr, pszComParam2);
      transmit_command("CB", szTempStr, strlen(szTempStr));
   } else if (0 == strncmp(pszComTokn, "TALK", 4096)) {
      pszComParam1 = strtok(NULL, "|");
      pszComParam2 = strtok(NULL, "|");
      szTempStr[0] = atoi(pszComParam1);
      szTempStr[1] = 0;
      strcat(szTempStr, pszComParam2);
      transmit_command("AA", szTempStr, strlen(szTempStr));
   } else if (0 == strncmp(pszComTokn, "BACK", 4096)) {
      qpacket_back();
   } else if (0 == strncmp(pszComTokn, "SND", 4096)) {
      pszComParam1 = strtok(NULL, "|");
      pszComParam2 = strtok(NULL, "|");
      if ((NULL != pszComParam1) && (NULL != pszComParam2)) {
         transmit_command(pszComParam1, pszComParam2, strlen(pszComParam2));
      }
   }
}

void qmcp_receive(void) {

   int nCharsRead;
   char *pszTemp;

   nCharsRead = recv(sock, &szClientBuffer[nBufferSize], 4096 - nBufferSize, 0);
   if (-1 == nCharsRead) {
      syslog(LOG_ERR, "Error reading from qmcp socket.\n");
      exit(1);
   }

   if (0 == nCharsRead) {
      close(sock);
      qio_unregister_fd(sock);
   }

   nBufferSize += nCharsRead;
   pszTemp = (char *)strchr(szClientBuffer, '\n');
   while (NULL != pszTemp) {
      *pszTemp = 0;
      if ('\r' == *(pszTemp - 1)) {
         *(pszTemp - 1) = 0;
      }
      qmcp_clientcommand(szClientBuffer);
      nBufferSize -= ((pszTemp - szClientBuffer) + 1);
      memmove(szClientBuffer, pszTemp + 1, nBufferSize);
      pszTemp = (char *)strchr(szClientBuffer, '\n');
   }
}

void qmcp_blockreceive(char *pszCommand) {

   int nCharsRead;
   char *pszTemp;

   nCharsRead = recv(sock, &szClientBuffer[nBufferSize], 4096 - nBufferSize, 0);

   if (-1 == nCharsRead) {
      syslog(LOG_ERR, "Error reading from qmcp socket.\n");
      exit(1);
   }

   if (0 == nCharsRead) {
      close(sock);
      qio_unregister_fd(sock);
   }

   nBufferSize += nCharsRead;
   pszTemp = (char *)strchr(szClientBuffer, '\n');
   while (NULL != pszTemp) {
      *pszTemp = 0;
      if ('\r' == *(pszTemp - 1)) {
         *(pszTemp - 1) = 0;
      }
      strncpy(pszCommand, szClientBuffer, 4096);
      nBufferSize -= ((pszTemp - szClientBuffer) + 1);
      memmove(szClientBuffer, pszTemp, nBufferSize);
      pszTemp = (char *)strchr(szClientBuffer, '\n');
   }
}

void qmcp_transmit(char *pszOutStr) {

   pszOutStr[strlen(pszOutStr) + 1] = 0;
   pszOutStr[strlen(pszOutStr)] = 10;
   send(sock, pszOutStr, strlen(pszOutStr), 0);
}

int qmcp_connectuser(char *pszScreenName) {
   char szComResp[4096];
   char *pszComTokn;
   char *pszComParam1;

   if (0 == qmcp_connect("localhost", 8888)) {
      return 0;
   }
   sprintf(szComResp, "CONNECT|%s", pszScreenName);
   qmcp_transmit(szComResp);
   while(1) {
      qmcp_blockreceive(szComResp);
      syslog(LOG_INFO, "Received: %s", szComResp);
      pszComTokn = strtok(szComResp, "|");
      if (0 == strncmp(pszComTokn, "CONNECT", 4096)) {
         pszComParam1 = strtok(NULL, "|");
         if (0 == strncmp(pszComParam1, "OK", 4096)) {
            return 1;
         } else {
            return 0;
         }
      }
   }
}

void qmcp_sendjoin(char *pszRoomName) {
   char szTempStr[4096];

   if (NULL == pszRoomName) {
      sprintf(szTempStr, "JOIN");
   } else {
      sprintf(szTempStr, "JOIN|%s", pszRoomName);
   }
   qmcp_transmit(szTempStr);
}

void qmcp_sendtalk(char *pszMessage) {
   char szTempStr[4096];

   sprintf(szTempStr, "TALK|%s", pszMessage);
   qmcp_transmit(szTempStr);
}

int qmcp_useronline(char *pszScreenName) {
   char szComResp[4096];
   char *pszComTokn;
   char *pszComParam1;

   sprintf(szComResp, "ONLINE|%s", pszScreenName);
   qmcp_transmit(szComResp);
   while(1) {
      qmcp_blockreceive(szComResp);
      syslog(LOG_INFO, "Received: %s", szComResp);
      pszComTokn = strtok(szComResp, "|");
      if (0 == strncmp(pszComTokn, "ONLINE", 4096)) {
         pszComParam1 = strtok(NULL, "|");
         if (0 == strncmp(pszComParam1, "OK", 4096)) {
            return 1;
         } else {
            return 0;
         }
      }
   }
}

void qmcp_sendolm(char *pszScreenName, char *pszMsgTxt, int nLastLine) {
   char szComResp[4096];

   sprintf(szComResp, "OLM|%s|%s|%d", pszScreenName, pszMsgTxt, nLastLine);
   qmcp_transmit(szComResp);
}
