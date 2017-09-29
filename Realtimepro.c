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
        char *text;
        int i;
 unsigned char dig_temp;
 int temp;
float analog;
void display();

void main() {
Adc_Init();
Lcd_Init();
  lcd_cmd(_lcd_clear);
  lcd_cmd(_lcd_cursor_off);
    lcd_out(1,3,"TEMPERATURE:");
    lcd_chr(2,9,223);
lcd_chr(2,10,'C');
  while(1){
  dig_temp=Adc_Read(0); // lm35 o/p @ RA1
  analog= (dig_temp*5)/1023 ;   //converts back to analog
   temp= analog*100;
   delay_ms(10);
display();

}}
void display(){
unsigned char y;
y = temp/100;
lcd_chr(2,6,48+y);
y= (temp%100)/10;
lcd_chr(2,7,48+y);
y = temp%10;
lcd_chr(2,8,48+y);

}