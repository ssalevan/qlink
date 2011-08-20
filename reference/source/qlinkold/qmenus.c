#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <syslog.h>

#include "config.h"
#include "qpacket.h"
#include "qfile.h"
#include "qtelnet.h"
#include "qmenus.h"

static struct qmenus_menulistitem *pMenuListHead = NULL;
static char szCurrentDir[4096];
unsigned int nCurrentItemID;

unsigned int b64toi(char *pszID) {
   unsigned int nTempConv;

   nTempConv = (((unsigned char)pszID[0] & 0x3F) << 18);
   nTempConv |= (((unsigned char)pszID[1] & 0x3F) << 12);
   nTempConv |= (((unsigned char)pszID[2] & 0x3F) << 6);
   nTempConv |= (((unsigned char)pszID[3] & 0x3F));

   return nTempConv;
}

char *itob64(unsigned int nID) {
   static char szTempNum[5];
   unsigned int nTempConv;

   nTempConv =  (nID & 0x00FC0000) << 6;
   nTempConv |= (nID & 0x0003F000) << 4;
   nTempConv |= (nID & 0x00000FC0) << 2;
   nTempConv |= (nID & 0x0000003F);
   nTempConv |= 0x40404040;

   szTempNum[0] = (nTempConv & 0xFF000000) >> 24;
   szTempNum[1] = (nTempConv & 0x00FF0000) >> 16;
   szTempNum[2] = (nTempConv & 0x0000FF00) >> 8;
   szTempNum[3] = (nTempConv & 0x000000FF);
   szTempNum[4] = 0;
   return szTempNum;
}

void transmit_menuitem(char *pszMenuText,
		       char *pszResource,
		       unsigned char nMenuCmd1,
		       unsigned char nMenuCmd2,
		       unsigned char nMenuCmd3,
		       int fLastItem) {

  unsigned char TempMenuBuf[1024];
  unsigned int  nMenuConvert;

  nMenuConvert = ((nMenuCmd1 & 0xFC) << 22);
  nMenuConvert |= (((nMenuCmd1 & 0x03) << 4) | ((nMenuCmd2 & 0xF0) >> 4))<<16;
  nMenuConvert |= (((nMenuCmd2 & 0x0F) << 2) | ((nMenuCmd3 & 0xC0) >> 6))<<8;
  nMenuConvert |= (nMenuCmd3 & 0x3F);

  nMenuConvert |= 0x40404040;

  TempMenuBuf[0] = 0x01;
  TempMenuBuf[5] = nMenuConvert >> 24;
  TempMenuBuf[6] = nMenuConvert >> 16;
  TempMenuBuf[7] = nMenuConvert >> 8;
  TempMenuBuf[8] = nMenuConvert & 0xFF;
  TempMenuBuf[9] = '\x90';

  strncpy(&TempMenuBuf[1], pszResource, 4);

  sprintf(&TempMenuBuf[10], "    %s", pszMenuText);

  if (fLastItem) {
    transmit_command("KB", TempMenuBuf, 14 + strlen(pszMenuText));
  } else {
    transmit_command("KA", TempMenuBuf, 14 + strlen(pszMenuText));
  }
}

void qmenus_fillmenu(int nMaxEntries, int fMainMenu) {
   struct qmenus_menulistitem *pTempListItem;
   DIR *pTempDir;
   struct dirent *pDirEnt;
   char szTempPath[4096];
   struct stat TempStat;

   pTempDir = opendir(szCurrentDir);
   if (NULL == pTempDir) {
      syslog(LOG_ERR, "Cannot open %s", szCurrentDir);
      return;
   }

   pTempListItem = (struct qmenus_menulistitem *) malloc(sizeof(struct qmenus_menulistitem));
   pTempListItem->nNumEntries = 0;

   while (NULL != (pDirEnt = readdir(pTempDir))) {
      if (pDirEnt->d_name[0] == '.') continue;
      strncpy(pTempListItem->szItemName[pTempListItem->nNumEntries], pDirEnt->d_name, 40);
      strcpy(szTempPath, szCurrentDir);
      strcat(szTempPath, pDirEnt->d_name);
      if (0 != stat(szTempPath, &TempStat)) {
         syslog(LOG_ERR, "Cannot stat %s", szTempPath);
         return;
      }
      if (S_ISDIR(TempStat.st_mode)) {
         pTempListItem->ItemType[pTempListItem->nNumEntries] = qmtMenu;
      } else {
         pTempListItem->ItemType[pTempListItem->nNumEntries] = qmtTextfile;
      }

      nCurrentItemID++;
      strcpy(pTempListItem->szItemID[pTempListItem->nNumEntries], itob64(nCurrentItemID));

      pTempListItem->nNumEntries = pTempListItem->nNumEntries + 1;

      if (pTempListItem->nNumEntries == (nMaxEntries - 1)) {
         nMaxEntries++;
         break;
      }
   }

   if (fMainMenu) {
      strcpy(pTempListItem->szItemName[pTempListItem->nNumEntries], "File upload");
      nCurrentItemID++;
      strcpy(pTempListItem->szItemID[pTempListItem->nNumEntries], itob64(nCurrentItemID));
      pTempListItem->ItemType[pTempListItem->nNumEntries] = qmtFileArea;
      pTempListItem->nNumEntries = pTempListItem->nNumEntries + 1;
      strcpy(pTempListItem->szItemName[pTempListItem->nNumEntries], "Q-Link post office");
      nCurrentItemID++;
      strcpy(pTempListItem->szItemID[pTempListItem->nNumEntries], itob64(nCurrentItemID));
      pTempListItem->ItemType[pTempListItem->nNumEntries] = qmtPostoffice;
      pTempListItem->nNumEntries = pTempListItem->nNumEntries + 1;
      strcpy(pTempListItem->szItemName[pTempListItem->nNumEntries], "Move to another Q-Link area");
      nCurrentItemID++;
      strcpy(pTempListItem->szItemID[pTempListItem->nNumEntries], itob64(nCurrentItemID));
      pTempListItem->ItemType[pTempListItem->nNumEntries] = qmtAreamenu;
      pTempListItem->nNumEntries = pTempListItem->nNumEntries + 1;
   }

   pTempListItem->pNext = pMenuListHead;
   pMenuListHead = pTempListItem;

   closedir(pTempDir);

}

/*Send out the menu at the top of the list */
void qmenus_rendermenu(void) {
   int nCounter;
   int fLastFlag = 0;

   for (nCounter = 0; nCounter < pMenuListHead->nNumEntries; nCounter++) {
      if (nCounter == pMenuListHead->nNumEntries - 1) {
         fLastFlag = 1;
      }
      if (pMenuListHead->ItemType[nCounter] == qmtMenu) {
         transmit_menuitem(pMenuListHead->szItemName[nCounter], pMenuListHead->szItemID[nCounter], 0x81, 0x00, 0x0E, fLastFlag);
      } else if (pMenuListHead->ItemType[nCounter] == qmtTextfile) {
         transmit_menuitem(pMenuListHead->szItemName[nCounter], pMenuListHead->szItemID[nCounter], 0x82, 0x00, 0x0E, fLastFlag);
      } else if (pMenuListHead->ItemType[nCounter] == qmtPostoffice) {
         transmit_menuitem(pMenuListHead->szItemName[nCounter], pMenuListHead->szItemID[nCounter], 0x87, 0x00, 0x0E, fLastFlag);
      } else if (pMenuListHead->ItemType[nCounter] == qmtAreamenu) {
         transmit_menuitem(pMenuListHead->szItemName[nCounter], pMenuListHead->szItemID[nCounter], 0x86, 0x00, 0x0E, fLastFlag);
      } else if (pMenuListHead->ItemType[nCounter] == qmtTelnet) {
         transmit_menuitem(pMenuListHead->szItemName[nCounter], pMenuListHead->szItemID[nCounter], 0x85, 0x00, 0x0E, fLastFlag);
      } else if (pMenuListHead->ItemType[nCounter] == qmtFileArea) {
         transmit_menuitem(pMenuListHead->szItemName[nCounter], pMenuListHead->szItemID[nCounter], 0x8D, 0x00, 0x0E, fLastFlag);
      }
   }
}

void qmenus_itemselect(char *pszItemID) {
   struct qmenus_menulistitem *pTempListItem;
   int nCounter;
   char *pszTemp;
   char szTempString[4096];

   if (NULL == pMenuListHead) {
      syslog(LOG_ERR, "No menu list was available.");
      return;
   }

   while (NULL != pMenuListHead) {
      for (nCounter = 0; nCounter < (pMenuListHead->nNumEntries); nCounter++) {
         if (0 == strncmp(pszItemID, pMenuListHead->szItemID[nCounter], 4)) {
            /* Found a match for what the user wants */
            if (pMenuListHead->ItemType[nCounter] == qmtMenu) {
               syslog(LOG_INFO, "User selected menu %s", pMenuListHead->szItemName[nCounter]);
//               nCurrentItemID = b64toi(pMenuListHead->szItemID[pMenuListHead->nNumEntries - 1]);
               strcat(szCurrentDir, pMenuListHead->szItemName[nCounter]);
               strcat(szCurrentDir, "/");
               if (pMenuListHead->pNext == NULL) {
                  qmenus_fillmenu(7, 1);
               } else {
                  qmenus_fillmenu(10, 0);
               }
               qmenus_rendermenu();
            } else if (pMenuListHead->ItemType[nCounter] == qmtTextfile) {
               strcpy(szTempString, szCurrentDir);
               strcat(szTempString, pMenuListHead->szItemName[nCounter]);
               qfile_disptextfile(szTempString);
            } else if (pMenuListHead->ItemType[nCounter] == qmtTelnet) {
               qtelnet_connect("muck.furry.org", 8888);
            }
            return;
         }
      }
      if (NULL != pMenuListHead->pNext) {
         /* If we're not at the virtualroot, step up one menu, otherwise log an error */
         szCurrentDir[strlen(szCurrentDir) - 1] = 0;
         pszTemp = strrchr(szCurrentDir, '/');
         pszTemp++;
         pszTemp[0] = 0;
         pTempListItem = pMenuListHead;
         pMenuListHead = pMenuListHead->pNext;
         free(pTempListItem);
      } else {
         syslog(LOG_ERR, "Client menu request could not be satisfied.");
         return;
      }
   }
}

void qmenus_init(void) {
   struct qmenus_menulistitem *pTempListItem;

   /*If there is something on the list, delete it*/
   while (NULL != pMenuListHead) {
      pTempListItem = pMenuListHead;
      pMenuListHead = pMenuListHead->pNext;
      free(pTempListItem);
   }

   sprintf(szCurrentDir, "%smenudata/", DATA_DIR);

   pTempListItem = (struct qmenus_menulistitem *) malloc(sizeof(struct qmenus_menulistitem));
   pTempListItem->nNumEntries = 7;
   strcpy(pTempListItem->szItemID[0], "@@@I");
   strcpy(pTempListItem->szItemName[0], "cin");
   pTempListItem->ItemType[0] = qmtMenu;
   strcpy(pTempListItem->szItemID[1], "@@@G");
   strcpy(pTempListItem->szItemName[1], "lc");
   pTempListItem->ItemType[1] = qmtMenu;
   strcpy(pTempListItem->szItemID[2], "@@@H");
   strcpy(pTempListItem->szItemName[2], "nai");
   pTempListItem->ItemType[2] = qmtMenu;
   strcpy(pTempListItem->szItemID[3], "@@@B");
   strcpy(pTempListItem->szItemName[3], "tm");
   pTempListItem->ItemType[3] = qmtMenu;
   strcpy(pTempListItem->szItemID[4], "@@@D");
   strcpy(pTempListItem->szItemName[4], "csc");
   pTempListItem->ItemType[4] = qmtMenu;
   strcpy(pTempListItem->szItemID[5], "@@@F");
   strcpy(pTempListItem->szItemName[5], "jff");
   pTempListItem->ItemType[5] = qmtMenu;
   strcpy(pTempListItem->szItemID[6], "@@@E");
   strcpy(pTempListItem->szItemName[6], "css");
   pTempListItem->ItemType[6] = qmtMenu;
   pTempListItem->pNext = NULL;

   pMenuListHead = pTempListItem;

   nCurrentItemID = 1024;
}


