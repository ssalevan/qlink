/***************************************************************************
                          qporch.h  -  description
                             -------------------
    begin                : Sat Dec 8 2001
    copyright            : (C) 2001 by Keith Henrickson
    email                : flipper@phin.com
 ***************************************************************************/

#ifndef QPORCH_H
#define QPORCH_H

/**This handles the user logon sequence
  *@author Keith Henrickson
  */

class QUser;
class QPorch {
public: 
	QPorch();
	~QPorch();
  /** No descriptions */
  bool UserAccessInfo(QUser* pParent, unsigned char *bParameter, int nParamLen);
  /** This function handles all needs after the disk has been validated. */
  void DiskValidatedOK(QUser* pParent);
  /** No descriptions */
  char* GetScreenName();
  /** No descriptions */
  char* GetPIN();
  /** No descriptions */
  char* GetUserID();
  /** No descriptions */
  char* GetMasterUID();
  /**  Holds the user record to and from the database */
  struct UserDBData uddInfo;
};

#endif
