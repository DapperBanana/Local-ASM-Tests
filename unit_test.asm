
    .org $0200
START:
    lda #0         ; Initialize sum to 0
    sta SUM
    
    ldx #8         ; Set the number of digits to read
    ldy #0         ; Initialize counter for number of digits read
    
READ_DIGIT:
    lda NUMBER, y  ; Load the next digit from the NUMBER
    cmp #0         ; Check if the digit is 0
    beq END        ; If it is, we have reached the end of the number
    
    clc            ; Clear the carry flag
    adc SUM        ; Add the digit to the sum
    sta SUM        ; Store the new sum
    
    iny            ; Increment the number of digits read
    dex            ; Decrement the remaining digits
    
    bne READ_DIGIT ; Continue reading digits if not all digits have been read

END:
    ; The sum of the digits is now stored in the SUM variable
    ; You can use it as needed
    
    rts            ; Return from subroutine

SUM: .byte 0        ; Variable to store the sum
NUMBER: .byte $12, $34, $56, $78, $90, $00, $00, $00 ; Example number to calculate sum of digits

    .end
