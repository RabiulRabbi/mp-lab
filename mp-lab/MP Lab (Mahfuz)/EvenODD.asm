.MODEL SMALL
.STACK 100H
.DATA 
VAL DB 10,13,'THE NUMBER: $'
MSG1 DB 10,13,'THE NUMBER IS EVEN $'
MSG2 DB 10,13,'THE NUMBER IS ODD $'
.CODE
MAIN PROC
MOV AX,@DATA
MOV DS,AX

LEA DX,VAL
MOV AH,9
INT 21H

MOV AH,1
INT 21H
MOV BX,2
DIV BX
CMP DX,0H
JZ EVEN
JNE ODD

EVEN:
LEA DX,MSG1
MOV AH,9
INT 21H 
JMP EXIT

ODD:
LEA DX,MSG2
MOV AH,9
INT 21H 

EXIT:
MOV AH,4CH
INT 21H

MAIN ENDP
END MAIN
