
.MODEL SMALL
DISPLAY MACRO MSG
LEA DX,MSG 
MOV AH,09H
INT 21H
ENDM

.DATA
LIST DB 1H, 2H, 4H, 5H, 7H, 9H
NUMBER EQU($-LIST)
KEY DB 4H
MSG1 DB 0DH, 0AH, "ELEMENT FOUND IN  THE LIST ...$"
MSG2 DB 0DH, 0AH, "SEARCH FAILED !! ELEMENTS NOT FOUND IN THE LIST $"


.CODE
START  : MOV AX,@DATA
         MOV DS,AX
         MOV CH,NUMBER-1
         MOV CL,00H
AGAIN :  MOV SI,OFFSET LIST
         XOR AX,AX
         CMP CL,CH
         JE NEXT
         JNC FAILED
NEXT :   MOV AL,CL
         ADD AL,CH
         SHR AL,01H
         MOV BL,AL
         XOR AH,AH
         MOV BP,AX
         MOV AL,DS:[BP][SI]
         CMP AL,KEY
         JE SUCCESS
         JC INCLOW
         MOV CH,BL
         DEC CH
         JMP AGAIN
INCLOW:  MOV CL,BL
         INC CL
         JMP AGAIN

SUCCESS: MOV AL,KEY
         ADD AL,30H
         MOV DL,AL
         MOV AH,02H
         INT 21H
         DISPLAY MSG1
         JMP FINAL
FAILED: MOV AL,KEY
        ADD AL,30H
        MOV DL,AL
        MOV AH,02H
        INT 21H
        DISPLAY MSG2
FINAL : MOV AH,01H
        INT 21H
        MOV AH,4CH
        INT 21H
END START
     
