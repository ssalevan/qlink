#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <termios.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/time.h>
#include <sys/socket.h>
#include <errno.h>
#include <netinet/in.h>
#include <string.h>
#include <netdb.h>

#define BAUDRATE B300
#define MODEMDEVICE "/dev/ttyS0"
#define FALSE 0
#define TRUE 1

volatile int STOP=FALSE;

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
      nHadChrs = nFoundChrs;
      for (nCounter = 0; nCounter < nGotChrs; nCounter++) {
         printf("Gotchar '%c'\n", szReadBuf[nCounter]);
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
  int fd;
  struct termios oldtio,newtio;
  int nBlocks;

   fd = open(MODEMDEVICE, O_RDWR | O_NOCTTY );
   if (fd <0) {perror(MODEMDEVICE); exit(-1); }

   tcgetattr(fd,&oldtio); /* save current port settings */

   bzero(&newtio, sizeof(newtio));
   newtio.c_cflag = BAUDRATE | CS8 | CLOCAL | CREAD;
   newtio.c_iflag = IGNPAR;
   newtio.c_oflag = 0;

 /* set input mode (non-canonical, no echo,...) */
   newtio.c_lflag = 0;

   newtio.c_cc[VTIME]    = 0;   /* inter-character timer unused */
   newtio.c_cc[VMIN]     = 1;   /* blocking read until 1 chars received */

   tcflush(fd, TCIFLUSH);
   tcsetattr(fd,TCSANOW,&newtio);


  nReadFD = fd;
  nWriteFD = fd;

  printf("Starting...\n");
  nBlocks = 0;
  while (1) {
   write(nWriteFD, "1234567890", 10);
   expect("1234567890");
   nBlocks++;
   printf("%d blocks processed.\n", nBlocks);
   //sleep(1);
  }
  exit(0);
}


