/***************************************************************************
                          assists.cpp  -  description
                             -------------------
    begin                : Sat Dec 8 2001
    copyright            : (C) 2001 by Keith Henrickson
    email                : flipper@phin.com
 ***************************************************************************/

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
