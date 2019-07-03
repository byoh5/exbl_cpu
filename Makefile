#-------------------------------------------------------------------------
# Programs and flags 
#-------------------------------------------------------------------------

# C++ compiler
#  - CPPFLAGS : flags for the preprocessor (eg. -I,-D)
#  - CXXFLAGS : flags for C++ compiler (eg. -Wall,-g,-O3)

CC            := riscv64-unknown-elf-gcc
READELF       := riscv64-unknown-elf-readelf
OBJCOPY       := riscv64-unknown-elf-objcopy
OBJDUMP       := riscv64-unknown-elf-objdump
CFLAGS        := -Wall -D__NO_INLINE__ -mcmodel=medany -O0 -std=gnu99 -Wno-unused -Wno-attributes -fno-delete-null-pointer-checks -g $(CFLAGS)
BBL_PAYLOAD   := dummy_payload
COMPILE       := $(CC) -MMD -MP $(CFLAGS) 
# Linker
#  - LDFLAGS : Flags for the linker (eg. -L)
#  - LIBS    : Library flags (eg. -l)

LD            := $(CC)
LDFLAGS       := -Wl,--build-id=none -nostartfiles -static $(LDFLAGS)
LIBS          := -lgcc
LINK          := $(LD) $(LDFLAGS)

# Library creation

AR            := riscv64-unknown-elf-ar
RANLIB        := riscv64-unknown-elf-ranlib

	
SRCS =  uart.c
SRCS +=	print.c
SRCS += exbl.c
SRCS += mentry.S
SRCS += boot.c

OBJS =  uart.o
OBJS += print.o
OBJS += exbl.o
OBJS += mentry.o
OBJS += boot.o	

ifeq ($(SECTION),y)
	LDFILE = exbl_s.lds
else
	LDFILE = exbl.lds
endif

all :
	$(COMPILE) -c $(SRCS)
	$(LINK) -T $(LDFILE) -o exbl $(OBJS)	
	$(OBJDUMP) -DSx exbl > exbl.dis
	$(OBJCOPY) -O binary exbl exbl.bin
	cat exbl_flash.bin exbl.bin > exbl_boot.bin
#-------------------------------------------------------------------------
# Clean up
#-------------------------------------------------------------------------

clean :
	rm -rf *.o *.d exbl *.dis *.bin


