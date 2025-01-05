
        processor 6502
		org $8000	; Start program at memory location $8000

START   equ 10      ; Start of range
END     equ 50      ; End of range
SUM     equ $00     ; Variable to store the sum of prime numbers
CUR_NUM equ $01     ; Current number being checked for primality
IS_PRIME equ $02    ; Flag to indicate if number is prime

        lda #START  ; Initialize current number variable
        sta CUR_NUM

        lda #0      ; Initialize sum variable
        sta SUM

LOOP    lda CUR_NUM ; Check if number is prime
        jsr ISPRIME

        lda IS_PRIME
        beq NOT_PRIME

        clc
        lda SUM     ; Add prime number to sum
        adc CUR_NUM
        sta SUM

NOT_PRIME
        inx           ; Increment current number
        lda CUR_NUM
        cmp #END      ; Check if reached end of range
        bcc LOOP

END_LOOP
        ; End of program

ISPRIME
        lda #1   ; Assume number is prime
        sta IS_PRIME

        ldx #2
CHECK_DIVISOR
        lda CUR_NUM
        sec
        sbc X
        bne NOT_DIVISIBLE
        ldx #0
        sta IS_PRIME
        rts

NOT_DIVISIBLE
        inx
        cpx CUR_NUM
        bcc CHECK_DIVISOR
        rts
