
ORG $1000

STRING_TABLE:
    .byte $41, $42, $43, $44, $00
    .byte $41, $42, $43, $00
    .byte $41, $42, $00

RESULT:
    .byte $00

START:
    LDX #$00          ; initialize X register to index into strings
LOOP:
    LDY #$00          ; initialize Y register to index into characters
    LDA STRING_TABLE,X ; load first character of the current string

CHECK_CHAR:
    CMP STRING_TABLE,Y ; compare character with next string
    BEQ SAME_CHAR     ; if characters are the same, continue checking
    STY RESULT        ; store result in memory
    RTS               ; return

SAME_CHAR:
    INX               ; increment index of the string table
    INY               ; increment index of characters
    CMP #$00          ; check for end of string
    BNE CHECK_CHAR    ; if not end of string, continue checking
    JMP LOOP          ; if end of string, move to next string

END:
    BRK               ; end program
