
        .org $0200
        
start   lda #0          ; Initialize sum to 0
        sta sum
        ldx #0          ; Initialize index to 0
        ldy #$08        ; Number of digits in the input

loop    lda number,x    ; Load the next digit from the input
        clc             ; Clear the carry flag
        adc sum         ; Add the digit to the sum
        sta sum         ; Store the updated sum
        inx             ; Move to the next digit
        dey             ; Decrement counter
        bne loop        ; Loop until all digits are processed
        
        hlt             ; Halt the program

number  .byte $12, $34, $56, $78  ; Input number
sum     .byte 0                    ; Sum of digits

        .end
