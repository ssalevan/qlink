/***************************************************************************
                          managers.cpp  -  description
                             -------------------
    begin                : Sat Dec 8 2001
    copyright            : (C) 2001 by Keith Henrickson
    email                : flipper@phin.com
 ***************************************************************************/

#include <stdio.h>
#include <string.h>
#include "dbllinklist.h"
#include "dbllinklistitem.h"
#include "dbaccess.h"
#include "quser.h"
#include "qroom.h"
DBAccess* pDBManager;
DblLinkList<QUser*> lUserList;
DblLinkList<QRoom*> lRoomList;

 /** Add a user object to the list of online users */
void AddUserList(QUser*pUser){
	DblLinkListItem<QUser*>* pItem = new DblLinkListItem<QUser*>;
	
	pItem->Item = pUser;
	lUserList.AddItem(pItem);
}
/** Deletes a user object from the list of online users */
void DelUserList(QUser* pUser){
	DblLinkListItem<QUser*>* pItem = lUserList.GetHead();
	
	while(NULL != pItem) {
		if (pItem->Item == pUser) {
			lUserList.DeleteItem(pItem);
			break;
		}
		pItem = pItem->pNext;
	}
}

QUser* FindUserByScreenName(char* pszScreenName) {
	DblLinkListItem<QUser*>* pItem = lUserList.GetHead();
	
	while (NULL != pItem) {
		if (0 == strcmp(pItem->Item->GetScreenName(), pszScreenName)) {
			return pItem->Item;
		}
		pItem = pItem->pNext;
	}
	return NULL;
}

QUser* FindUserByUserID(char* pszUserID) {
	DblLinkListItem<QUser*>* pItem = lUserList.GetHead();
	
	while (NULL != pItem) {
		if (0 == strcmp(pItem->Item->GetUserID(), pszUserID)) {
			return pItem->Item;
		}
		pItem = pItem->pNext;
	}
	return NULL;
}

QUser* FindUserByMasterUID(char* pszMasterUID) {
	DblLinkListItem<QUser*>* pItem = lUserList.GetHead();
	
	while (NULL != pItem) {
		if (0 == strcmp(pItem->Item->GetMasterUID(), pszMasterUID)) {
			return pItem->Item;
		}
		pItem = pItem->pNext;
	}
	return NULL;
}

// Finds a free lobby room, joins us to the lobby, and returns a pointer for further communication
// If there is no lobby, create a new one
QRoom* JoinFreeLobby(QUser* pThisUser) {
	DblLinkListItem<QRoom*>* pItem = lRoomList.GetHead();
	
	while (NULL != pItem) {
		//TODO: Be more creative.  Really, any room starting with lobby matches
		//But, that could slow down creating a lobby.  For now, just have one lobby
		if (0 == strcmp(pItem->Item->GetRoomName(), "Lobby")) {
			pItem->Item->JoinRoom(pThisUser, true);
			return pItem->Item;
		}
		pItem = pItem->pNext;
	}
	// And if there is no such room, create a new one
	QRoom* pTempRoom = new QRoom("Lobby", false);
	DblLinkListItem<QRoom*>* pTempItem = new DblLinkListItem<QRoom*>;
	
	pTempRoom->JoinRoom(pThisUser, true);
	pTempItem->Item = pTempRoom;
	lRoomList.AddItem(pTempItem);
	return pTempRoom;
}

QRoom* JoinRoom(QUser* pThisUser, bool fPrivateRoom, char* pszRoomName, int nLen) {
	DblLinkListItem<QRoom*>* pItem = lRoomList.GetHead();
	char szRoomName[11];
	
	memset(szRoomName, 0, 11);
	strncpy(szRoomName, pszRoomName, nLen);
	while (NULL != pItem) {
		if (0 == strcmp(pItem->Item->GetRoomName(), szRoomName)) {
			if ((fPrivateRoom) && (false == pItem->Item->IsPrivate())){
				// We're searching for a private room and found a public one
				pThisUser->TransmitCommand("C3", NULL, 0);
				return NULL;
			} else if ((!fPrivateRoom) && (true == pItem->Item->IsPrivate())) {
				pItem->Item->MakePublic();
				pItem->Item->JoinRoom(pThisUser, true);
				return pItem->Item;
			} else {
				pItem->Item->JoinRoom(pThisUser, true);
				return pItem->Item;
			}
		}
		pItem = pItem->pNext;
	}
	// And if there is no such room, create a new one
	QRoom* pTempRoom = new QRoom(szRoomName, fPrivateRoom);
	DblLinkListItem<QRoom*>* pTempItem = new DblLinkListItem<QRoom*>;
	
	pTempRoom->JoinRoom(pThisUser, true);
	pTempItem->Item = pTempRoom;
	lRoomList.AddItem(pTempItem);
	return pTempRoom;
}

/** Deletes a room object from the list of active rooms */
void DelRoomList(QRoom* pRoom){
	DblLinkListItem<QRoom*>* pItem = lRoomList.GetHead();
	
	while(NULL != pItem) {
		if (pItem->Item == pRoom) {
			lRoomList.DeleteItem(pItem);
			break;
		}
		pItem = pItem->pNext;
	}
}

