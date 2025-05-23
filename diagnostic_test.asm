
        .org $0600

start   lda #0              ; Load index 0
        sta index
loop    lda input, x        ; Load character from input string
        beq done            ; Branch if end of string
        sta temp, x         ; Store character in temporary buffer
        inx                 ; Increment index
        jmp loop            ; Jump back to loop

done    inx                 ; Increment index to account for null terminator
        lda index           ; Load index value
        tax
        ldx #0              ; Load index 0
reverse lda temp, x         ; Load character from temporary buffer
        sta output, x       ; Store character in output string
        dex                 ; Decrement index
        bpl reverse         ; Branch if still characters left

        lda #0              ; Load null terminator
        sta output, x       ; Store null terminator in output string

        rts

input   .byte "Hello, world!", 0
output  .block 16
temp    .block 16
index   .byte 0
