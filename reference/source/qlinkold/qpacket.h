void qpp_cork(void);
void qpp_uncork(void);
void qpacket_back(void);
void transmit_command(unsigned char *pCommand, unsigned char *pData, int nDataLen);
int qpp_receivepacket(void);
void qpp_init(int nNewReadFD, int nNewWriteFD);