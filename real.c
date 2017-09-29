       sbit LCD_RS at RB0_bit ;
       sbit LCD_EN at RB1_bit   ;
       sbit   LCD_D4 at RB2_bit  ;
       sbit  LCD_D5 at RB3_bit  ;
       sbit  LCD_D6 at RB4_bit   ;
       sbit  LCD_D7 at RB5_bit  ;

       sbit LCD_RS_Direction at TRISB0_bit ;
       sbit LCD_EN_Direction at TRISB1_bit  ;
       sbit   LCD_D4_Direction at TRISB2_bit ;
       sbit  LCD_D5_Direction at TRISB3_bit   ;
       sbit  LCD_D6_Direction at TRISB4_bit  ;
       sbit  LCD_D7_Direction at TRISB5_bit ;
       //End of lcd module connection
 float dgtl,anlg;
int temp;

void ReadTemp();
 void displayTemp();

void main() {
//temp=28;
Adc_Init();
Lcd_Init();
trisc=0;
portc=0x00;
  lcd_cmd(_lcd_clear);
  lcd_cmd(_lcd_cursor_off);
  lcd_out(1,1,"...DIGITAL...");
  lcd_out(2,3,"THERMOMETER");
  delay_ms(3000);
  lcd_cmd(_lcd_clear);
//lcd_out(1,1,"DESIGNED BY:");
//lcd_out(2,1,"ORIE C. & EJIM C.");
//delay_ms(3000);
//lcd_cmd(_lcd_clear);
    lcd_out(1,3,"TEMPERATURE:");
    lcd_chr(2,9,223);  // 223 is the ascii code for deg
lcd_chr(2,10,'C');
porta=0;
  while(1){
  portc.f1=1;
  ReadTemp();
 displayTemp();
// temp=27;
}}

void ReadTemp() {
 dgtl= adc_read(1);
  anlg= (dgtl*5)/1023;
  temp=anlg*100;
}
 void displayTemp(){
unsigned char x;
x=temp/100;
lcd_chr(2,6,48+x);
x=(temp%100)/10;
lcd_chr(2,7,48+x);
x=temp%10;
lcd_chr(2,8,48+x);

}