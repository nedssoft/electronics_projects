org 00h
lcdda equ p2
keyp equ p1
rs bit p3.0
e bit p3.1
mov keyp,#0ffh
mov lcdda,#00h

start:	
	call initLCD
scan:
col1:	mov keyp,#7fh
	mov a,keyp
chek:   cjne a,#7eh,chek1
	mov a,#'1'
	call dwr
chek1:	cjne a,#7dh,chek2
	mov a,#'5'
	call dwr
chek2:	cjne a,#7bh,chek3
	mov a,#'9'
	call dwr
chek3:	cjne a,#77h,col2
	mov a,#'C'
	call dwr
col2:	mov keyp,#0bfh
	mov a,keyp
chek4:	cjne a,#0beh,chek5
	mov a,#'2'
	call dwr
chek5:	cjne a,#0bdh,chek6
	mov a,#'6'
	call dwr
chek6:	cjne a,#0bbh,chk7
	mov a,#'0'
	call dwr
chk7:	cjne a,#0b7h,col3
	mov a,#'D'
	call dwr
col3:	mov keyp,#0dfh
	mov a,keyp
chk8:	cjne a,#0deh,chk9
	mov a,#'3'
	call dwr
chk9:	cjne a,#0ddh,here
	mov a,#'7'
	call dwr
here:	cjne a,#0dbh,here1
	mov a,#'A'
	call dwr
here1:	cjne a,#0d7h,col4
	mov a,#'*'
	call dwr
col4:	mov keyp,#0efh
	mov a,keyp
here2:	cjne a,#0eeh,here3
	mov a,#'4'
	call dwr
here3:	cjne a,#0edh,here4
	mov a,#'8'
	call dwr
here4:	cjne a,#0ebh,here5
	mov a,#'B'
	call dwr
here5:	cjne a,#0e7h,final
	mov a,#'#'
	call dwr
final:	ljmp scan

initLCD:
	mov a,#38h
	acall cmdr
	acall delay
	mov a,#01h
	acall cmdr
	acall delay
	mov a,#0fh
	acall cmdr
	acall delay
	mov a,#80h
	acall cmdr
	acall delay
	ret
cmdr:	mov lcdda,a
	clr rs
	setb e
	acall delay
	clr e
	ret
dwr:	mov lcdda,a
	setb rs
	setb e
	acall delay
	clr e
	call stay
	ret
delay:	
PET:	Mov R1,#231
    	Mov R2,#39
MEG:	Djnz R1,MEG
    	Djnz R2,MEG
	Ret
stay:	
PET1:	Mov R1,#124
    	Mov R2,#154
    	Mov R3,#8
MEG1:	Djnz R1,MEG1
    	Djnz R2,MEG1
    	Djnz R3,MEG1
	Ret
	end
	

	
		 
