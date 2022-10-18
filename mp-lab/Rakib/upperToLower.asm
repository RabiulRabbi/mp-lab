.MODEL SMALL
.STACK 100H
.DATA
MSG DB 'Enter a upper case: $'
MSG1 DB 10,13, 'In lower case: '
MSG2 DB ?, '$'
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX  
    
    LEA DX,MSG
    MOV AH,9
    INT 21h 
    
    MOV AH,1
    INT 21H
    SUB AL,0H   
    
    ADD AL,20H  
    
    MOV MSG2,AL 
    
    LEA DX,MSG1
    MOV AH,9
    INT 21h 
    
    MOV AH, 4CH
    INT 21h
    MAIN ENDP
END MAIN