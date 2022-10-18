.MODEL SMALL
.STACK 100H
.DATA

MSG1 DB 10,13,'Enter the uppercase letter: $'
MSG2 DB 10,13,'The lowercase letter is: $'

.CODE
MAIN PROC     
    MOV AX,@DATA
    MOV DS,AX
    
    
    MOV AH,9
    LEA DX,MSG1
    INT 21H    
    
    MOV AH,1
    INT 21H
    
    MOV BL,AL
    
    MOV AH,9
    LEA DX,MSG2
    INT 21H
    
    MOV AH,2
    SUB AL BL
    MOV DL,BL
    INT 21H
    
    
    MOV AH,4CH
    INT 21H
    
    MAIN ENDP
END MAIN