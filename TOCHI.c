     sbit green at p2_0_bit;
    sbit blue at p2_2_bit;
    sbit yellow at p2_4_bit;
     sbit red at p2_6_bit;
void main() {

 P1=0xff;
 p2=0x00 ;
 p2=0xff;
  for(;;){
   if (p1==0xea){
       green =0;
       blue=1;
       red=1;
       yellow=1;
   }
   else
   if(p1==0xeb)
   {
    green =1;
       blue=0;
       yellow=1 ;
       red=1;
   }
   else
   if(p1==0xef)
    {
    green =1;
       blue=1;
       yellow=0;
       red=1 ;}
        else
   if(p1==0xff) {
    green =1;
       blue=1;
       yellow=1;
       red=0;
       do
       p2_7_bit=1 ;
       while(p1!=0xea);
        p2_7_bit=0;
       
   }
  
  }
 
}