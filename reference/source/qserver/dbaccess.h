/***************************************************************************
                          dbaccess.h  -  description
                             -------------------
    begin                : Sat Dec 8 2001
    copyright            : (C) 2001 by Keith Henrickson
    email                : flipper@phin.com
 ***************************************************************************/

#ifndef DBACCESS_H
#define DBACCESS_H

#include <mysql.h>

/**This class mediates access to the database
  *@author Keith Henrickson
  */

enum SearchKey {
	skSCREEN_NAME,
	skUSER_ID,
};

enum AccountType {
	atNEW_DISK,
	atNORMAL,
	atDEMO,
	atDISABLED,
};

struct UserDBData {
	enum AccountType accountType;
	char* pszScreenName;
	char* pszUserID;
	char* pszPin;
	char* pszMasterUID;
};

class DBAccess {
public: 
	DBAccess();
	~DBAccess();
  /** No descriptions */
  bool Connect(char* pszHostName, char* pszUserName, char* pszPassword);
  /** No descriptions */
  bool FindUser(SearchKey skKey, UserDBData& pUserData);
  /** No descriptions */
  bool SetPIN(char* pszUserID, char* pszPin);
private: // Private attributes
  /**  */
  MYSQL msDataObject;
};

#endif
