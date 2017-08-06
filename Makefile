VERSION_MAJOR = 0
VERSION_MINOR = 0
VERSION_PATCH = 0
VERSION = ${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH}
NAME = gwavi

CC ?= gcc
DOXYGEN ?= doxygen
LN ?= ln
MAKE ?= make
rm ?= rm

CFLAGS = -O3 -std=c89 -fPIC ${INCLUDES}
CFDEBUG = -O0 -g3 -pedantic -Wall -Wextra -Wconversion -Wstrict-prototypes \
		  -Wcast-qual -Wcast-align -Wshadow -Wredundant-decls -Wundef \
		  -Wfloat-equal -Wmissing-include-dirs -Wswitch-default -Wswitch-enum \
		  -Wpointer-arith -Wbad-function-cast -Wnested-externs \
		  -Wold-style-definition -Wsign-conversion -Wlogical-op \
		  -Wno-long-long -pipe -Wunreachable-code

INCLUDES=-I${INC}

DOC = doc
EXAMPLES = examples
INC = inc
LIB = lib
OBJ = obj
SRC = src
TEST= test

SRCS = ${SRC}/avi-utils.c \
	   ${SRC}/gwavi.c \
	   ${SRC}/fileio.c

OBJS = ${SRCS:${SRC}/%.c=${OBJ}/%.o}

.PATH: ${SRC}

${NAME}: ${OBJS}
	${CC} ${CFLAGS} -shared -o ${LIB}/lib${NAME}.so.${VERSION} ${OBJS}
	${LN} -sf lib${NAME}.so.${VERSION} ${LIB}/lib${NAME}.so.${VERSION_MAJOR}
	${LN} -sf lib${NAME}.so.${VERSION} ${LIB}/lib${NAME}.so.${VERSION_MAJOR}.${VERSION_MINOR}
	${LN} -sf lib${NAME}.so.${VERSION} ${LIB}/lib${NAME}.so

${OBJS}: ${OBJ}/%.o : ${SRC}/%.c
	${CC} ${CFLAGS} -o $@ -c $<

all: ${NAME} examples doc

debug: ${NAME}

debug: CFLAGS += ${CFDEBUG}

examples: ${NAME}
	${MAKE} -C ${EXAMPLES}

doc: ${OBJS}
	${DOXYGEN} ${DOC}/Doxyfile

test: ${NAME}
	${MAKE} -C ${TEST}

clean:
	${RM} -f ${OBJ}/*.o
	${MAKE} -C ${EXAMPLES} clean
	${MAKE} -C ${TEST} clean

mrproper: clean
	${RM} -rf ${LIB}/*.so* ${DOC}/html ${DOC}/latex ${DOC}/man
	${MAKE} -C ${EXAMPLES} mrproper
	${MAKE} -C ${TEST} mrproper

.PHONY: all clean debug doc examples mrproper
