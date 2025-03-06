
        .org $0200
NBR     .byte $0D   ; The number to check for primality
DIVISOR .byte $02   ; The divisor initially set to 2
ISPRIME .byte $00   ; Flag to indicate if the number is prime or not

START   lda NBR      ; Load the number to check into the accumulator
        jsr IS_PRIME ; Call the subroutine to check if the number is prime

        ; Print the result to the screen
        lda ISPRIME
        beq NOT_PRIME
        lda #$50 ; ASCII code for 'Y'
        jsr $FFD2 ; KERNAL routine to output a character
        jmp END

NOT_PRIME
        lda #$4E ; ASCII code for 'N'
        jsr $FFD2 ; KERNAL routine to output a character

END     rts

IS_PRIME
        lda #$01
        sta ISPRIME ; Assume the number is prime
DIV_LOOP
        lda NBR
        cmp DIVISOR
        beq END_LOOP ; If divisor = number, end loop
        clc
        lda NBR
        sbc DIVISOR
        bcc NEXT_DIVISOR ; If no remainder, go to next divisor
        inx ; Increment the divisor
        jmp DIV_LOOP

NEXT_DIVISOR
        lda DIVISOR
        clc
        adc #$01 ; Increment the divisor
        sta DIVISOR
        lda #$02 ; Reset the divisor to 2
        jmp DIV_LOOP

END_LOOP
        lda DIVISOR
        cmp #$02 ; If the divisor is 2, the number is prime
        beq PRIME
        lda #$00 ; Mark the number as not prime
PRIME   sta ISPRIME
        rts
