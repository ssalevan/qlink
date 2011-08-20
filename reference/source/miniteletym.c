#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/time.h>
#include <sys/socket.h>
#include <errno.h>
#include <netinet/in.h>
#include <string.h>
#include <netdb.h>

#define FALSE 0
#define TRUE 1

volatile int STOP=FALSE;

FILE *fpLogFile;

int nReadFD = 0;
int nWriteFD = 0;
int sd = 0;

void expect(char* pszExpectStr) {

  char szFoundStr[1024];
  char szReadBuf[1024];
  int nFoundChrs;
  int nGotChrs;
  int nHadChrs;
  int nCounter;

  szFoundStr[0] = 0;
  nFoundChrs = 0;

  while (nFoundChrs < strlen(pszExpectStr)) {
    nGotChrs = read(nReadFD, szReadBuf, 1024);
    if (nGotChrs > 0) {
      fprintf(fpLogFile, "Read %d chars\n",nGotChrs);
      fflush(fpLogFile);
    }
    nHadChrs = nFoundChrs;
    for (nCounter = 0; nCounter < nGotChrs; nCounter++) {
	   fprintf(fpLogFile, "nCounter = %d szReadBuf[nCounter] = %c pszExpectStr[nHadChrs+nCounter] = %c\n", nCounter, szReadBuf[nCounter], pszExpectStr[nHadChrs+nCounter]);
      fflush(fpLogFile);
		if (szReadBuf[nCounter] == pszExpectStr[nHadChrs+nCounter]) {
	nFoundChrs++;
      } else {
	nFoundChrs = 0;
	continue;
      }
    }
  }
}

int main() {

  struct  sockaddr_in server;
  struct  hostent* hp;
  fd_set  fsReceive;
  unsigned char ucLocalBuffer[8192];
  unsigned char ucRemoteBuffer[8192];
  int nLocalBufSize;
  int nRemoteBufSize;

  nReadFD = STDIN_FILENO;
  nWriteFD = STDOUT_FILENO;
  fpLogFile = fopen("miniteletym.log", "a+");

  fprintf(fpLogFile, "Starting...\n");
  fflush(fpLogFile);
  sleep(1);
  write(nWriteFD, "IDENTIFIER", 10);
  expect("A");
  fprintf(fpLogFile, "Found A\n");
  fflush(fpLogFile);
  write(nWriteFD, "\xBA", 1);
  expect("QUANTUMLINK\x0D");
  fprintf(fpLogFile, "Found QUANTUMLINK\n");
  fflush(fpLogFile);
  write(nWriteFD, "\xBA", 1);
  expect("link up\x0D");
  fprintf(fpLogFile, "Found link up\n");
  fflush(fpLogFile);
  write(nWriteFD, "+", 1);
  expect("id=play\x0D");
  fprintf(fpLogFile, "Found id=play\n");
  fflush(fpLogFile);

  fprintf(fpLogFile, "Connecting to server...\n");

  sd = socket (PF_INET,SOCK_STREAM,0);

  server.sin_family = AF_INET;
  hp = gethostbyname("localhost");
  bcopy ( hp->h_addr, &(server.sin_addr.s_addr), hp->h_length);
  server.sin_port = htons(8888);
  if (connect(sd, (struct sockaddr *)&server, sizeof(server)) == -1) {
        fprintf(fpLogFile, "Error %d: %s\n", errno, strerror(errno));
	while(TRUE){};
  }else{
	  fprintf(fpLogFile, "Connected..\n");
    fclose(fpLogFile);
    while (1) {
	    FD_ZERO(&fsReceive);
   	  FD_SET(STDIN_FILENO, &fsReceive);
      FD_SET(sd, &fsReceive);
      select(sd + 1, &fsReceive, NULL, NULL, NULL);
	    if (FD_ISSET(STDIN_FILENO, &fsReceive)){
        nLocalBufSize = read(nReadFD, ucLocalBuffer, 8192);
				if (nLocalBufSize == 0){
				  exit(0);
				}
        send(sd, ucLocalBuffer, nLocalBufSize, 0);
	    }
		  if (FD_ISSET(sd, &fsReceive)){
		    nRemoteBufSize = recv(sd, ucRemoteBuffer, 8192, 0);
		    write(nWriteFD, ucRemoteBuffer, nRemoteBufSize);
		  }
	  }
  }

  exit(0);
}


