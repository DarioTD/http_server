include config.mk

SRC = http_server.c
OBJ = ${SRC:.c=.o}

all: http_server

.c.o:
	${CC} -c ${CFLAGS} $<

http_server: ${OBJ}
	${CC} -o $@ ${OBJ} ${LDFLAGS}

clean:
	rm -f http_server ${OBJ} http_server-${VERSION}.tar.gz

dist: clean
	mkdir -p http_server-${VERSION}
	cp -R Makefile ${SRC} http_server-${VERSION}
	tar -cf http_server-${VERSION}.tar http_server-${VERSION}
	gzip http_server-${VERSION}.tar
	rm -rf http_server-${VERSION}

install: all
	mkdir -p ${DESTDIR}${PREFIX}/bin
	cp -f http_server ${DESTDIR}${PREFIX}/bin
	chmod 755 ${DESTDIR}${PREFIX}/bin/http_server

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/http_server

.PHONY: all clean dist install uninstall
