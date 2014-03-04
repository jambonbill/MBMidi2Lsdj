/*
 * MIOS SDCC Wrapper
 *
 * ==========================================================================
 *
 *  MBGB SYNC "RC2" VERSION 
 *  Copyright (C) 2008 sidabitball (<jambonbill at gmail dot com>)
 *  Licensed for personal non-commercial use only.
 *  All other rights reserved.
 * 
 * ==========================================================================
 */

/*

By using these pins, you don't need to modify the TRISx configuration, just use (for example)
   PORTCbits.RC0 = 1;
to set the pin to 5V, and
   PORTCbits.RC0 = 0;
to set the pin to 0V

Same for RC1:
   PORTCbits.RC1 = 1; // 5V
   PORTCbits.RC1 = 0; // 0V

*/


#include "cmios.h"
#include "pic18f452.h"
//#include "gb.c"
#include "sync24.c"



void GB_INIT(void){// RESET

	MIOS_LCD_CursorSet(0x00);
	MIOS_LCD_PrintCString("STOP NOW");
	nbpulse=0; 
	nbtik=0;
	nbstep=0;
	nbpat=0;
	
	/*
	MIOS_DOUT_PinSet0(0);// SYNC24 STOP
	MIOS_DOUT_PinSet0(5);// GREEN LED
	MIOS_DOUT_PinSet1(6);// RED LED
	*/
	
	PORTAbits.RA0 = 0;//led 1
	PORTAbits.RA1 = 1;//led 2
	PORTAbits.RA2 = 0;//
	PORTAbits.RA3 = 0;//
	return;
}

/////////////////////////////////////////////////////////////////////////////
// This function is called by MIOS after startup to initialize the 
// application
/////////////////////////////////////////////////////////////////////////////
void Init(void) __wparam
{

	// Touch sensor sensitivity *must* be 0, otherwise Port D.4 (CORE::J14) cannot be used as Clock Output
	//MIOS_SRIO_TS_SensitivitySet(0);    // disable touch sensors
	MIOS_TIMER_Init(0, 10000); // 1 mS / 100 nS = 10000 cycles	
	
	// ENABLE J5 OUTPUT
	ADCON1 = 0x07;
	TRISA &= 0xd0;
	TRISE &= 0xf8;

	// TEST //
	PORTAbits.RA0 = 0;//led 1
	PORTAbits.RA1 = 1;//led2
	PORTAbits.RA2 = 0;//sync24 runstop
	PORTAbits.RA3 = 0;//sync24 clock
	PORTAbits.RA5 = 0;//free -> no typo! RA4 is allocated by IIC
	PORTEbits.RE0 = 0;//free
	PORTEbits.RE1 = 0;//free
	PORTEbits.RE2 = 0;//free	

}

/////////////////////////////////////////////////////////////////////////////
// This function is called by MIOS in the mainloop when nothing else is to do
/////////////////////////////////////////////////////////////////////////////
void Tick(void) __wparam
{
}

/////////////////////////////////////////////////////////////////////////////
// This function is periodically called by MIOS. The frequency has to be
// initialized with MIOS_Timer_Set
/////////////////////////////////////////////////////////////////////////////
char last=0;

void Timer(void) __wparam
{

	//GET RC2 STATUS
	char st=PORTCbits.RC2;
	
	if(st!=last){
		if(st==1)SYNC24_PUSH();
	}

	last=st;

	if(play == 0)return;// STOP

	if(timer24>1){//SEND SYNC24 PULSE OUT
		timer24--;
		PORTAbits.RA3 = 1;
	}else{
		PORTAbits.RA3 = 0;
	}


	if(timer>1){
		timer--;
	}else{
		play=0;
		MIOS_MIDI_TxBufferPut(0xFC); // MIDI STOP
		GB_INIT();
	}
}

/////////////////////////////////////////////////////////////////////////////
// This function is called by MIOS when the display content should be 
// initialized. Thats the case during startup and after a temporary message
// has been printed on the screen
/////////////////////////////////////////////////////////////////////////////
void DISPLAY_Init(void) __wparam
{
  MIOS_LCD_Clear();
  MIOS_LCD_CursorSet(0x00);
  MIOS_LCD_PrintCString("Lsdj Slave Sync  ");
}

/////////////////////////////////////////////////////////////////////////////
//  This function is called in the mainloop when no temporary message is shown
//  on screen. Print the realtime messages here
/////////////////////////////////////////////////////////////////////////////
void DISPLAY_Tick(void) __wparam
{
}

/////////////////////////////////////////////////////////////////////////////
//  This function is called by MIOS when a complete MIDI event has been received
/////////////////////////////////////////////////////////////////////////////
void MPROC_NotifyReceivedEvnt(unsigned char evnt0, unsigned char evnt1, unsigned char evnt2) __wparam
{
}

/////////////////////////////////////////////////////////////////////////////
// This function is called by MIOS when a MIDI event has been received
// which has been specified in the MIOS_MPROC_EVENT_TABLE
/////////////////////////////////////////////////////////////////////////////
void MPROC_NotifyFoundEvent(unsigned entry, unsigned char evnt0, unsigned char evnt1, unsigned char evnt2) __wparam
{
}

/////////////////////////////////////////////////////////////////////////////
// This function is called by MIOS when a MIDI event has not been completly
// received within 2 seconds
/////////////////////////////////////////////////////////////////////////////
void MPROC_NotifyTimeout(void) __wparam
{
}

/////////////////////////////////////////////////////////////////////////////
// This function is called by MIOS when a MIDI byte has been received
/////////////////////////////////////////////////////////////////////////////
void MPROC_NotifyReceivedByte(unsigned char byte) __wparam
{

	// MIDI SYNC IN ! ( -> MAKE IT SYNC 24 !!)
	switch(byte){

		case 0xFA://MIDI start 0xFA
		case 0xFB://MIDI start 0xFA
			//MIOS_LCD_CursorSet(0x00);
			//MIOS_LCD_PrintCString("START");
			midiplay=1;
			break;
		
		case 0xFC://MIDI Stop 0xFC
			MIOS_LCD_CursorSet(0x00);
			MIOS_LCD_PrintCString("STOP      ");
			midiplay=0;
			GB_INIT();
			break;
		
		case 0xF8://MIDI CLOCK
			if(midiplay==1){
				SYNC24_PUSH();
			}
			break;
	}
}

/////////////////////////////////////////////////////////////////////////////
// This function is called by MIOS before the shift register are loaded
/////////////////////////////////////////////////////////////////////////////
void SR_Service_Prepare(void) __wparam
{
}

/////////////////////////////////////////////////////////////////////////////
// This function is called by MIOS after the shift register have been loaded (every ms)
/////////////////////////////////////////////////////////////////////////////
void SR_Service_Finish(void) __wparam
{
}

/////////////////////////////////////////////////////////////////////////////
// This function is called by MIOS when an button has been toggled
// pin_value is 1 when button released, and 0 when button pressed
/////////////////////////////////////////////////////////////////////////////


void DIN_NotifyToggle(unsigned char pin, unsigned char pin_value) __wparam
{
}

/////////////////////////////////////////////////////////////////////////////
// This function is called by MIOS when an encoder has been moved
// incrementer is positive when encoder has been turned clockwise, else
// it is negative
/////////////////////////////////////////////////////////////////////////////
void ENC_NotifyChange(unsigned char encoder, char incrementer) __wparam
{
}

/////////////////////////////////////////////////////////////////////////////
// This function is called by MIOS when a pot has been moved
/////////////////////////////////////////////////////////////////////////////
void AIN_NotifyChange(unsigned char pin, unsigned int pin_value) __wparam
{
}
