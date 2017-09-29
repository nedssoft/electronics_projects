
_main:

;real.c,21 :: 		void main() {
;real.c,23 :: 		Adc_Init();
	CALL       _ADC_Init+0
;real.c,24 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;real.c,25 :: 		trisc=0;
	CLRF       TRISC+0
;real.c,26 :: 		portc=0x00;
	CLRF       PORTC+0
;real.c,27 :: 		lcd_cmd(_lcd_clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;real.c,28 :: 		lcd_cmd(_lcd_cursor_off);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;real.c,29 :: 		lcd_out(1,1,"...DIGITAL...");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_real+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;real.c,30 :: 		lcd_out(2,3,"THERMOMETER");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_real+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;real.c,31 :: 		delay_ms(3000);
	MOVLW      31
	MOVWF      R11+0
	MOVLW      113
	MOVWF      R12+0
	MOVLW      30
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	DECFSZ     R11+0, 1
	GOTO       L_main0
	NOP
;real.c,32 :: 		lcd_cmd(_lcd_clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;real.c,37 :: 		lcd_out(1,3,"TEMPERATURE:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_real+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;real.c,38 :: 		lcd_chr(2,9,223);  // 223 is the ascii code for deg
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      9
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      223
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;real.c,39 :: 		lcd_chr(2,10,'C');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      10
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      67
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;real.c,40 :: 		porta=0;
	CLRF       PORTA+0
;real.c,41 :: 		while(1){
L_main1:
;real.c,42 :: 		portc.f1=1;
	BSF        PORTC+0, 1
;real.c,43 :: 		ReadTemp();
	CALL       _ReadTemp+0
;real.c,44 :: 		displayTemp();
	CALL       _displayTemp+0
;real.c,46 :: 		}}
	GOTO       L_main1
L_end_main:
	GOTO       $+0
; end of _main

_ReadTemp:

;real.c,48 :: 		void ReadTemp() {
;real.c,49 :: 		dgtl= adc_read(1);
	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	CALL       _word2double+0
	MOVF       R0+0, 0
	MOVWF      _dgtl+0
	MOVF       R0+1, 0
	MOVWF      _dgtl+1
	MOVF       R0+2, 0
	MOVWF      _dgtl+2
	MOVF       R0+3, 0
	MOVWF      _dgtl+3
;real.c,50 :: 		anlg= (dgtl*5)/1023;
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      192
	MOVWF      R4+1
	MOVLW      127
	MOVWF      R4+2
	MOVLW      136
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _anlg+0
	MOVF       R0+1, 0
	MOVWF      _anlg+1
	MOVF       R0+2, 0
	MOVWF      _anlg+2
	MOVF       R0+3, 0
	MOVWF      _anlg+3
;real.c,51 :: 		temp=anlg*100;
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      72
	MOVWF      R4+2
	MOVLW      133
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	CALL       _double2int+0
	MOVF       R0+0, 0
	MOVWF      _temp+0
	MOVF       R0+1, 0
	MOVWF      _temp+1
;real.c,52 :: 		}
L_end_ReadTemp:
	RETURN
; end of _ReadTemp

_displayTemp:

;real.c,53 :: 		void displayTemp(){
;real.c,55 :: 		x=temp/100;
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _temp+0, 0
	MOVWF      R0+0
	MOVF       _temp+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
;real.c,56 :: 		lcd_chr(2,6,48+x);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      6
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       R0+0, 0
	ADDLW      48
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;real.c,57 :: 		x=(temp%100)/10;
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _temp+0, 0
	MOVWF      R0+0
	MOVF       _temp+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
;real.c,58 :: 		lcd_chr(2,7,48+x);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      7
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       R0+0, 0
	ADDLW      48
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;real.c,59 :: 		x=temp%10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _temp+0, 0
	MOVWF      R0+0
	MOVF       _temp+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
;real.c,60 :: 		lcd_chr(2,8,48+x);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       R0+0, 0
	ADDLW      48
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;real.c,62 :: 		}
L_end_displayTemp:
	RETURN
; end of _displayTemp
