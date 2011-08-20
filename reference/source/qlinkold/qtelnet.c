#include <stdio.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <string.h>
#include <netdb.h>
#include <unistd.h>
#include <syslog.h>
#include <errno.h>

#include "qpacket.h"
#include "qio.h"
#include "qtelnet.h"

static int sock = 0;

void qtelnet_connect(char *pszHostName, unsigned short nPort) {
   struct sockaddr_in server;
   struct hostent *hp, *gethostbyname();

   /* Create socket */
   sock = socket(AF_INET, SOCK_STREAM, 0);
   if (sock < 0) {
      transmit_command("YB", "Cannot create socket.", 21);
      return;
   }

   server.sin_family = AF_INET;
   hp = gethostbyname(pszHostName);
   if (hp == 0) {
      transmit_command("YB", "Cannot get hostname.", 20);
      return;
   }
   bcopy((void *)hp->h_addr, (void *)&server.sin_addr, hp->h_length);
   server.sin_port = htons(nPort);

   if (connect(sock, (struct sockaddr *)&server, sizeof(server)) < 0) {
      transmit_command("YB", "Cannot connect socket.", 22);
      return;
   }

   qio_register_fd(sock, ssTelnet);
   transmit_command("YA", NULL, 0);
   transmit_command("YD", NULL, 0);
}

void qtelnet_close(void) {

   close(sock);
   qio_unregister_fd(sock);
}

void qtelnet_receive(void) {

   unsigned char ucReadBuf[100];
   int nGotChrs;
   int nCounter;

   nGotChrs = read(sock, ucReadBuf, 100);
   if (nGotChrs == -1) {
      syslog(LOG_NOTICE, "Read error encountered: %d", errno);
   }
   if (nGotChrs == 0) {
      syslog(LOG_NOTICE, "Connection to TCP service closed");
      transmit_command("YB", "Connection closed by foreign host.", 34);
      qtelnet_close();
   }

   for (nCounter = 0; nCounter < nGotChrs; nCounter++) {
      if (ucReadBuf[nCounter] == 13) {
         ucReadBuf[nCounter] = '!';
      } else if (ucReadBuf[nCounter] == 10) {
         ucReadBuf[nCounter] = 0x7f;
      }
   }
   transmit_command("YC", ucReadBuf, nGotChrs);
}

void qtelnet_transmit(char *pszOutStr) {

   pszOutStr[strlen(pszOutStr) + 1] = 0;
   pszOutStr[strlen(pszOutStr)] = 10;
   send(sock, pszOutStr, strlen(pszOutStr), 0);
}


