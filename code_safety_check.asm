
START:
    LDA #$00        ; Initialize index variables
    STA INDEX
    STA EMAIL_INDEX

LOOP:
    LDA $4000,X     ; Load character from text document into accumulator
    CMP #$00        ; Check if end of document
    BEQ END

    CMP #$40        ; Check if character is '@'
    BEQ CHECK_EMAIL

    INX             ; Increment index
    JMP LOOP

CHECK_EMAIL:
    LDA $4000,X     ; Load next character
    BEQ END         ; End if end of document
    CMP #$20        ; Check for space character
    BEQ END

    CMP #$2E        ; Check for dot character
    BEQ CHECK_EMAIL

    STA TEMP        ; Save current character

CHECK_DOT:
    INX             ; Move to next character
    LDA $4000,X     ; Load character
    CMP #$00        ; Check for end of document
    BEQ CHECK_EMAIL

    CMP #$40        ; Check for '@'
    BEQ CHECK_EMAIL

    CMP #$2E        ; Check for dot
    BNE NOT_DOT
    LDA TEMP        ; Load previous character
    STA $5000,Y     ; Save email address character
    INY             ; Adjust index for email address
    JMP LOOP

NOT_DOT:
    JMP CHECK_DOT

END:
    RTS

INDEX:
    .BYTE $00

EMAIL_INDEX:
    .BYTE $00

TEMP:
    .BYTE $00
