## Get program name from enclosing directory name
PROGRAM = $(lastword $(subst /, ,$(CURDIR)))

SOURCES=$(wildcard *.c $(COMMONDIR)/*.c)
OBJECTS=$(SOURCES:.c=.rel)
HEADERS=$(wildcard *.h $(COMMONDIR)/*.h)

CC = sdcc
PROGRAMMER = stlinkv2

CPPFLAGS = -I../i2c
CFLAGS = --std-sdcc99 -mstm8 -DSTM8S103

.PHONY: all clean

%.rel : %.c $(HEADERS)
	$(CC) $(CFLAGS) $(CPPFLAGS) -c -o $@ $<

$(PROGRAM).ihx: $(OBJECTS)	

CCOMPILEDFILES=$(SOURCES:.c=.asm) $(SOURCES:.c=.lst)\
               $(SOURCES:.c=.rst) $(SOURCES:.c=.sym)
clean:
	rm -f $(PROGRAM).ihx $(PROGRAM).cdb $(PROGRAM).lk $(PROGRAM).map $(PROGRAM).mem $(CCOMPILEDFILES)
