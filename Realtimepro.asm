
_main:

;Realtimepro.c,21 :: 		void main() {
;Realtimepro.c,22 :: 		Adc_Init();
	CALL       _ADC_Init+0
;Realtimepro.c,23 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;Realtimepro.c,24 :: 		lcd_cmd(_lcd_clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Realtimepro.c,25 :: 		lcd_cmd(_lcd_cursor_off);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Realtimepro.c,26 :: 		lcd_out(1,3,"TEMPERATURE:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_Realtimepro+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Realtimepro.c,27 :: 		lcd_chr(2,9,223);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      9
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      223
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;Realtimepro.c,28 :: 		lcd_chr(2,10,'C');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      10
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      67
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;Realtimepro.c,29 :: 		while(1){
L_main0:
;Realtimepro.c,30 :: 		dig_temp=Adc_Read(0); // lm35 o/p @ RA1
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _dig_temp+0
;Realtimepro.c,31 :: 		analog= (dig_temp*5)/1023 ;   //converts back to analog
	MOVLW      5
	MOVWF      R4+0
	CALL       _Mul_8X8_U+0
	MOVLW      255
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	CALL       _int2double+0
	MOVF       R0+0, 0
	MOVWF      _analog+0
	MOVF       R0+1, 0
	MOVWF      _analog+1
	MOVF       R0+2, 0
	MOVWF      _analog+2
	MOVF       R0+3, 0
	MOVWF      _analog+3
;Realtimepro.c,32 :: 		temp= analog*100;
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
;Realtimepro.c,33 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	NOP
;Realtimepro.c,34 :: 		display();
	CALL       _display+0
;Realtimepro.c,36 :: 		}}
	GOTO       L_main0
L_end_main:
	GOTO       $+0
; end of _main

_display:

;Realtimepro.c,37 :: 		void display(){
;Realtimepro.c,39 :: 		y = temp/100;
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _temp+0, 0
	MOVWF      R0+0
	MOVF       _temp+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
;Realtimepro.c,40 :: 		lcd_chr(2,6,48+y);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      6
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       R0+0, 0
	ADDLW      48
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;Realtimepro.c,41 :: 		y= (temp%100)/10;
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
;Realtimepro.c,42 :: 		lcd_chr(2,7,48+y);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      7
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       R0+0, 0
	ADDLW      48
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;Realtimepro.c,43 :: 		y = temp%10;
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
;Realtimepro.c,44 :: 		lcd_chr(2,8,48+y);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       R0+0, 0
	ADDLW      48
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;Realtimepro.c,46 :: 		}
L_end_display:
	RETURN
; end of _display
