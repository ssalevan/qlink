#include <stdio.h>
#include <time.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <syslog.h>
#include <fcntl.h>
#include <string.h>
#include <errno.h>

#include "config.h"
#include "qfile.h"
#include "qpacket.h"

unsigned int nFileUniqueNum;

FILE* qfile_createunique(char* pszFileName) {

  int nFileDesc;
	char szTempFile[1024];
  time_t nCurTime;
	pid_t  nCurPID;

	nCurTime = time(NULL);
  nCurPID = getpid();
	nFileUniqueNum++;

	sprintf(szTempFile, "%016lX%08X%08X", nCurTime, nCurPID, nFileUniqueNum);
	syslog(LOG_INFO, "Creating unique file %s", szTempFile);
	strcpy(pszFileName, szTempFile);

	sprintf(szTempFile, "%s%016lX%08X%08X", DATA_DIR, nCurTime, nCurPID, nFileUniqueNum);

	nFileDesc = open(szTempFile, O_WRONLY | O_CREAT | O_EXCL, S_IRUSR | S_IWUSR);
   if (-1 == nFileDesc) {
      syslog(LOG_INFO, "Cannot create file: %d", errno);
      return NULL;
   } else {
      return fdopen(nFileDesc, "w");
   }
}

int qfile_dumpfile(char* pszFilename, char* pszNextCommand, char* pszLastCommand, int nLineLimit){
  FILE* fpMessageFile;
  char  szTempString[1024];
  char  szReadBuffer[128];
  char  szReadBuffer2[128];
  int   nNumLines;
	char* pBufferStatus;

  strcpy (szTempString, DATA_DIR);
  strncat (szTempString, pszFilename, 1024-strlen(szTempString));

  fpMessageFile = fopen(szTempString, "r");
  if (fpMessageFile == NULL) {
    return 0;
  }

  nNumLines = 0;
	pBufferStatus = fgets(szReadBuffer, 128, fpMessageFile);
  while (NULL != pBufferStatus) {
    szReadBuffer[40] = 0;
		strcpy(szReadBuffer2, szReadBuffer);
  	pBufferStatus = fgets(szReadBuffer, 128, fpMessageFile);
		if ((NULL == pBufferStatus) || (nNumLines == nLineLimit)) {
		  if (NULL != pszLastCommand) {
			  transmit_command(pszLastCommand, szReadBuffer2, strlen(szReadBuffer2));
			} else {
			  transmit_command(pszNextCommand, szReadBuffer2, strlen(szReadBuffer2));
			}
			break;
		} else {
      transmit_command(pszNextCommand, szReadBuffer2, strlen(szReadBuffer2));
    }
    nNumLines++;
  }
  fclose(fpMessageFile);

  if (nNumLines == 0) {
	  return 0;
  } else {
	  if (NULL == pszLastCommand) {
		  return 2;
    } else {
		  return 1;
    }
  }
}

int qfile_disptextfile(char* pszFilename) {
   FILE* fpMessageFile;
   char  bReadBuffer[128];
   char  bReadBuffer2[128];
   int   nNumLines;
   size_t nNumRead;
   size_t nNumRead2;
   int   nCounter;

   transmit_command("KC", NULL, 0);

   syslog(LOG_INFO, "Displaying file %s", pszFilename);

   fpMessageFile = fopen(pszFilename, "r");
   if (fpMessageFile == NULL) {
      transmit_command("KE", "Could not locate file.", 22);
      syslog(LOG_ERR, "Failed to open file with error number: %d", errno);
      return 0;
   }

   syslog(LOG_INFO, "Displaying file %s", pszFilename);

   nNumLines = 0;
   nNumRead = fread(bReadBuffer, 1, 100, fpMessageFile);
   while (0 != nNumRead) {
      for (nCounter = 0; nCounter < nNumRead; nCounter++) {
         if ('\n' == bReadBuffer[nCounter]) {
            bReadBuffer[nCounter] = 0x7f;
         }
      }
      memcpy(bReadBuffer2, bReadBuffer, nNumRead);
      nNumRead2 = nNumRead;
      nNumRead = fread(bReadBuffer, 1, 100, fpMessageFile);
		if (0 == nNumRead) {
         transmit_command("KE", bReadBuffer2, nNumRead2);
			break;
		} else {
         transmit_command("KD", bReadBuffer2, nNumRead2);
      }
      nNumLines++;
   }
   fclose(fpMessageFile);

   if (nNumLines == 0) {
      return 0;
   } else {
	   return 1;
   }
}

void qfile_init(void){

  nFileUniqueNum = 0;
};
