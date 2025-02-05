
    .org $1000         ; start address of the program

start:
    lda #$00           ; initialize index variable
    sta index

loop:
    lda string, x      ; load character from string
    beq end            ; if end of string, exit loop
    
    cmp #$30           ; check if character is a digit
    bcs skip_invalid   ; if character is not a digit, skip to next character

    cmp #$39           ; check if character is a digit
    bcc invalid        ; if character is not a digit, mark as invalid

    inx                ; move to next character
    cpx #$0A           ; check if reached end of credit card number
    bne loop           ; if not, continue loop

valid:
    lda #$01           ; set flag to indicate valid credit card number
    jmp end

invalid:
    lda #$00           ; set flag to indicate invalid credit card number
    jmp end

skip_invalid:
    inx                ; move to next character
    bne loop           ; continue loop

end:
    rts

string:
    .asciiz "1234567890123456"  ; sample credit card number

index:
    .byte $00           ; index variable

flag:
    .byte $00           ; flag variable to indicate valid or invalid credit card number
