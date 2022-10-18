.MODEL SMALL
.STACK 100H
.DATA 
MSG1 DB "ENTER LOWERCASE LETTER: $"
MSG2 DB 10,13,"UPPERCASE lETTER: $"

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
    SUB BL,32
    MOV DL,BL
    INT 21H
    
    MOV AH,4CH
    INT 21H
    MAIN ENDP
END MAIN

