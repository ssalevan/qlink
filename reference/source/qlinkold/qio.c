#include <stdio.h>
#include <stdlib.h>

#include "qpacket.h"
#include "qtelnet.h"
#include "qmcp.h"
#include "qio.h"

struct QioEntry {
   int fd;
   enum SubSystem subsystem;
   struct QioEntry *pNext;
   struct QioEntry *pPrev;
};

static struct QioEntry *pQioList = NULL;

void qio_register_fd(int fd, enum SubSystem subsystem) {
   struct QioEntry *pTemp;

   if (NULL == pQioList) {
      pQioList = (struct QioEntry *)malloc (sizeof(struct QioEntry));
      pQioList->fd = fd;
      pQioList->subsystem = subsystem;
      pQioList->pNext = NULL;
      pQioList->pPrev = NULL;
   } else {
      pTemp = (struct QioEntry *)malloc (sizeof(struct QioEntry));
      pTemp->fd = fd;
      pTemp->subsystem = subsystem;
      pTemp->pPrev = pQioList;
      pTemp->pPrev->pNext = pTemp;
      pTemp->pNext = NULL;
   }
}

void qio_unregister_fd(int fd) {
   struct QioEntry *pTemp = pQioList;

   while (NULL != pTemp) {
      if (fd == pTemp->fd) {
         if (NULL == pTemp->pPrev) {
            pTemp->pNext->pPrev = NULL;
            pQioList = pTemp->pNext;
            free(pTemp);
            return;
         } else {
            pTemp->pPrev->pNext = pTemp->pNext;
            if (NULL != pTemp->pNext) {
               pTemp->pNext->pPrev = pTemp->pPrev;
            }
            free(pTemp);
            return;
         }
      }
      pTemp = pTemp->pNext;
   }

}

void qio_process_fds(void) {

   struct QioEntry *pTemp = pQioList;
   int nMaxFD = 0;
   fd_set rdfs;
   struct timeval tv;

   FD_ZERO(&rdfs);

   while (NULL != pTemp) {
      FD_SET(pTemp->fd, &rdfs);
      if (pTemp->fd > nMaxFD) {
         nMaxFD = pTemp->fd;
      }
      pTemp = pTemp->pNext;
   }

   tv.tv_sec = 5;
   tv.tv_usec = 0;

   if (select(nMaxFD + 1, &rdfs, NULL, NULL, &tv)) {
      pTemp = pQioList;
      while (NULL != pTemp) {
         if (FD_ISSET(pTemp->fd, &rdfs)) {
            switch (pTemp->subsystem) {
            case ssPacket:
               qpp_receivepacket();
               break;
            case ssTelnet:
               qtelnet_receive();
               break;
            case ssQMCP:
               qmcp_receive();
            }
         }
         pTemp = pTemp->pNext;
      }
   } else {
      /* Timeout handler */
   }
}
