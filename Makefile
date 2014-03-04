# generated with tools\mkmk.pl MAKEFILE.SPEC

CC=sdcc
CFLAGS=-S -mpic16 -p18F452 --fstack --fommit-frame-pointer --optimize-goto --optimize-cmp --disable-warning 85 --obanksel=2 -pleave-reset-vector
FIXASM=perl tools/fixasm.pl
GPASM=gpasm -c
GPLINK=gplink
HEX2SYX=perl tools/hex2syx.pl
MIOS_WRAPPER_DEFINES=-DSTACK_HEAD=0x37f -DSTACK_IRQ_HEAD=0x33f
OUTDIR=_output
PROJECT=project
SDCC_DEFINES=-DDEBUG_MODE=0

OBJS=$(OUTDIR)/pic18f452.o $(OUTDIR)/main.o

$(PROJECT).syx: $(PROJECT).hex
	$(HEX2SYX) $(PROJECT).hex

$(PROJECT).hex: $(OUTDIR)/mios_wrapper.o $(OBJS)
	$(GPLINK) -s $(PROJECT).lkr -m -o $(PROJECT).hex $(OUTDIR)/mios_wrapper.o $(OBJS)

$(OUTDIR)/mios_wrapper.o: mios_wrapper/mios_wrapper.asm
	$(GPASM) $(MIOS_WRAPPER_DEFINES) -I mios_wrapper mios_wrapper/mios_wrapper.asm -o $(OUTDIR)/mios_wrapper.o

$(OUTDIR)/%.o: %.c

$(OUTDIR)/%.asm: %.c
	$(CC) $(CFLAGS) $(SDCC_DEFINES) $< -o $@
	$(FIXASM) $@

$(OUTDIR)/pic18f452.o: $(OUTDIR)/pic18f452.asm
	$(GPASM) $< -o $@
$(OUTDIR)/main.o: $(OUTDIR)/main.asm
	$(GPASM) $< -o $@


clean:
	rm -rf _output/*
	rm -rf *.cod *.map *.lst
