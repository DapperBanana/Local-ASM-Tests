
    .org $1000
    ; Input: A pointer to the string to check
    ; Output: Carry flag set if the string is a valid credit card number, clear otherwise
    
    ; Check if the string is empty
    lda ($00),y       ; Load the first character of the string
    beq end           ; If it is 0, set the carry flag and exit
    
    ; Check if the string length is valid
    ldy $00           ; Load the string length
    cpy #$0A          ; Compare with 10 characters (credit card number length)
    bne end           ; If it is not equal, set the carry flag and exit
    
    ; Check if the characters are digits
loop:
    lda ($00),y       ; Load the next character of the string
    cmp #$30          ; Compare with '0' (ASCII value)
    bcc not_valid     ; If the character is not a digit, set the carry flag and exit
    cmp #$39          ; Compare with '9' (ASCII value)
    bcs not_valid     ; If the character is not a digit, set the carry flag and exit
    dey               ; Decrease the string length counter
    iny               ; Increase the string pointer
    bny loop          ; Repeat the loop until all characters are checked
    
    ; Check if the credit card number is valid
    lda $00           ; Load the pointer to the credit card number
    ldx #9            ; Initialize a counter for the checksum calculation
    ldy #$00          ; Initialize the checksum variable
    
checksum_loop:
    lda ($00),y       ; Load the next digit of the credit card number
    clc               ; Clear the carry flag
    adc #$30          ; Convert the ASCII digit to a binary digit
    cmp #$80          ; Compare with 128
    bcc skip_sub      ; If the result is less than 128, skip the subtraction
    sbc #$30          ; Subtract 3 to adjust for overflow from conversion
skip_sub:
    sta $10           ; Store the converted digit for later use
    lda $10           ; Load the converted digit again
    clc               ; Clear the carry flag
    adc $10           ; Add the converted digit to the checksum
    iny               ; Increase the index to load the next digit
    dex               ; Decrease the counter
    bne checksum_loop ; Repeat the loop until all digits are checked
    
    ldx #10           ; Initialize a counter for modulo 10 calculation
    ldy #$00          ; Initialize the modulo 10 variable
    
checksum_modulo10:
    lda $10           ; Load the next digit of the checksum
    clc               ; Clear the carry flag
    adc #$00          ; Add 0 to the current checksum digit
    sec               ; Set the carry flag
    sbc #$0A          ; Subtract 10 to calculate the modulo 10
    sta $10           ; Store the result
    inx               ; Increase the index
    bne checksum_modulo10 ; Repeat until all digits are checked
    
    beq valid         ; If calculated checksum is 0, set the carry flag (valid credit card number)
    
not_valid:
    clc               ; Clear the carry flag
end:
    rts               ; Return from the subroutine
    
valid:
    sec               ; Set the carry flag (valid credit card number)
    rts               ; Return from the subroutine
