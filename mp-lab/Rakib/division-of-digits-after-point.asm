.MODEL SMALL
.STACK 100H
.DATA

    A   DB  ?
    B   DB  ?
    
    D1  DB  ?
    D2  DB  ?
    D3  DB  ?
    
    MSG1    DB  'Enter the first number: $'
    MSG2    DB  10,13,'Enter the second number: $'
    MSG3    DB  10,13,'Result of DIVISION: $'


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
    
    MOV AH, 9
    LEA DX, MSG3            ; printing the result message 
    INT 21H
                                
    MOV AX, 0               ; clear AX register
    MOV AL, A                   ; copy AL in A
    
    DIV B                   ; divide the numbers and store it in AL  
    
    MOV BH, AH              ; storing the remainder in BH for calculating after decimal point
    
    
DISPLAY:
        
    MOV DL, 100D            ; to divide the number with 100 & extracting the 1st digit
    
    MOV AH, 0
    DIV DL                  ; divide the number with 100
    MOV D1, AL                  ; store the 1st digit from AL to D1
    
    MOV DL, 10D             ; to divide the number with 10 & extract the 2nd digit
   
    MOV AL, AH              ; load the rest of the number from AH to AL
    MOV AH, 0
    DIV DL                  ; divide the number with 10    
    MOV D2, AL                  ; store he 2nd digit from AL to D2
    
    MOV D3, AH              ; store the 3rd digit from AH to D3
    
    MOV AH, 2               ; call output function
    
    MOV DL, D1              ; load the 1st digit in DL
    ADD DL, 30H                 ; make DL a number
    INT 21H                 ; print the 1st digit
    
    MOV DL, D2              
    ADD DL, 30H             ; do the same thing for 2nd digit
    INT 21H
    
    MOV DL, D3              
    ADD DL, 30H             ; do the same thing for 3rd digit
    INT 21H 
    
    MOV DL, 46D             ; print a dot
    INT 21H
    
    MOV CL, 8               ; for calculating 8 decimal place after point
    
    
POINT:

    MOV AX, 0               ; clear AX register
    MOV AL, BH              ; load the remainder from BH to AL
    
    MOV DL, 10D             ; to add a 0 with the remainder using multiplication
    MUL DL                      ; add a 0 with the remaining number
    
    DIV B                   ; divide the remainder with 0
    
    MOV BH, AH              ; store the new remainder in BH from AH
    
    MOV AH, 2                
    MOV DL, AL              ; print the quotient digit after point
    ADD DL, 30H
    INT 21H
    
    DEC CL
    CMP CL, 0               ; stop looping if CL == 0
    JNE POINT    
                                    
EXIT:
    
    MOV AH, 4CH
    INT 21H
    MAIN ENDP
END MAIN