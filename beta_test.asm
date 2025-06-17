
START LDA #0          ; Initialize variables
     STA MAX_LENGTH
     STA CURR_LENGTH
     LDX #0
LOOP LDA ARRAY,X     ; Load current element
     CMP ARRAY+1,X   ; Compare with next element
     BCC INCREASE    ; If less, go to INCREASE
     JMP CHECK       ; If not, go to CHECK
INCREASE INC CURR_LENGTH      ; Increase current length
         JMP CHECK
CHECK    LDA CURR_LENGTH      ; Load current length
         CMP MAX_LENGTH       ; Compare with max length
         BCC ASSIGN          ; If greater, assign new max length
         JMP CONTINUE        ; If not, continue
ASSIGN   STA MAX_LENGTH       ; Assign new max length
         LDA CURR_LENGTH      ; Load current length
         STA MAX_SUBSEQ_LEN   ; Save current length as max subsequence length
CONTINUE LDA CURR_LENGTH      ; Load current length
         STA CURR_LENGTH      ; Reset current length
         INX                  ; Move to next element
         CPX ARRAY_LENGTH     ; Compare with array length
         BCC LOOP             ; If not end of array, go to LOOP
         RTS                  ; End program

ARRAY .BYTE 2, 3, 1, 4, 7, 5, 9, 8, 6    ; Define array
ARRAY_LENGTH = *-ARRAY                    ; Calculate array length

MAX_LENGTH       .BYTE 0                  ; Initialize max length
CURR_LENGTH      .BYTE 0                  ; Initialize current length
MAX_SUBSEQ_LEN   .BYTE 0                  ; Initialize max subsequence length

     .ORG $C000                          ; Start address of program
     JMP START                          ; Jump to start of program
