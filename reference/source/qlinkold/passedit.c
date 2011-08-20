#include <stdio.h>
#include <stdlib.h>
#include <errno.h>

char szPin[5];
int nNumUsers;
char szUserID[4][11];
char szUserName[4][11];

int seektands(FILE *fpDiskImage, int track, int sector) {

   int nCounter;
   int nTempSect = 0;

   for (nCounter = 1; nCounter < track; nCounter++) {
      if (nCounter < 18) {
         nTempSect += 21;
      } else if (nCounter < 25) {
         nTempSect += 19;
      } else if (nCounter < 31) {
         nTempSect += 18;
      } else {
         nTempSect += 17;
      }
   }
   nTempSect += sector;

   if (0 == fseek(fpDiskImage, nTempSect * 256, SEEK_SET)) {
      return 1;
   } else {
      printf("Could not seek to %d:%d.  Error = %d\n", track, sector, errno);
      return 0;
   }
}

void dump_sector(unsigned char *bSector) {

   int nCounter;
   char szCharThingy[17];

   szCharThingy[16] = 0;
   for (nCounter = 0; nCounter < 256; nCounter++) {
      switch (nCounter) {
         case 16:
         case 32:
         case 48:
         case 64:
         case 80:
         case 96:
         case 112:
         case 128:
         case 144:
         case 160:
         case 176:
         case 192:
         case 208:
         case 224:
         case 240:
         case 256:
         printf("          %s\n", szCharThingy);
      }
      printf("%02X ", bSector[nCounter]);
      if ((bSector[nCounter] > 0x20) && (bSector[nCounter] < 0x7F)) {
         szCharThingy[nCounter % 16] = bSector[nCounter];
      } else {
         szCharThingy[nCounter % 16] = '.';
      }
   }
   printf("\n");
}

void decrypt_sector(unsigned char *bSector) {

   int nCounter;
   unsigned char nCrypto = 0x6E;

   for (nCounter = 0; nCounter < 256; nCounter ++) {
      bSector[nCounter] ^= nCrypto;
      nCrypto = (nCrypto + 1) % 0x100;
   }
}

void decode_sector(unsigned char *bSector) {

   int nCounter;
   int nCounter2;

   szPin[4] = 0;
   memcpy(szPin, &bSector[9], 4);
   printf("The master pin for these accounts is: '%s'\n", szPin);
   nNumUsers = bSector[50];
   printf("This disk has %d users.\n", nNumUsers);
   for (nCounter = 0; nCounter < nNumUsers; nCounter++) {
      for (nCounter2 = 0; nCounter2 < 5; nCounter2++) {
         szUserID[nCounter][nCounter2 * 2] = ((bSector[51 + (15 * nCounter) + nCounter2] & 0xF0) >> 4) | 0x30;
         szUserID[nCounter][(nCounter2 * 2) + 1] = (bSector[51 + (15 * nCounter) + nCounter2] & 0x0F)  | 0x30;
      }
      szUserID[nCounter][10] = 0;
      for (nCounter2 = 0; nCounter2 < 10; nCounter2++) {
         if (bSector[56 + (15 * nCounter) + nCounter2] < 0x20) {
            szUserName[nCounter][nCounter2] = bSector[56 + (15 * nCounter) + nCounter2] + 0x60;
         } else {
            szUserName[nCounter][nCounter2] = bSector[56 + (15 * nCounter) + nCounter2];
         }
         szUserName[nCounter][10] = 0;
      }
      printf("User %d:   Name = %s, ID = %s\n", nCounter + 1, szUserName[nCounter], szUserID[nCounter]);
   }

}

void encode_sector(unsigned char *bSector) {

   int nCounter;
   int nCounter2;

   memcpy(&bSector[9], szPin, 4);
   bSector[50] = nNumUsers;
   for (nCounter = 0; nCounter < nNumUsers; nCounter++) {
      for (nCounter2 = 0; nCounter2 < 5; nCounter2++) {
         bSector[51 + (15 * nCounter) + nCounter2] = (szUserID[nCounter][nCounter2 * 2] & 0x0F) << 4;
         bSector[51 + (15 * nCounter) + nCounter2] |= (szUserID[nCounter][(nCounter2 * 2) + 1] & 0x0F);
      }
      for (nCounter2 = 0; nCounter2 < 10; nCounter2++) {
         if (szUserName[nCounter][nCounter2] >= 0x60) {
            bSector[56 + (15 * nCounter) + nCounter2] = szUserName[nCounter][nCounter2] - 0x60;
         } else {
            bSector[56 + (15 * nCounter) + nCounter2] = szUserName[nCounter][nCounter2];
         }
      }
   }
}

int main (int argc, char *argv[]) {

   unsigned char nSectorData[256];
   char szMenuChoice[20];
   FILE *fpDiskImage;
   int nMenuItem;

   if (2 != argc) {
      printf("Usage: %s <disk image name>\n", argv[0]);
      return 1;
   }

   fpDiskImage = fopen(argv[1], "rb+");
   if (NULL == fpDiskImage) {
      printf("Cannot open disk image file %s\n", argv[1]);
      return 1;
   }

   if (!seektands(fpDiskImage, 18, 15)) {
      return 1;
   }

   if (256 != fread(nSectorData, 1, 256, fpDiskImage)) {
      printf("Did not read 256 bytes as expected.\n");
   }

   decrypt_sector(nSectorData);
   dump_sector(nSectorData);

   decode_sector(nSectorData);

   while (1) {
      printf("1. Change disk PIN code.\n");
      printf("2. Set number of users.\n");
      printf("3. Set user entry.\n");
      printf("4. Save entry.\n");
      printf("0. Quit.\n");
      fgets(szMenuChoice, 10, stdin);
      nMenuItem = atoi(szMenuChoice);
      switch (nMenuItem) {
         case 1:
            printf("Enter the new PIN code: ");
            fgets(szPin, 10, stdin);
            break;
         case 2:
            printf("Enter the number of users: ");
            fgets(szMenuChoice, 10, stdin);
            nNumUsers = atoi(szMenuChoice);
            break;
         case 3:
            printf("Enter the number of the user to edit: ");
            fgets(szMenuChoice, 10, stdin);
            nMenuItem = atoi(szMenuChoice) - 1;
            printf("Enter the new user ID code: ");
            fgets(szUserID[nMenuItem], 20, stdin);
            printf("Enter the new user name: ");
            fgets(szUserName[nMenuItem], 20, stdin);

            break;
         case 4:
            encode_sector(nSectorData);
            dump_sector(nSectorData);
            decrypt_sector(nSectorData);
            if (!seektands(fpDiskImage, 18, 15)) {
               return 1;
            }

            if (256 != fwrite(nSectorData, 1, 256, fpDiskImage)) {
               printf("Did not write 256 bytes as expected.\n");
            }
            decrypt_sector(nSectorData);
            break;
         case 0:
            fclose(fpDiskImage);
            return 0;
            break;
         default:
            printf("Invalid menu choice.\n");
      }
   }

   fclose(fpDiskImage);

   return 0;
}
