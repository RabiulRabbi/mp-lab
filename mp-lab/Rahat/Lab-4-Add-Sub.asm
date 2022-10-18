.MODEL SMALL
.STACK 100H
.DATA

    A   DB  ?
    B   DB  ?
    
    MSG1    DB  'Enter the first number: $'
    MSG2    DB  10,13,'Enter the second number: $'
    MSG3    DB  10,13,'Result of ADDITION: $'
    MSG4    DB  10,13,'Result of SUBTRACTION: $'


.CODE

MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AH, 9
    LEA DX, MSG1    
    INT 21H
    
    MOV BH, 0               ; initialize BH as 0 for previous digit
    MOV BL, 10D                 ; store 10 in BL to multiply and make number

INPUT1:

    MOV AH, 1
    INT 21H
    
    CMP AL, 13D             ; check if ENTER is pressed (input is carriage-return or 13D)
    JE SECOND                   ; then take second number 

NUMBER1:
                            
    SUB AL, 30H             ; make the number decimal range
    MOV CL, AL                  ; store AL in CL
    MOV AL, BH              ; get the previous digit in AL
    
    MUL BL                  ; multiply with 10 to make it tenth (or doshok)
    ADD AL, CL                  ; add doshok and ekok to combine number
    MOV BH, AL              ; store number in BH as previous number
    
    JMP INPUT1              ; take input as long as ENTER is not pressed
    
SECOND:
    
    MOV A, BH               ; store the first number in A
    
    MOV AH, 9
    LEA DX, MSG2    
    INT 21H
    
    MOV BH, 0               ; initialize BH as 0 for previous digit
    MOV BL, 10D                 ; store 10 in BL to multiply and make number

INPUT2:

    MOV AH, 1
    INT 21H
    
    CMP AL, 13D             ; check if ENTER is pressed (input is carriage-return or 13D)
    JE CALCULATE

NUMBER2:
                            
    SUB AL, 30H             ; make the number decimal range
    MOV CL, AL                  ; store AL in CL
    MOV AL, BH              ; get the previous digit in AL
    
    MUL BL                  ; multiply with 10 to make it tenth (or doshok)
    ADD AL, CL                  ; add doshok and ekok to combine number
    MOV BH, AL              ; store number in BH as previous number
    
    JMP INPUT2              ; take input as long as ENTER is not pressed
    
    
CALCULATE:
                            
    MOV B, BH               ; store the second number in B
                                
    MOV AX, 0                   ; clear AX register
    MOV AL, A               ; copy AL in A
    
    ADD AL, B               ; add the numbers and store it in AL
    AAM                         ; adjust the number in AH and AL
    
    MOV BL, AL              ; copy second digit in BL
    MOV BH, AH                  ; copy first digit in BH
    
    MOV AH, 9
    LEA DX, MSG3
    INT 21H
    
    MOV AH, 2               ; print 1st digit
    MOV DL, BH
    ADD DL, 30H
    INT 21H
    
    MOV AH, 2               ; print 2nd digit
    MOV DL, BL
    ADD DL, 30H
    INT 21H    
    
    MOV AX, 0               ; clear AX register
    MOV AL, A                   ; copy AL in A
    
    SUB AL, B               ; subtract the numbers and store it in AL
    AAM                         ; adjust the number in AH and AL
    
    MOV BL, AL              ; copy second digit in BL
    MOV BH, AH                  ; copy first digit in BH
    
    MOV AH, 9
    LEA DX, MSG4
    INT 21H
    
    MOV AH, 2               ; print 1st digit
    MOV DL, BH
    ADD DL, 30H
    INT 21H
    
    MOV AH, 2                ; print 2nd digit
    MOV DL, BL
    ADD DL, 30H
    INT 21H
                            
        
EXIT:
    
    MOV AH, 4CH
    INT 21H
    MAIN ENDP
END MAIN
    
    
    