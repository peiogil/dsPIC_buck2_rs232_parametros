# MPLAB IDE generated this makefile for use with GNU make.
# Project: BUCK2_TIPO_II_rs232.mcp
# Date: Wed Aug 28 12:08:56 2013

AS = pic30-as.exe
CC = pic30-gcc.exe
LD = pic30-ld.exe
AR = pic30-ar.exe
HX = pic30-bin2hex.exe
RM = rm

BUCK2_TIPO_II_rs232.hex : BUCK2_TIPO_II_rs232.cof
	$(HX) "BUCK2_TIPO_II_rs232.cof"

BUCK2_TIPO_II_rs232.cof : init.o isr.o isr_asm.o main.o pid_TIPO_II.o rs232.o
	$(CC) -mcpu=33FJ16GS502 "init.o" "isr.o" "isr_asm.o" "main.o" "pid_TIPO_II.o" "rs232.o" -o"BUCK2_TIPO_II_rs232.cof" -Wl,-L"C:\Archivos de programa\Microchip\MPLAB C30\lib",--script="h\p33FJ16GS502.gld",--defsym=__MPLAB_BUILD=1,--defsym=__MPLAB_DEBUG=1,--defsym=__MPLAB_DEBUGGER_ICD3=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_SWBPS_ON=1,-Map="BUCK2_TIPO_II_rs232.map",--report-mem

init.o : h/dsp.h h/Functions.h ../../../../../../../Archivos\ de\ programa/Microchip/MPLAB\ C30/include/math.h ../../../../../../../Archivos\ de\ programa/Microchip/MPLAB\ C30/include/stddef.h ../../../../../../../Archivos\ de\ programa/Microchip/MPLAB\ C30/include/stdlib.h h/dsp.h ../../../../../../../archivos\ de\ programa/microchip/mplab\ c30/support/dsPIC33F/h/p33FJ16GS502.h src/init.c
	$(CC) -mcpu=33FJ16GS502 -x c -c "src\init.c" -o"init.o" -I"C:\Archivos de programa\Microchip\MPLAB C30\include" -I"C:\Documents and Settings\pgil\Mis documentos\Hezkuntza\DSP_18F\DSP33FJ\BUCK2_16BIT_28_PIN_TIPO_II_2\h" -I"C:\Documents and Settings\pgil\Mis documentos\Hezkuntza\DSP_18F\DSP33FJ\BUCK2_16BIT_28_PIN_TIPO_II_2\inc" -D__DEBUG -D__MPLAB_DEBUGGER_ICD3=1 -g -Wall

isr.o : ../../../../../../../archivos\ de\ programa/microchip/mplab\ c30/support/dsPIC33F/h/p33FJ16GS502.h ../../../../../../../archivos\ de\ programa/microchip/mplab\ c30/support/dsPIC33F/h/p33Fxxxx.h h/uart.h ../../../../../../../Archivos\ de\ programa/Microchip/MPLAB\ C30/include/math.h ../../../../../../../Archivos\ de\ programa/Microchip/MPLAB\ C30/include/stddef.h ../../../../../../../Archivos\ de\ programa/Microchip/MPLAB\ C30/include/stdlib.h h/dsp.h ../../../../../../../archivos\ de\ programa/microchip/mplab\ c30/support/dsPIC33F/h/p33FJ16GS502.h src/isr.c
	$(CC) -mcpu=33FJ16GS502 -x c -c "src\isr.c" -o"isr.o" -I"C:\Archivos de programa\Microchip\MPLAB C30\include" -I"C:\Documents and Settings\pgil\Mis documentos\Hezkuntza\DSP_18F\DSP33FJ\BUCK2_16BIT_28_PIN_TIPO_II_2\h" -I"C:\Documents and Settings\pgil\Mis documentos\Hezkuntza\DSP_18F\DSP33FJ\BUCK2_16BIT_28_PIN_TIPO_II_2\inc" -D__DEBUG -D__MPLAB_DEBUGGER_ICD3=1 -g -Wall

isr_asm.o : ../../../../../../../archivos\ de\ programa/microchip/mplab\ c30/support/dsPIC33F/inc/p33FJ16GS502.inc src/isr_asm.s
	$(CC) -mcpu=33FJ16GS502 -c -I"C:\Archivos de programa\Microchip\MPLAB C30\include" -I"C:\Documents and Settings\pgil\Mis documentos\Hezkuntza\DSP_18F\DSP33FJ\BUCK2_16BIT_28_PIN_TIPO_II_2\h" -I"C:\Documents and Settings\pgil\Mis documentos\Hezkuntza\DSP_18F\DSP33FJ\BUCK2_16BIT_28_PIN_TIPO_II_2\inc" -D__DEBUG -D__MPLAB_DEBUGGER_ICD3=1 "src\isr_asm.s" -o"isr_asm.o" -Wa,-I"C:\Documents and Settings\pgil\Mis documentos\Hezkuntza\DSP_18F\DSP33FJ\BUCK2_16BIT_28_PIN_TIPO_II_2\inc",--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_ICD3=1,-g

main.o : ../../../../../../../Archivos\ de\ programa/Microchip/MPLAB\ C30/include/math.h ../../../../../../../Archivos\ de\ programa/Microchip/MPLAB\ C30/include/stddef.h ../../../../../../../Archivos\ de\ programa/Microchip/MPLAB\ C30/include/stdlib.h h/dsp.h h/Functions.h ../../../../../../../archivos\ de\ programa/microchip/mplab\ c30/support/dsPIC33F/h/p33FJ16GS502.h src/main.c
	$(CC) -mcpu=33FJ16GS502 -x c -c "src\main.c" -o"main.o" -I"C:\Archivos de programa\Microchip\MPLAB C30\include" -I"C:\Documents and Settings\pgil\Mis documentos\Hezkuntza\DSP_18F\DSP33FJ\BUCK2_16BIT_28_PIN_TIPO_II_2\h" -I"C:\Documents and Settings\pgil\Mis documentos\Hezkuntza\DSP_18F\DSP33FJ\BUCK2_16BIT_28_PIN_TIPO_II_2\inc" -D__DEBUG -D__MPLAB_DEBUGGER_ICD3=1 -g -Wall

pid_TIPO_II.o : inc/dspcommon.inc src/pid_TIPO_II.s
	$(CC) -mcpu=33FJ16GS502 -c -I"C:\Archivos de programa\Microchip\MPLAB C30\include" -I"C:\Documents and Settings\pgil\Mis documentos\Hezkuntza\DSP_18F\DSP33FJ\BUCK2_16BIT_28_PIN_TIPO_II_2\h" -I"C:\Documents and Settings\pgil\Mis documentos\Hezkuntza\DSP_18F\DSP33FJ\BUCK2_16BIT_28_PIN_TIPO_II_2\inc" -D__DEBUG -D__MPLAB_DEBUGGER_ICD3=1 "src\pid_TIPO_II.s" -o"pid_TIPO_II.o" -Wa,-I"C:\Documents and Settings\pgil\Mis documentos\Hezkuntza\DSP_18F\DSP33FJ\BUCK2_16BIT_28_PIN_TIPO_II_2\inc",--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_ICD3=1,-g

rs232.o : ../../../../../../../archivos\ de\ programa/microchip/mplab\ c30/support/dsPIC33F/h/p33FJ16GS502.h ../../../../../../../archivos\ de\ programa/microchip/mplab\ c30/support/dsPIC33F/h/p33Fxxxx.h h/uart.h ../../../../../../../archivos\ de\ programa/microchip/mplab\ c30/support/dsPIC33F/h/p33FJ16GS502.h src/rs232.c
	$(CC) -mcpu=33FJ16GS502 -x c -c "src\rs232.c" -o"rs232.o" -I"C:\Archivos de programa\Microchip\MPLAB C30\include" -I"C:\Documents and Settings\pgil\Mis documentos\Hezkuntza\DSP_18F\DSP33FJ\BUCK2_16BIT_28_PIN_TIPO_II_2\h" -I"C:\Documents and Settings\pgil\Mis documentos\Hezkuntza\DSP_18F\DSP33FJ\BUCK2_16BIT_28_PIN_TIPO_II_2\inc" -D__DEBUG -D__MPLAB_DEBUGGER_ICD3=1 -g -Wall

clean : 
	$(RM) "init.o" "isr.o" "isr_asm.o" "main.o" "pid_TIPO_II.o" "rs232.o" "BUCK2_TIPO_II_rs232.cof" "BUCK2_TIPO_II_rs232.hex"

