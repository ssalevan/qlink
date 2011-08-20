/***************************************************************************
                          tcpmanager.cpp  -  description
                             -------------------
    begin                : Thu Nov 29 2001
    copyright            : (C) 2001 by Keith Henrickson
    email                : flipper@phin.com
 ***************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <sys/types.h>
#include <unistd.h>
#include "dbllinklist.h"
#include "dbllinklistitem.h"
#include "tcpconnection.h"
#include "tcplistener.h"
#include "tcpmanager.h"

TCPManager::TCPManager(){
}
TCPManager::~TCPManager(){
}
/** This function will process any incoming connections as well as any incoming or outgoing data. */
void TCPManager::Manage(){
	struct timeval tv;
	fd_set fdSocks;
	int nHighSock = 0;
	DblLinkListItem<TCPConnection*>* pDataSocks;
	DblLinkListItem<TCPListener*>* pListenSocks;
	
	FD_ZERO(&fdSocks);

	pListenSocks = lLstnSocketList.GetHead();
	while (NULL != pListenSocks) {
		FD_SET(pListenSocks->Item->GetFD(), &fdSocks);
		if (pListenSocks->Item->GetFD() > nHighSock) {
			nHighSock = pListenSocks->Item->GetFD();
		}
		pListenSocks = pListenSocks->pNext;
	}
	pDataSocks = lDataSocketList.GetHead();
	while (NULL != pDataSocks) {
		FD_SET(pDataSocks->Item->GetFD(), &fdSocks);
		if (pDataSocks->Item->GetFD() > nHighSock) {
			nHighSock = pDataSocks->Item->GetFD();
		}
		pDataSocks = pDataSocks->pNext;
	}
	tv.tv_sec = 5;
	tv.tv_usec = 0;
	select(nHighSock + 1, &fdSocks, NULL, NULL, &tv);
	pListenSocks = lLstnSocketList.GetHead();
	while (NULL != pListenSocks) {
		if (FD_ISSET(pListenSocks->Item->GetFD(), &fdSocks)) {
			pListenSocks->Item->Accept();
		}
		pListenSocks = pListenSocks->pNext;
	}
	pDataSocks = lDataSocketList.GetHead();
	while (NULL != pDataSocks) {
		if (FD_ISSET(pDataSocks->Item->GetFD(), &fdSocks)) {
			pDataSocks->Item->Receive();
		}
		pDataSocks = pDataSocks->pNext;
	}
	
}
/** No descriptions */
void TCPManager::AddDataList(TCPConnection*pConn){
	DblLinkListItem<TCPConnection*>* pItem = new DblLinkListItem<TCPConnection*>;
	
	pItem->Item = pConn;
	lDataSocketList.AddItem(pItem);
}
/** No descriptions */
void TCPManager::DelDataList(TCPConnection*pConn){
	DblLinkListItem<TCPConnection*>* pItem = lDataSocketList.GetHead();
	
	while(NULL != pItem) {
		if (pItem->Item == pConn) {
			lDataSocketList.DeleteItem(pItem);
			break;
		}
		pItem = pItem->pNext;
	}
}
/** No descriptions */
void TCPManager::AddLstnList(TCPListener*pConn){
	DblLinkListItem<TCPListener*>* pItem = new DblLinkListItem<TCPListener*>;
	
	pItem->Item = pConn;
	lLstnSocketList.AddItem(pItem);
}
/** No descriptions */
void TCPManager::DelLstnList(TCPListener*pConn){
	DblLinkListItem<TCPListener*>* pItem = lLstnSocketList.GetHead();
	
	while(NULL != pItem) {
		if (pItem->Item == pConn) {
			lLstnSocketList.DeleteItem(pItem);
			break;
		}
		pItem = pItem->pNext;
	}
}
