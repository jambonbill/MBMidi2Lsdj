;; BEGIN inserted by fixasm.pl
;; MPASM workarounds:
BANKED  EQU 1
;; END inserted by fixasm.pl
;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.8.0 #5117 (Mar 23 2008) (MINGW32)
; This file was generated Sat Nov 16 11:38:41 2013
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------
	list	p=18f452

	radix dec

;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global _PORTAbits
	global _PORTBbits
	global _PORTCbits
	global _PORTDbits
	global _PORTEbits
	global _LATAbits
	global _LATBbits
	global _LATCbits
	global _LATDbits
	global _LATEbits
	global _TRISAbits
	global _TRISBbits
	global _TRISCbits
	global _TRISDbits
	global _TRISEbits
	global _PIE1bits
	global _PIR1bits
	global _IPR1bits
	global _PIE2bits
	global _PIR2bits
	global _IPR2bits
	global _EECON1bits
	global _RCSTAbits
	global _TXSTAbits
	global _T3CONbits
	global _CCP2CONbits
	global _CCP1CONbits
	global _ADCON1bits
	global _ADCON0bits
	global _SSPCON2bits
	global _SSPCON1bits
	global _SSPSTATbits
	global _T2CONbits
	global _T1CONbits
	global _RCONbits
	global _WDTCONbits
	global _LVDCONbits
	global _OSCCONbits
	global _T0CONbits
	global _STATUSbits
	global _INTCON3bits
	global _INTCON2bits
	global _INTCONbits
	global _STKPTRbits
	global _PORTA
	global _PORTB
	global _PORTC
	global _PORTD
	global _PORTE
	global _LATA
	global _LATB
	global _LATC
	global _LATD
	global _LATE
	global _TRISA
	global _TRISB
	global _TRISC
	global _TRISD
	global _TRISE
	global _PIE1
	global _PIR1
	global _IPR1
	global _PIE2
	global _PIR2
	global _IPR2
	global _EECON1
	global _EECON2
	global _EEDATA
	global _EEADR
	global _RCSTA
	global _TXSTA
	global _TXREG
	global _RCREG
	global _SPBRG
	global _T3CON
	global _TMR3L
	global _TMR3H
	global _CCP2CON
	global _CCPR2L
	global _CCPR2H
	global _CCP1CON
	global _CCPR1L
	global _CCPR1H
	global _ADCON1
	global _ADCON0
	global _ADRESL
	global _ADRESH
	global _SSPCON2
	global _SSPCON1
	global _SSPSTAT
	global _SSPADD
	global _SSPBUF
	global _T2CON
	global _PR2
	global _TMR2
	global _T1CON
	global _TMR1L
	global _TMR1H
	global _RCON
	global _WDTCON
	global _LVDCON
	global _OSCCON
	global _T0CON
	global _TMR0L
	global _TMR0H
	global _STATUS
	global _FSR2L
	global _FSR2H
	global _PLUSW2
	global _PREINC2
	global _POSTDEC2
	global _POSTINC2
	global _INDF2
	global _BSR
	global _FSR1L
	global _FSR1H
	global _PLUSW1
	global _PREINC1
	global _POSTDEC1
	global _POSTINC1
	global _INDF1
	global _WREG
	global _FSR0L
	global _FSR0H
	global _PLUSW0
	global _PREINC0
	global _POSTDEC0
	global _POSTINC0
	global _INDF0
	global _INTCON3
	global _INTCON2
	global _INTCON
	global _PRODL
	global _PRODH
	global _TABLAT
	global _TBLPTRL
	global _TBLPTRH
	global _TBLPTRU
	global _PCL
	global _PCLATH
	global _PCLATU
	global _STKPTR
	global _TOSL
	global _TOSH
	global _TOSU


ustat_pic18f452_00	udata	0X0F80

_PORTA	res	0
_PORTAbits	res	1

_PORTB	res	0
_PORTBbits	res	1

_PORTC	res	0
_PORTCbits	res	1

_PORTD	res	0
_PORTDbits	res	1

_PORTE	res	0
_PORTEbits	res	1


ustat_pic18f452_01	udata	0X0F89

_LATA	res	0
_LATAbits	res	1

_LATB	res	0
_LATBbits	res	1

_LATC	res	0
_LATCbits	res	1

_LATD	res	0
_LATDbits	res	1

_LATE	res	0
_LATEbits	res	1


ustat_pic18f452_02	udata	0X0F92

_TRISA	res	0
_TRISAbits	res	1

_TRISB	res	0
_TRISBbits	res	1

_TRISC	res	0
_TRISCbits	res	1

_TRISD	res	0
_TRISDbits	res	1

_TRISE	res	0
_TRISEbits	res	1


ustat_pic18f452_03	udata	0X0F9D

_PIE1	res	0
_PIE1bits	res	1

_PIR1	res	0
_PIR1bits	res	1

_IPR1	res	0
_IPR1bits	res	1

_PIE2	res	0
_PIE2bits	res	1

_PIR2	res	0
_PIR2bits	res	1

_IPR2	res	0
_IPR2bits	res	1


ustat_pic18f452_04	udata	0X0FA6

_EECON1	res	0
_EECON1bits	res	1
_EECON2	res	1
_EEDATA	res	1
_EEADR	res	1


ustat_pic18f452_05	udata	0X0FAB

_RCSTA	res	0
_RCSTAbits	res	1

_TXSTA	res	0
_TXSTAbits	res	1
_TXREG	res	1
_RCREG	res	1
_SPBRG	res	1


ustat_pic18f452_06	udata	0X0FB1

_T3CON	res	0
_T3CONbits	res	1
_TMR3L	res	1
_TMR3H	res	1


ustat_pic18f452_07	udata	0X0FBA

_CCP2CON	res	0
_CCP2CONbits	res	1
_CCPR2L	res	1
_CCPR2H	res	1

_CCP1CON	res	0
_CCP1CONbits	res	1
_CCPR1L	res	1
_CCPR1H	res	1


ustat_pic18f452_08	udata	0X0FC1

_ADCON1	res	0
_ADCON1bits	res	1

_ADCON0	res	0
_ADCON0bits	res	1
_ADRESL	res	1
_ADRESH	res	1

_SSPCON2	res	0
_SSPCON2bits	res	1

_SSPCON1	res	0
_SSPCON1bits	res	1

_SSPSTAT	res	0
_SSPSTATbits	res	1
_SSPADD	res	1
_SSPBUF	res	1

_T2CON	res	0
_T2CONbits	res	1
_PR2	res	1
_TMR2	res	1

_T1CON	res	0
_T1CONbits	res	1
_TMR1L	res	1
_TMR1H	res	1

_RCON	res	0
_RCONbits	res	1

_WDTCON	res	0
_WDTCONbits	res	1

_LVDCON	res	0
_LVDCONbits	res	1

_OSCCON	res	0
_OSCCONbits	res	1


ustat_pic18f452_09	udata	0X0FD5

_T0CON	res	0
_T0CONbits	res	1
_TMR0L	res	1
_TMR0H	res	1

_STATUS	res	0
_STATUSbits	res	1
_FSR2L	res	1
_FSR2H	res	1
_PLUSW2	res	1
_PREINC2	res	1
_POSTDEC2	res	1
_POSTINC2	res	1
_INDF2	res	1
_BSR	res	1
_FSR0L	res	1
_FSR0H	res	1
_PLUSW0	res	1
_PREINC0	res	1
_POSTDEC0	res	1
_POSTINC0	res	1
_INDF0	res	1
_WREG	res	1
_FSR1L	res	1
_FSR1H	res	1
_PLUSW1	res	1
_PREINC1	res	1
_POSTDEC1	res	1
_POSTINC1	res	1
_INDF1	res	1

_INTCON3	res	0
_INTCON3bits	res	1

_INTCON2	res	0
_INTCON2bits	res	1

_INTCON	res	0
_INTCONbits	res	1
_PRODL	res	1
_PRODH	res	1
_TABLAT	res	1
_TBLPTRL	res	1
_TBLPTRH	res	1
_TBLPTRU	res	1
_PCL	res	1
_PCLATH	res	1
_PCLATU	res	1

_STKPTR	res	0
_STKPTRbits	res	1
_TOSL	res	1
_TOSH	res	1
_TOSU	res	1

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!


; Statistics:
; code size:	   -1 (0xffffffff) bytes (3276800.00%)
;           	2147483647 (0x7fffffff) words
; udata size:	  101 (0x0065) bytes ( 7.89%)
; access size:	    0 (0x0000) bytes


	end
