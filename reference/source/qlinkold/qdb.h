enum UserAccountType {
  uatNewDisk,
	uatNormal,
};

struct UserInfo {
  char                 szUserID[11];
  char                 szPin[5];
	char                 szScreenName[11];
  enum UserAccountType accountType;
};

int qdb_getuserbyID(struct UserInfo* pUserInfo);
int qdb_getuserbyname(struct UserInfo* pUserInfo);
int qdb_createuser(struct UserInfo* pUserInfo);
int qdb_sendemail(char* pszEmailFileName, char* pszDestName, char* pszSrcName);
int qdb_checkemail(char* pszScreenName);
int qdb_deleteemail(char* pszToName, char* pszFileID);
int qdb_getemail(char* pszScreenName, char* pszFileID);
int qdb_init(void);