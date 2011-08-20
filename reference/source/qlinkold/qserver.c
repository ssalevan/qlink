#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <termios.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <syslog.h>

#include "qlogin.h"
#include "qmenus.h"
#include "qpacket.h"
#include "qparse.h"
#include "qdb.h"
#include "qmail.h"
#include "qio.h"

#define FALSE 0
#define TRUE 1

volatile int STOP=FALSE;

unsigned char loginbanner;

int main() {
  openlog("qserver", LOG_PID, LOG_LOCAL0);
	qmail_init();
	qparse_init();
	qdb_init();
	qpp_init(STDIN_FILENO, STDOUT_FILENO);

  while(1) {
        qio_process_fds();
  }
}


