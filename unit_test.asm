
; Random Alphanumeric Password Generator
;
; This program generates a random alphanumeric password of length 8.

        .org $1000

start   lda #8        ; Initialize counter to 8 characters
        sta counter

loop    lda random    ; Load a random value into A
        and #$3F      ; Mask out top 2 bits to ensure alphanumeric
        cmp #$1A      ; Check if it is a valid alphanumeric character
        bcc invalid   ; If not, generate a new random value
        cmp #$3A
        bcs invalid

        sta $0200,x   ; Store the character in the password buffer
        inx           ; Increment index
        dex           ; And then decrement it to move back to previous value
        dec counter   ; Decrement counter
        beq end       ; If counter reaches 0, end the program

invalid lda random   ; Generate a new random value
        jmp loop

end     rts

random  .byte $00     ; Initialize random value

counter .byte 0       ; Initialize counter

        .org $0200
password .res 8        ; Reserve space for the password buffer
