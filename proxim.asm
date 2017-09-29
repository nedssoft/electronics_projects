 org 00h
 sens bit p1.0
 limit_open bit p1.1
 limit_close bit p1.2
 open bit p2.0
 close bit p2.1
 mov p1, #0ffh
 mov p2, #00h
 
 start:	
 sense: 	jb sens,sense
 		call delay
 		setb open
 LimitOpen:	jb limit_open,LimitOpen
 		call delay
 		clr open
 		call delay_1s
 		setb close
 stop:		jb  limit_close,stop
 		call delay
 		clr close
 		jmp start
 delay_1s:	
 		PET:Mov R1,#251
    		Mov R2,#51
    		Mov R3,#16
MEG:		Djnz R1,MEG
    		Djnz R2,MEG
    		Djnz R3,MEG
		Ret
delay:		
PET1:		Mov R1,#22
    		Mov R2,#134
    		Mov R3,#2
MEG1:		Djnz R1,MEG1
    		Djnz R2,MEG1
    		Djnz R3,MEG1
		Ret		
		end				
 			
 