;; BEGIN inserted by fixasm.pl
;; MPASM workarounds:
BANKED  EQU 1
;; END inserted by fixasm.pl
;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.1.0 #7066 (Jun 14 2012) (Linux)
; This file was generated Mon Dec  2 22:51:28 2013
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------
	list	p=18f452

	radix dec

;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global _nbpulse
	global _nbpulse24
	global _nbtik
	global _nbstep
	global _nbpat
	global _timer
	global _timer24
	global _play
	global _midiplay
	global _last
	global _SEND_PULSE
	global _SYNC24_PUSH
	global _GB_INIT
	global _Init
	global _Tick
	global _Timer
	global _DISPLAY_Init
	global _DISPLAY_Tick
	global _MPROC_NotifyReceivedEvnt
	global _MPROC_NotifyFoundEvent
	global _MPROC_NotifyTimeout
	global _MPROC_NotifyReceivedByte
	global _SR_Service_Prepare
	global _SR_Service_Finish
	global _DIN_NotifyToggle
	global _ENC_NotifyChange
	global _AIN_NotifyChange

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern _MIOS_BOX_CFG0
	extern _MIOS_BOX_CFG1
	extern _MIOS_BOX_STAT
	extern _MIOS_PARAMETER1
	extern _MIOS_PARAMETER2
	extern _MIOS_PARAMETER3
	extern _PORTAbits
	extern _PORTBbits
	extern _PORTCbits
	extern _PORTDbits
	extern _PORTEbits
	extern _LATAbits
	extern _LATBbits
	extern _LATCbits
	extern _LATDbits
	extern _LATEbits
	extern _TRISAbits
	extern _TRISBbits
	extern _TRISCbits
	extern _TRISDbits
	extern _TRISEbits
	extern _PIE1bits
	extern _PIR1bits
	extern _IPR1bits
	extern _PIE2bits
	extern _PIR2bits
	extern _IPR2bits
	extern _EECON1bits
	extern _RCSTAbits
	extern _TXSTAbits
	extern _T3CONbits
	extern _CCP2CONbits
	extern _CCP1CONbits
	extern _ADCON1bits
	extern _ADCON0bits
	extern _SSPCON2bits
	extern _SSPCON1bits
	extern _SSPSTATbits
	extern _T2CONbits
	extern _T1CONbits
	extern _RCONbits
	extern _WDTCONbits
	extern _LVDCONbits
	extern _OSCCONbits
	extern _T0CONbits
	extern _STATUSbits
	extern _INTCON3bits
	extern _INTCON2bits
	extern _INTCONbits
	extern _STKPTRbits
	extern _PORTA
	extern _PORTB
	extern _PORTC
	extern _PORTD
	extern _PORTE
	extern _LATA
	extern _LATB
	extern _LATC
	extern _LATD
	extern _LATE
	extern _TRISA
	extern _TRISB
	extern _TRISC
	extern _TRISD
	extern _TRISE
	extern _PIE1
	extern _PIR1
	extern _IPR1
	extern _PIE2
	extern _PIR2
	extern _IPR2
	extern _EECON1
	extern _EECON2
	extern _EEDATA
	extern _EEADR
	extern _RCSTA
	extern _TXSTA
	extern _TXREG
	extern _RCREG
	extern _SPBRG
	extern _T3CON
	extern _TMR3L
	extern _TMR3H
	extern _CCP2CON
	extern _CCPR2L
	extern _CCPR2H
	extern _CCP1CON
	extern _CCPR1L
	extern _CCPR1H
	extern _ADCON1
	extern _ADCON0
	extern _ADRESL
	extern _ADRESH
	extern _SSPCON2
	extern _SSPCON1
	extern _SSPSTAT
	extern _SSPADD
	extern _SSPBUF
	extern _T2CON
	extern _PR2
	extern _TMR2
	extern _T1CON
	extern _TMR1L
	extern _TMR1H
	extern _RCON
	extern _WDTCON
	extern _LVDCON
	extern _OSCCON
	extern _T0CON
	extern _TMR0L
	extern _TMR0H
	extern _STATUS
	extern _FSR2L
	extern _FSR2H
	extern _PLUSW2
	extern _PREINC2
	extern _POSTDEC2
	extern _POSTINC2
	extern _INDF2
	extern _BSR
	extern _FSR1L
	extern _FSR1H
	extern _PLUSW1
	extern _PREINC1
	extern _POSTDEC1
	extern _POSTINC1
	extern _INDF1
	extern _WREG
	extern _FSR0L
	extern _FSR0H
	extern _PLUSW0
	extern _PREINC0
	extern _POSTDEC0
	extern _POSTINC0
	extern _INDF0
	extern _INTCON3
	extern _INTCON2
	extern _INTCON
	extern _PRODL
	extern _PRODH
	extern _TABLAT
	extern _TBLPTRL
	extern _TBLPTRH
	extern _TBLPTRU
	extern _PCL
	extern _PCLATH
	extern _PCLATU
	extern _STKPTR
	extern _TOSL
	extern _TOSH
	extern _TOSU
	extern _MIOS_MIDI_TxBufferPut
	extern _MIOS_LCD_Clear
	extern _MIOS_LCD_CursorSet
	extern _MIOS_LCD_PrintBCD1
	extern _MIOS_LCD_PrintBCD2
	extern _MIOS_LCD_PrintCString
	extern _MIOS_TIMER_Init
	extern _MIOS_MPROC_EVENT_TABLE
	extern _MIOS_ENC_PIN_TABLE
;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
FSR1L	equ	0xfe9 ;; normaly 0xfe1, changed by fixasm.pl
FSR2L	equ	0xfd9
POSTDEC1	equ	0xfed ;; normaly 0xfe5, changed by fixasm.pl
PREINC1	equ	0xfec ;; normaly 0xfe4, changed by fixasm.pl


	idata
_timer	db	0x00, 0x00
_timer24	db	0x00, 0x00
_play	db	0x00
_midiplay	db	0x00
_last	db	0x00


; Internal registers
.registers	udata_ovr	0x010
r0x00	res	1

udata_main_0	udata
_nbpulse	res	1

udata_main_1	udata
_nbpulse24	res	1

udata_main_2	udata
_nbtik	res	1

udata_main_3	udata
_nbstep	res	1

udata_main_4	udata
_nbpat	res	1

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_main__AIN_NotifyChange	code
_AIN_NotifyChange:
;	.line	240; main.c	void AIN_NotifyChange(unsigned char pin, unsigned int pin_value) __wparam
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	242; main.c	}
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__ENC_NotifyChange	code
_ENC_NotifyChange:
;	.line	233; main.c	void ENC_NotifyChange(unsigned char encoder, char incrementer) __wparam
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	235; main.c	}
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__DIN_NotifyToggle	code
_DIN_NotifyToggle:
;	.line	224; main.c	void DIN_NotifyToggle(unsigned char pin, unsigned char pin_value) __wparam
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	226; main.c	}
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__SR_Service_Finish	code
_SR_Service_Finish:
;	.line	214; main.c	void SR_Service_Finish(void) __wparam
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	216; main.c	}
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__SR_Service_Prepare	code
_SR_Service_Prepare:
;	.line	207; main.c	void SR_Service_Prepare(void) __wparam
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	209; main.c	}
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__MPROC_NotifyReceivedByte	code
_MPROC_NotifyReceivedByte:
;	.line	176; main.c	void MPROC_NotifyReceivedByte(unsigned char byte) __wparam
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVWF	r0x00
;	.line	180; main.c	switch(byte){
	MOVF	r0x00, W
	XORLW	0xf8
	BZ	_00227_DS_
	MOVF	r0x00, W
	XORLW	0xfa
	BZ	_00225_DS_
	MOVF	r0x00, W
	XORLW	0xfb
	BZ	_00225_DS_
	MOVF	r0x00, W
	XORLW	0xfc
	BZ	_00226_DS_
	BRA	_00231_DS_
_00225_DS_:
;	.line	186; main.c	midiplay=1;
	MOVLW	0x01
	BANKSEL	_midiplay
	MOVWF	_midiplay, B
;	.line	187; main.c	break;
	BRA	_00231_DS_
_00226_DS_:
;	.line	190; main.c	MIOS_LCD_CursorSet(0x00);
	MOVLW	0x00
	CALL	_MIOS_LCD_CursorSet
;	.line	191; main.c	MIOS_LCD_PrintCString("STOP      ");
	MOVLW	UPPER(__str_5)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_5)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_5)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
	BANKSEL	_midiplay
;	.line	192; main.c	midiplay=0;
	CLRF	_midiplay, B
;	.line	193; main.c	GB_INIT();
	CALL	_GB_INIT
;	.line	194; main.c	break;
	BRA	_00231_DS_
_00227_DS_:
	BANKSEL	_midiplay
;	.line	197; main.c	if(midiplay==1){
	MOVF	_midiplay, W, B
	XORLW	0x01
	BNZ	_00231_DS_
;	.line	198; main.c	SYNC24_PUSH();
	CALL	_SYNC24_PUSH
_00231_DS_:
;	.line	201; main.c	}
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__MPROC_NotifyTimeout	code
_MPROC_NotifyTimeout:
;	.line	169; main.c	void MPROC_NotifyTimeout(void) __wparam
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	171; main.c	}
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__MPROC_NotifyFoundEvent	code
_MPROC_NotifyFoundEvent:
;	.line	161; main.c	void MPROC_NotifyFoundEvent(unsigned entry, unsigned char evnt0, unsigned char evnt1, unsigned char evnt2) __wparam
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	163; main.c	}
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__MPROC_NotifyReceivedEvnt	code
_MPROC_NotifyReceivedEvnt:
;	.line	153; main.c	void MPROC_NotifyReceivedEvnt(unsigned char evnt0, unsigned char evnt1, unsigned char evnt2) __wparam
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	155; main.c	}
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__DISPLAY_Tick	code
_DISPLAY_Tick:
;	.line	146; main.c	void DISPLAY_Tick(void) __wparam
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	148; main.c	}
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__DISPLAY_Init	code
_DISPLAY_Init:
;	.line	135; main.c	void DISPLAY_Init(void) __wparam
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	137; main.c	MIOS_LCD_Clear();
	CALL	_MIOS_LCD_Clear
;	.line	138; main.c	MIOS_LCD_CursorSet(0x00);
	MOVLW	0x00
	CALL	_MIOS_LCD_CursorSet
;	.line	139; main.c	MIOS_LCD_PrintCString("Lsdj Slave Sync  ");
	MOVLW	UPPER(__str_4)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_4)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_4)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__Timer	code
_Timer:
;	.line	99; main.c	void Timer(void) __wparam
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
;	.line	103; main.c	char st=PORTCbits.RC2;
	CLRF	r0x00
	BTFSC	_PORTCbits, 2
	INCF	r0x00, F
;	.line	105; main.c	if(st!=last){
	MOVF	r0x00, W
	BANKSEL	_last
	XORWF	_last, W, B
	BZ	_00173_DS_
;	.line	106; main.c	if(st==1)SYNC24_PUSH();
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00173_DS_
	CALL	_SYNC24_PUSH
_00173_DS_:
;	.line	109; main.c	last=st;
	MOVFF	r0x00, _last
	BANKSEL	_play
;	.line	111; main.c	if(play == 0)return;// STOP
	MOVF	_play, W, B
	BZ	_00182_DS_
;	.line	113; main.c	if(timer24>1){//SEND SYNC24 PULSE OUT
	MOVLW	0x00
	BANKSEL	(_timer24 + 1)
	SUBWF	(_timer24 + 1), W, B
	BNZ	_00193_DS_
	MOVLW	0x02
; removed redundant BANKSEL
	SUBWF	_timer24, W, B
_00193_DS_:
	BNC	_00177_DS_
;	.line	114; main.c	timer24--;
	MOVLW	0xff
	BANKSEL	_timer24
	ADDWF	_timer24, F, B
	BC	_10272_DS_
; removed redundant BANKSEL
	DECF	(_timer24 + 1), F, B
_10272_DS_:
;	.line	115; main.c	PORTAbits.RA3 = 1;
	BSF	_PORTAbits, 3
	BRA	_00178_DS_
_00177_DS_:
;	.line	117; main.c	PORTAbits.RA3 = 0;
	BCF	_PORTAbits, 3
_00178_DS_:
;	.line	121; main.c	if(timer>1){
	MOVLW	0x00
	BANKSEL	(_timer + 1)
	SUBWF	(_timer + 1), W, B
	BNZ	_00194_DS_
	MOVLW	0x02
; removed redundant BANKSEL
	SUBWF	_timer, W, B
_00194_DS_:
	BNC	_00180_DS_
;	.line	122; main.c	timer--;
	MOVLW	0xff
	BANKSEL	_timer
	ADDWF	_timer, F, B
	BC	_20273_DS_
; removed redundant BANKSEL
	DECF	(_timer + 1), F, B
_20273_DS_:
	BRA	_00182_DS_
_00180_DS_:
	BANKSEL	_play
;	.line	124; main.c	play=0;
	CLRF	_play, B
;	.line	125; main.c	MIOS_MIDI_TxBufferPut(0xFC); // MIDI STOP
	MOVLW	0xfc
	CALL	_MIOS_MIDI_TxBufferPut
;	.line	126; main.c	GB_INIT();
	CALL	_GB_INIT
_00182_DS_:
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__Tick	code
_Tick:
;	.line	89; main.c	void Tick(void) __wparam
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	91; main.c	}
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__Init	code
_Init:
;	.line	62; main.c	void Init(void) __wparam
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	67; main.c	MIOS_TIMER_Init(0, 10000); // 1 mS / 100 nS = 10000 cycles	
	MOVLW	0x27
	MOVWF	POSTDEC1
	MOVLW	0x10
	MOVWF	POSTDEC1
	MOVLW	0x00
	CALL	_MIOS_TIMER_Init
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	70; main.c	ADCON1 = 0x07;
	MOVLW	0x07
	MOVWF	_ADCON1
;	.line	71; main.c	TRISA &= 0xd0;
	MOVLW	0xd0
	ANDWF	_TRISA, F
;	.line	72; main.c	TRISE &= 0xf8;
	MOVLW	0xf8
	ANDWF	_TRISE, F
;	.line	75; main.c	PORTAbits.RA0 = 0;//led 1
	BCF	_PORTAbits, 0
;	.line	76; main.c	PORTAbits.RA1 = 1;//led2
	BSF	_PORTAbits, 1
;	.line	77; main.c	PORTAbits.RA2 = 0;//sync24 runstop
	BCF	_PORTAbits, 2
;	.line	78; main.c	PORTAbits.RA3 = 0;//sync24 clock
	BCF	_PORTAbits, 3
;	.line	79; main.c	PORTAbits.RA5 = 0;//free -> no typo! RA4 is allocated by IIC
	BCF	_PORTAbits, 5
;	.line	80; main.c	PORTEbits.RE0 = 0;//free
	BCF	_PORTEbits, 0
;	.line	81; main.c	PORTEbits.RE1 = 0;//free
	BCF	_PORTEbits, 1
;	.line	82; main.c	PORTEbits.RE2 = 0;//free	
	BCF	_PORTEbits, 2
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__GB_INIT	code
_GB_INIT:
;	.line	36; main.c	void GB_INIT(void){// RESET
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	38; main.c	MIOS_LCD_CursorSet(0x00);
	MOVLW	0x00
	CALL	_MIOS_LCD_CursorSet
;	.line	39; main.c	MIOS_LCD_PrintCString("STOP NOW");
	MOVLW	UPPER(__str_3)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_3)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_3)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
	BANKSEL	_nbpulse
;	.line	40; main.c	nbpulse=0; 
	CLRF	_nbpulse, B
	BANKSEL	_nbtik
;	.line	41; main.c	nbtik=0;
	CLRF	_nbtik, B
	BANKSEL	_nbstep
;	.line	42; main.c	nbstep=0;
	CLRF	_nbstep, B
	BANKSEL	_nbpat
;	.line	43; main.c	nbpat=0;
	CLRF	_nbpat, B
;	.line	51; main.c	PORTAbits.RA0 = 0;//led 1
	BCF	_PORTAbits, 0
;	.line	52; main.c	PORTAbits.RA1 = 1;//led 2
	BSF	_PORTAbits, 1
;	.line	53; main.c	PORTAbits.RA2 = 0;//
	BCF	_PORTAbits, 2
;	.line	54; main.c	PORTAbits.RA3 = 0;//
	BCF	_PORTAbits, 3
;	.line	55; main.c	return;
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__SYNC24_PUSH	code
_SYNC24_PUSH:
;	.line	42; sync24.c	void SYNC24_PUSH(void){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	BANKSEL	_nbpulse
;	.line	44; sync24.c	nbpulse++;
	INCF	_nbpulse, F, B
	BANKSEL	_nbpulse24
;	.line	45; sync24.c	nbpulse24++;
	INCF	_nbpulse24, F, B
;	.line	49; sync24.c	if( (play == 1 && nbpulse24>=1) || (midiplay == 1 && nbpulse24>=1) ){
	CLRF	r0x00
	BANKSEL	_play
	MOVF	_play, W, B
	XORLW	0x01
	BNZ	_00139_DS_
	INCF	r0x00, F
_00139_DS_:
	MOVF	r0x00, W
	BZ	_00114_DS_
	MOVLW	0x01
	BANKSEL	_nbpulse24
	SUBWF	_nbpulse24, W, B
	BC	_00110_DS_
_00114_DS_:
	BANKSEL	_midiplay
	MOVF	_midiplay, W, B
	XORLW	0x01
	BNZ	_00111_DS_
	MOVLW	0x01
	BANKSEL	_nbpulse24
	SUBWF	_nbpulse24, W, B
	BNC	_00111_DS_
_00110_DS_:
	BANKSEL	_nbpulse24
;	.line	50; sync24.c	nbpulse24=0;
	CLRF	_nbpulse24, B
;	.line	51; sync24.c	timer24=4;//SYNC 24 Pulse length (ms) :)
	MOVLW	0x04
	BANKSEL	_timer24
	MOVWF	_timer24, B
; removed redundant BANKSEL
	CLRF	(_timer24 + 1), B
;	.line	54; sync24.c	PORTAbits.RA3 = 1;
	BSF	_PORTAbits, 3
_00111_DS_:
;	.line	58; sync24.c	if( (play == 1 && nbpulse>=3) || (midiplay == 1 && nbpulse>=3) ){	
	MOVF	r0x00, W
	BZ	_00125_DS_
	MOVLW	0x03
	BANKSEL	_nbpulse
	SUBWF	_nbpulse, W, B
	BC	_00121_DS_
_00125_DS_:
	BANKSEL	_midiplay
	MOVF	_midiplay, W, B
	XORLW	0x01
	BZ	_00146_DS_
	BRA	_00122_DS_
_00146_DS_:
	MOVLW	0x03
	BANKSEL	_nbpulse
	SUBWF	_nbpulse, W, B
	BTFSS	STATUS, 0
	BRA	_00122_DS_
_00121_DS_:
	BANKSEL	_nbpulse
;	.line	60; sync24.c	nbpulse=0;
	CLRF	_nbpulse, B
	BANKSEL	_nbtik
;	.line	61; sync24.c	nbtik++;
	INCF	_nbtik, F, B
;	.line	63; sync24.c	if(nbtik>=8){
	MOVLW	0x08
; removed redundant BANKSEL
	SUBWF	_nbtik, W, B
	BNC	_00116_DS_
; removed redundant BANKSEL
;	.line	64; sync24.c	nbtik=0;
	CLRF	_nbtik, B
	BANKSEL	_nbstep
;	.line	65; sync24.c	nbstep++;
	INCF	_nbstep, F, B
;	.line	66; sync24.c	PORTAbits.RA1 = 1;//LEDS
	BSF	_PORTAbits, 1
_00116_DS_:
;	.line	69; sync24.c	if(nbstep>=4){
	MOVLW	0x04
	BANKSEL	_nbstep
	SUBWF	_nbstep, W, B
	BNC	_00118_DS_
; removed redundant BANKSEL
;	.line	70; sync24.c	nbstep=0;
	CLRF	_nbstep, B
	BANKSEL	_nbpat
;	.line	71; sync24.c	nbpat++;
	INCF	_nbpat, F, B
;	.line	72; sync24.c	PORTAbits.RA0 = 1;//LEDS
	BSF	_PORTAbits, 0
_00118_DS_:
;	.line	75; sync24.c	if(nbtik>1){
	MOVLW	0x02
	BANKSEL	_nbtik
	SUBWF	_nbtik, W, B
	BNC	_00120_DS_
;	.line	76; sync24.c	PORTAbits.RA0 = 0;//LEDS
	BCF	_PORTAbits, 0
;	.line	77; sync24.c	PORTAbits.RA1 = 0;//LEDS
	BCF	_PORTAbits, 1
_00120_DS_:
;	.line	81; sync24.c	MIOS_LCD_CursorSet(0x00);
	MOVLW	0x00
	CALL	_MIOS_LCD_CursorSet
;	.line	82; sync24.c	MIOS_LCD_PrintCString("[");
	MOVLW	UPPER(__str_0)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_0)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_0)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
	BANKSEL	_nbtik
;	.line	83; sync24.c	MIOS_LCD_PrintBCD1(nbtik+1);//
	INCF	_nbtik, W, B
	MOVWF	r0x00
	MOVF	r0x00, W
	CALL	_MIOS_LCD_PrintBCD1
;	.line	84; sync24.c	MIOS_LCD_PrintCString("][");
	MOVLW	UPPER(__str_1)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_1)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_1)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
	BANKSEL	_nbstep
;	.line	85; sync24.c	MIOS_LCD_PrintBCD1(nbstep+1);//
	INCF	_nbstep, W, B
	MOVWF	r0x00
	MOVF	r0x00, W
	CALL	_MIOS_LCD_PrintBCD1
;	.line	86; sync24.c	MIOS_LCD_PrintCString("][");
	MOVLW	UPPER(__str_1)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_1)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_1)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
	BANKSEL	_nbpat
;	.line	87; sync24.c	MIOS_LCD_PrintBCD2(nbpat);//
	MOVF	_nbpat, W, B
	CALL	_MIOS_LCD_PrintBCD2
;	.line	88; sync24.c	MIOS_LCD_PrintCString("]");
	MOVLW	UPPER(__str_2)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_2)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_2)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
_00122_DS_:
	BANKSEL	_play
;	.line	93; sync24.c	if(play==0){
	MOVF	_play, W, B
	BNZ	_00127_DS_
;	.line	94; sync24.c	play=1;// PLAY
	MOVLW	0x01
; removed redundant BANKSEL
	MOVWF	_play, B
;	.line	95; sync24.c	PORTAbits.RA0 = 1;//LEDS
	BSF	_PORTAbits, 0
;	.line	96; sync24.c	PORTAbits.RA2 = 1;//new SYNC24 startstop PIN
	BSF	_PORTAbits, 2
;	.line	97; sync24.c	MIOS_MIDI_TxBufferPut(0xFA); // MIDI START
	MOVLW	0xfa
	CALL	_MIOS_MIDI_TxBufferPut
_00127_DS_:
;	.line	102; sync24.c	timer=100;// millisec
	MOVLW	0x64
	BANKSEL	_timer
	MOVWF	_timer, B
; removed redundant BANKSEL
	CLRF	(_timer + 1), B
;	.line	104; sync24.c	SEND_PULSE();
	CALL	_SEND_PULSE
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__SEND_PULSE	code
_SEND_PULSE:
;	.line	20; sync24.c	void SEND_PULSE(void){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	30; sync24.c	PORTDbits.RD4 = 1;    PORTDbits.RD4 = 0;
	BSF	_PORTDbits, 4
	BCF	_PORTDbits, 4
;	.line	31; sync24.c	PORTDbits.RD4 = 1;    PORTDbits.RD4 = 0;
	BSF	_PORTDbits, 4
	BCF	_PORTDbits, 4
;	.line	32; sync24.c	PORTDbits.RD4 = 1;    PORTDbits.RD4 = 0;
	BSF	_PORTDbits, 4
	BCF	_PORTDbits, 4
;	.line	33; sync24.c	PORTDbits.RD4 = 1;    PORTDbits.RD4 = 0;
	BSF	_PORTDbits, 4
	BCF	_PORTDbits, 4
;	.line	34; sync24.c	PORTDbits.RD4 = 1;    PORTDbits.RD4 = 0;
	BSF	_PORTDbits, 4
	BCF	_PORTDbits, 4
;	.line	35; sync24.c	PORTDbits.RD4 = 1;    PORTDbits.RD4 = 0;
	BSF	_PORTDbits, 4
	BCF	_PORTDbits, 4
;	.line	36; sync24.c	PORTDbits.RD4 = 1;    PORTDbits.RD4 = 0;
	BSF	_PORTDbits, 4
	BCF	_PORTDbits, 4
;	.line	37; sync24.c	PORTDbits.RD4 = 1;    PORTDbits.RD4 = 0;
	BSF	_PORTDbits, 4
	BCF	_PORTDbits, 4
;	.line	38; sync24.c	return;
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
__str_0:
	DB	0x5b, 0x00
; ; Starting pCode block
__str_1:
	DB	0x5d, 0x5b, 0x00
; ; Starting pCode block
__str_2:
	DB	0x5d, 0x00
; ; Starting pCode block
__str_3:
	DB	0x53, 0x54, 0x4f, 0x50, 0x20, 0x4e, 0x4f, 0x57, 0x00
; ; Starting pCode block
__str_4:
	DB	0x4c, 0x73, 0x64, 0x6a, 0x20, 0x53, 0x6c, 0x61, 0x76, 0x65, 0x20, 0x53
	DB	0x79, 0x6e, 0x63, 0x20, 0x20, 0x00
; ; Starting pCode block
__str_5:
	DB	0x53, 0x54, 0x4f, 0x50, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x00


; Statistics:
; code size:	  902 (0x0386) bytes ( 0.69%)
;           	  451 (0x01c3) words
; udata size:	    5 (0x0005) bytes ( 0.39%)
; access size:	    1 (0x0001) bytes


	end
