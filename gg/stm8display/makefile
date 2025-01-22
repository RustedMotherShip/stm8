DEVICE=stm8s103f3

COMMONDIR = ./libs

PROGRAM = $(lastword $(subst /, ,$(CURDIR)))

# Определяем исходные файлы
SOURCES = main.c $(wildcard $(COMMONDIR)/*.c)
OBJECTS = $(SOURCES:.c=.rel)
HEADERS = $(wildcard *.h $(COMMONDIR)/*.h)

CC = sdcc
PROGRAMMER = stlinkv2

CPPFLAGS = -I$(COMMONDIR)
CFLAGS = --std-sdcc99 -mstm8 -DSTM8S103
LDFLAGS = -lstm8 -mstm8 --out-fmt-ihx

.PHONY: all clean flash

# Основная цель
all: $(PROGRAM).ihx

# Цель для прошивки
$(PROGRAM).ihx: main.rel $(OBJECTS)
	$(CC) $(LDFLAGS) main.rel $(OBJECTS) -o $@

# Правила для компиляции каждого файла отдельно
%.rel: %.c $(HEADERS)
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $<

# Цель для компиляции main.c отдельно
main.rel: main.c $(HEADERS)
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $<

CCOMPILEDFILES=$(SOURCES:.c=.asm) $(SOURCES:.c=.lst) $(SOURCES:.c=.rel) \
               $(SOURCES:.c=.rst) $(SOURCES:.c=.sym)

clean:
	rm -f $(PROGRAM).ihx $(PROGRAM).cdb $(PROGRAM).lk $(PROGRAM).map $(CCOMPILEDFILES)

flash: $(PROGRAM).ihx
	stm8flash -c $(PROGRAMMER) -p $(DEVICE) -w $(PROGRAM).ihx
