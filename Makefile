# 

TOOLCHAIN_PREFIX=m68k-atari-mint-
CC=$(TOOLCHAIN_PREFIX)gcc

UNAME := $(shell uname)
ifeq ($(UNAME),Linux)
PREFIX=m68k-atari-mint
HATARI=hatari
else
PREFIX=/opt/cross-mint/m68k-atari-mint
HATARI=/usr/local/bin/hatari
endif

CFLAGS= \
	-Os\
	-fomit-frame-pointer\
    -mcpu=547x\
	-Wall\
	-mshort\
	-nostdlib
	
APP=strb_inv.prg

all: $(APP) 

SOURCES=startup.S strb_inv.c
		
OBJECTS=$(SOURCES:.c=.o)

$(APP): $(OBJECTS) depend
	$(CC) $(CFLAGS) $(OBJECTS) -o $(APP) -lgcc
	m68k-atari-mint-strip $(APP)
		
.PHONY clean:
	- rm -rf *.o depend strb_inv.prg

depend: $(SOURCES)
		$(CC) $(CFLAGS) $(INCLUDE) -M $(SOURCES) strb_inv.c > depend

	
ifneq (clean,$(MAKECMDGOALS))
-include depend
endif
