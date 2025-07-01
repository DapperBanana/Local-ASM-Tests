
; Assume the two strings are stored at memory locations STR1 and STR2
; The edit distance will be stored at memory location DIST

STR1 .equ $2000
STR2 .equ $3000
DIST .equ $4000

START:
    LDA #$00      ; Initialize edit distance counter
    STA DIST

    LDA #$00
    STA INDEX1    ; Initialize index for STR1
    STA INDEX2    ; Initialize index for STR2

COMPARE:
    LDA INDEX1
    CMP #$00      ; End of string 1
    BEQ END

    LDA INDEX2
    CMP #$00      ; End of string 2
    BEQ END

    LDA STR1, X   ; Load character from STR1
    STA CHAR1

    LDA STR2, X   ; Load character from STR2
    STA CHAR2

    CMP CHAR1, CHAR2 ; Compare characters
    BEQ NEXT

    INC DIST      ; Increment edit distance counter

NEXT:
    INX           ; Increment indices
    INX
   
    JMP COMPARE

END:
    BRK

CHAR1 .byte 0
CHAR2 .byte 0
INDEX1 .byte 0
INDEX2 .byte 0
