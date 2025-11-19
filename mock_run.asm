
    .org $1000

start:
    lda #$00    ; Initialize random number seed
    ldx #10     ; Set password length
loop:
    jsr getRandom   ; Get a random character
    sta $0200, x    ; Store character in memory
    dex             ; Decrement X
    bne loop        ; Loop until password length reached

    lda #$00        ; Load null terminator
    sta $0200, x    ; Store null terminator at end of string
    jsr printString ; Print password
    jmp $FFFA       ; Jump to reset

getRandom:
    lda $00         ; Load random number seed
    clc
    adc $D410       ; Add $D410 for randomness
    sta $00         ; Store new random number
    ror             ; Rotate right to get a character
    lda #$3A        ; Set range of characters (0-9, A-Z)
    clc
    and #$1F        ; Mask out upper bits
    cmp #$09        ; Check for number position
    bcc numChar     ; Jump to number character
    adc #$07        ; Adjust for position of alphabet characters
numChar:
    adc #$30        ; Adjust character to ASCII value
    rts

printString:
    ldx #10     ; Set loop counter
printLoop:
    lda $0200, x    ; Load character
    jsr $FFD2       ; Print character to screen
    dex             ; Decrement X
    bpl printLoop   ; Loop until all characters printed
    rts

    .end
