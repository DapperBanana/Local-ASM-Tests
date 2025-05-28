
; Program to check if a given string is a valid ISBN number
; The algorithm for validating ISBN numbers is as follows:
; 1. Calculate the sum of the first 9 digits of the ISBN number
; 2. Calculate the check digit by taking the sum modulo 11
; 3. If the check digit is equal to the last digit of the ISBN number, then it is a valid ISBN

        .org $0200

start:
        ; Load the address of the string into X register
        ldx #str
        
        ; Load the sum of the first 9 digits
        lda #$00
        sta sum
        
        ; Loop to calculate sum of first 9 digits
loop:
        lda (x), y
        cmp #',' ; check if the end of 9 digits is reached
        beq check_sum
        and #$0F ; convert ASCII to number
        clc
        adc sum
        sta sum
        inx
        bne loop
        
check_sum:
        ; Calculate the check digit by taking the sum modulo 11
        ldy #0
        lda sum
        cmp #$0b
        bpl not_divisible
divisible:
        ldy #1
not_divisible:
        lda sum
        sec
        sbc #$0b
        cmp (x), y
        bne invalid
        jmp valid

invalid:
        lda #$00
        jsr $ffd2 ; print 'Invalid ISBN'
        lda #$0d
        jsr $ffd2 ; print newline
        jmp end

valid:
        lda #$01
        jsr $ffd2 ; print 'Valid ISBN'
        lda #$0d
        jsr $ffd2 ; print newline

end:
        rts

str:    .byte "123456789,5"
        .byte 0

        .end
