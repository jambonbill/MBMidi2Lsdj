####################################################################################################
#
# This file specifies the content of a makefile for DOS and Unix
#
# They can be generated with:
#    perl tools/mkmk.pl MAKEFILE.SPEC
# 
# Following commands are provided by mkmk.pl:
#
#    MK_SET <name> <value>     sets a makefile variable to the given <value>
#    MK_ADD <name> <value>     adds values to the variable
#    MK_SET_OBJ <obj1> <obj2> ...  defines a new list of objects which should be compiled
#    MK_ADD_OBJ <obj1> <obj2> ...  adds objects to the list
#    WRITE_FILE <name>         writes a makefile with the given name
#
####################################################################################################

#
# general settings (normaly don't need to be touched)
#

MK_SET CC       sdcc
MK_SET FIXASM   perl tools/fixasm.pl
MK_SET HEX2SYX  perl tools/hex2syx.pl
MK_SET GPASM    gpasm -c
MK_SET GPLINK   gplink
MK_SET OUTDIR   _output
MK_SET CFLAGS   -S -mpic16 -p18F452 --fstack --fommit-frame-pointer --optimize-goto --optimize-cmp --disable-warning 85 --obanksel=2 -pleave-reset-vector


#
# generate common Makefile for "project.hex"
#

MK_SET PROJECT               project
MK_SET MIOS_WRAPPER_DEFINES  -DSTACK_HEAD=0x37f -DSTACK_IRQ_HEAD=0x33f
MK_SET SDCC_DEFINES          -DDEBUG_MODE=0

MK_SET_OBJ pic18f452.c main.c

WRITE_FILE Makefile
