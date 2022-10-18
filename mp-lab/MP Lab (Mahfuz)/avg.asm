.MODEL SMALL
.DATA
VAL DB ?
MSG1 DB 10,13,'ENTER THE NUMBER YOU WANT: $'
MSG2 DB 10,13,'THE NUMBER ARE:','$'
MSG3 DB 10,13,'AVERAGE: $'  
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    LEA DX,MSG1
    MOV AH,9
    INT 21H
    
    MOV AH,1
    INT 21H
    SUB AL,30H
    
    MOV CL,AL
    MOV BL,AL
    MOV AL,00
    MOV VAL,AL
    
    LBL1:
    LEA DX,MSG2
    MOV AH,9
    INT 21H
    
    MOV AH,1
    INT 21H
    SUB AL,30H 
    
    ADD AL,VAL
    MOV VAL,AL
    LOOP LBL1
    
    LBL2: 
    LEA DX,MSG3
    MOV AH,9
    INT 21H 
    
    MOV AX,00
    MOV AL,VAL
    DIV BL
    ADD AX,3030H
    MOV DX,AX
    MOV AH,2
    INT 21H 
    
    MOV AH,4CH
    INT 21H
    
MAIN ENDP
    END MAIN
 
    
    
    