int qmcp_connect(char *pszHostName, unsigned short nPort);
void qmcp_close(void);
void qmcp_receive(void);
int qmcp_connectuser(char *pszScreenName);
int qmcp_useronline(char *pszScreenName);
void qmcp_sendolm(char *pszScreenName, char *pszMsgTxt, int nLastLine);
void qmcp_sendtalk(char *pszMessage);
void qmcp_sendjoin(char *pszRoomName);

