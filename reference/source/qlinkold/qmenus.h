enum qmenus_menutype {
   qmtMenu,
   qmtTextfile,
   qmtPostoffice,
   qmtAreamenu,
   qmtTelnet,
   qmtFileArea,
};

struct qmenus_menulistitem {
   unsigned char nNumEntries;
   char szItemID[10][5];
   char szItemName[10][41];
   enum qmenus_menutype ItemType[10];
   struct qmenus_menulistitem *pNext;
};


void transmit_menuitem(char *pszMenuText, char *pszResource, unsigned char nMenuCmd1, unsigned char nMenuCmd2, unsigned char nMenuCmd3, int fLastItem);
void qmenus_itemselect(char *pszItemID);
void qmenus_init(void);