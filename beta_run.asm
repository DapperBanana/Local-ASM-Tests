
START    LDA #0         ; Initialize variables
         STA MAX_LENGTH
         STA CURRENT_LENGTH
         LDX #1         ; Initialize index
         LDA ARRAY,X   ; Load first integer from array
         STA PREV_INT
         INX            ; Increment index
         LDA ARRAY,X   ; Load next integer from array
         STA CURRENT_INT
         BEQ END_LOOP   ; If reached end of list, exit loop

LOOP     CMP PREV_INT  ; Compare current integer with previous integer
         BEQ SAME_INT  ; If same, increment current length
         INC CURRENT_LENGTH
         JMP UPDATE_MAX_LENGTH

SAME_INT INC CURRENT_LENGTH

UPDATE_MAX_LENGTH
         CMP CURRENT_LENGTH  ; Compare current length with max length
         BCS UPDATE_PREV_INT

         LDA CURRENT_LENGTH  ; Update max length
         STA MAX_LENGTH

UPDATE_PREV_INT
         STA CURRENT_LENGTH  ; Save current length as new previous length
         STA PREV_INT
         LDA CURRENT_INT  ; Save current integer as new previous integer

END_LOOP INX            ; Increment index
         LDA ARRAY,X   ; Load next integer from array
         STA CURRENT_INT
         BEQ END_LOOP2  ; If reached end of list, exit loop

         JMP LOOP

END_LOOP2 BRK            ; End program

ARRAY    .byte 2, 3, 4, 8, 9, 10, 11, 5, 6, 7, 12, 13, 14, 15, 16  ; Input list of integers

MAX_LENGTH .byte 0
CURRENT_LENGTH .byte 0
PREV_INT .byte 0
CURRENT_INT .byte 0

         .org $200
         .db $ff
