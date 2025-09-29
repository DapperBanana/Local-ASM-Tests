
; Assume the input string is stored at address $1000
; Assume the QR code will be displayed on the screen starting from address $2000

        .org    $1000

input:  .asciiz "HELLO"  ; Input string
        .byte   0         ; Null terminator

        .org    $2000

start:
        lda     #0x00     ; Load accumulator with null byte
        sta     $01FE     ; Clear stack pointer
        lda     #$7F      ; Load accumulator with cursor control character to clear screen
        sta     $D020     ; Poke the screen
loop:   lda     input, x  ; Load character from input string
        beq     done      ; If end of string reached, exit loop
        jsr     display   ; Call display subroutine
        inx               ; Increment index
        bra     loop      ; Continue looping

done:
        rts               ; Return from subroutine

display:
        tax               ; Transfer accumulator to index register
        lda     ($1000), x  ; Load character to be displayed
        jsr     $FFD2     ; JSR to KERNAL ROM routine to display character
        rts               ; Return from subroutine
