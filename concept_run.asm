
        .org $0200

START   lda #NUMBER          ; Load the number to check into accumulator
        sta NUMBER
        ldx #0              ; Initialize index to 0 (start of number)
        ldy #NUMBER_SIZE    ; Initialize index to end of number
        dey                 ; Move index to last digit of number

CHECK   lda NUMBER, X       ; Load digit from start of number
        cmp NUMBER, Y       ; Compare with digit from end of number
        bne NOT_PALINDROME  ; Branch if not equal

        inx                 ; Move index to next digit from start of number
        dey                 ; Move index to previous digit from end of number

        cpx #NUMBER_SIZE    ; Check if all digits have been compared
        beq IS_PALINDROME   ; Branch if all digits are equal

        jmp CHECK           ; Continue checking next digits

NOT_PALINDROME
        lda #NOT_PALINDROME_MSG  ; Load message indicating number is not a palindrome
        jsr OUTPUT_MSG      ; Output message
        jmp END

IS_PALINDROME
        lda #IS_PALINDROME_MSG  ; Load message indicating number is a palindrome
        jsr OUTPUT_MSG      ; Output message

END     rts

NUMBER   .byte $12,$34,$56,$78,$9A  ; Example number to check (123456789)
NUMBER_SIZE   .byte 5            ; Number of digits in the number

OUTPUT_MSG
        ; Code to output message stored in accumulator
        rts

NOT_PALINDROME_MSG .byte "Number is not a palindrome", $00
IS_PALINDROME_MSG  .byte "Number is a palindrome!", $00

        .end
