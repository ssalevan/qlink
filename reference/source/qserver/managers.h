/***************************************************************************
                          managers.h  -  description
                             -------------------
    begin                : Sat Dec 8 2001
    copyright            : (C) 2001 by Keith Henrickson
    email                : flipper@phin.com
 ***************************************************************************/

// This is the pointer to the database manager.  Anyone may use it
extern DBAccess* pDBManager;
void AddUserList(QUser* pUser);
void DelUserList(QUser* pUser);
QUser* FindUserByScreenName(char* pszScreenName);
QUser* FindUserByUserID(char* pszUserID);
QUser* FindUserByMasterUID(char* pszMasterUID);
QRoom* JoinFreeLobby(QUser* pThisUser);
QRoom* JoinRoom(QUser* pThisUser, bool fPrivateRoom, char* pszRoomName, int nLen);
void DelRoomList(QRoom* pRoom);



