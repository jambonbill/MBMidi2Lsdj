@ECHO OFF
REM generated with tools\mkmk.pl MAKEFILE.SPEC

REM === create output directory ===============================================
if not exist _output mkdir _output

REM === assemble MIOS SDCC wrapper and device specific setup ==================
echo Assembling MIOS SDCC wrapper
gpasm -c -DSTACK_HEAD=0x37f -DSTACK_IRQ_HEAD=0x33f -I mios_wrapper mios_wrapper\mios_wrapper.asm -o _output\mios_wrapper.o
if errorlevel 1 goto end_error

REM === Build the project files ===============================================
echo ==========================================================================
echo Compiling pic18f452.c
sdcc -S -mpic16 -p18F452 --fstack --fommit-frame-pointer --optimize-goto --optimize-cmp --disable-warning 85 --obanksel=2 -pleave-reset-vector -DDEBUG_MODE=0 pic18f452.c -o _output\pic18f452.asm
if errorlevel 1 goto end_error
perl tools\fixasm.pl _output\pic18f452.asm
if errorlevel 1 goto end_error
gpasm -c _output\pic18f452.asm -o _output\pic18f452.o
if errorlevel 1 goto end_error
echo ==========================================================================
echo Compiling main.c
sdcc -S -mpic16 -p18F452 --fstack --fommit-frame-pointer --optimize-goto --optimize-cmp --disable-warning 85 --obanksel=2 -pleave-reset-vector -DDEBUG_MODE=0 main.c -o _output\main.asm
if errorlevel 1 goto end_error
perl tools\fixasm.pl _output\main.asm
if errorlevel 1 goto end_error
gpasm -c _output\main.asm -o _output\main.o
if errorlevel 1 goto end_error

echo ==========================================================================
echo Linking project
gplink -s project.lkr -m -o project.hex _output\*.o
if errorlevel 1 goto end_error

echo ==========================================================================
echo Converting to project.syx
perl tools\hex2syx.pl project.hex
if errorlevel 1 goto end_error

echo ==========================================================================
echo SUCCESS!
goto :end

:end_error
echo ERROR!
:end
