CC=gcc
CFLAGS=-Wall
CPPFLAGS=-I/usr/include/mysql
LDFLAGS=-L/usr/lib/mysql

all: miniteletym qserver

miniteletym: miniteletym.o

qserver: qserver.o qpacket.o qmenus.o qlogin.o qparse.o qnewuser.o qdb.o qfile.o qmail.o qtelnet.o qio.o qmcp.o qchat.o
	$(CC) $+ $(LDFLAGS) -lmysqlclient -o qserver

clean:
	rm -f *.o
	rm -f *.d

sources = miniteletym.c qserver.c qpacket.c qmenus.c qlogin.c qparse.c qnewuser.c qdb.c qfile.c qmail.c qtelnet.c qio.c qmcp.c qchat.c

include $(sources:.c=.d)

%.d: %.c
	set -e; $(CC) -M $(CPPFLAGS) $< \
	| sed 's/\($*\)\.o[ :]*/\1.o $@ : /g' > $@; \
	[ -s $@ ] || rm -f $@

