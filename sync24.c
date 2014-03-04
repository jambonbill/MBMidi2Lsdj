

unsigned char nbpulse;
unsigned char nbpulse24;

unsigned char nbtik;//LSDJ TIK (or equivalent)
unsigned char nbstep;//LSDJ STEPS
unsigned char nbpat;//LSDJ PAT NUM

unsigned int timer = 0;
unsigned int timer24 = 0;

unsigned char play = 0;//BOOL IS PLAYING
unsigned char midiplay = 0;//BOOL midi realtime message -> play/stop


/**
 * Send a lsdj sync bute on RD4 (j6 or j9?)
 */
 void SEND_PULSE(void){

	// LSDJ SYNC !!!
	
	/*
	for(int i=0;i<8,i++){
		PORTDbits.RD4 = 1;    PORTDbits.RD4 = 0;	
	}
	*/
	
	PORTDbits.RD4 = 1;    PORTDbits.RD4 = 0;
	PORTDbits.RD4 = 1;    PORTDbits.RD4 = 0;
	PORTDbits.RD4 = 1;    PORTDbits.RD4 = 0;
	PORTDbits.RD4 = 1;    PORTDbits.RD4 = 0;
	PORTDbits.RD4 = 1;    PORTDbits.RD4 = 0;
	PORTDbits.RD4 = 1;    PORTDbits.RD4 = 0;
	PORTDbits.RD4 = 1;    PORTDbits.RD4 = 0;
	PORTDbits.RD4 = 1;    PORTDbits.RD4 = 0;
	return;
}


void SYNC24_PUSH(void){

	nbpulse++;
	nbpulse24++;

	//if(nbpulse24>=2){
	
	if( (play == 1 && nbpulse24>=1) || (midiplay == 1 && nbpulse24>=1) ){
		nbpulse24=0;
		timer24=4;//SYNC 24 Pulse length (ms) :)
		//MIOS_DOUT_PinSet1(1);//SYNC24 CLOCK PIN
		//PORTCbits.RC0=1;//new SYNC24 CLOCK PIN
		PORTAbits.RA3 = 1;
	}
	

	if( (play == 1 && nbpulse>=3) || (midiplay == 1 && nbpulse>=3) ){	
		
		nbpulse=0;
		nbtik++;
		
		if(nbtik>=8){
			nbtik=0;
			nbstep++;
			PORTAbits.RA1 = 1;//LEDS
		}

		if(nbstep>=4){
			nbstep=0;
			nbpat++;
			PORTAbits.RA0 = 1;//LEDS
		}

		if(nbtik>1){
			PORTAbits.RA0 = 0;//LEDS
			PORTAbits.RA1 = 0;//LEDS
		}

		//DISPLAY POSITION (based on 4/4)
		MIOS_LCD_CursorSet(0x00);
		MIOS_LCD_PrintCString("[");
		MIOS_LCD_PrintBCD1(nbtik+1);//
		MIOS_LCD_PrintCString("][");
		MIOS_LCD_PrintBCD1(nbstep+1);//
		MIOS_LCD_PrintCString("][");
		MIOS_LCD_PrintBCD2(nbpat);//
		MIOS_LCD_PrintCString("]");

	}

	// INIT DELAY //
	if(play==0){
		play=1;// PLAY
		PORTAbits.RA0 = 1;//LEDS
		PORTAbits.RA2 = 1;//new SYNC24 startstop PIN
		MIOS_MIDI_TxBufferPut(0xFA); // MIDI START
	}

	

	timer=100;// millisec
	//MIOS_MIDI_TxBufferPut(0xF8); // SEND MIDI REALTIME CLOCK
	SEND_PULSE();
}






