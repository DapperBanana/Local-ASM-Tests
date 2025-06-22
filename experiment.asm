
PASSWORD_LENGTH = 8

    .org $0200

start:
    ldx #$00          ; Initialize X register for loop counter
    lda #$00          ; Initialize accumulator to store each character
random_loop:
    jsr random        ; Get a random number (0-255) into A register
    and #15           ; Mask lower 4 bits to ensure we get only printable characters (ASCII 33-126)
    cmp #33           ; Compare with lowest printable character ASCII value
    bcc random_loop   ; If less than lowest printable character, try again
    sta $0200,x       ; Store random character at address $0200 and increment index
    inx
    cpx #PASSWORD_LENGTH   ; Check if password length is reached
    bne random_loop   ; If not, continue generating random characters

    lda #$00          ; Load zero to print $00 terminated string
    sta $0200,x       ; Store null terminator at the end of the password

print_loop:
    lda $0200,x       ; Load character into A register
    beq end           ; If null terminator, end of password reached
    jsr print_char    ; Print character
    inx               ; Increment index
    jmp print_loop    ; Repeat until null terminator

print_char:
    jsr $FFD2         ; Call Kernal routine to print character
    rts

random:
    lda $d20a         ; Load current value of CIA 2 timer into A register
    rts

end:
    rts

    .end
