
        .org $0200

start   lda number     ; Load the number into the accumulator
        sta numCopy    ; Store a copy of the number
        ldx #0         ; Initialize sum to zero
        ldy #0

check   lsr            ; Shift to the right to get the last digit
        bcc addNum     ; Branch if carry clear (rightmost bit was 0)
        
        tay            ; Copy the digit to Y register
        lda sum        ; Load the current sum
        clc            ; Clear the carry flag
        adc y          ; Add the digit to the sum
        sta sum        ; Update the sum
        lda quotient   ; Load the driving number
        mul #10        ; Multiply by 10 to shift left
        sta quotient   ; Update quotient
        lda numCopy    ; Load the copy of the number
        lsr            ; Shift to the right to get next digit
        sta numCopy    ; Update the copy of the number
        bra check      ; Branch to check next digit

addNum  lda sum        ; Load the sum into A
        tya            ; Copy the digit from Y to A
        clc            ; Clear the carry flag
        adc sum        ; Add the digit to the sum
        sta sum        ; Update the sum
        lda quotient   ; Load the driving number
        mul #10        ; Multiply by 10 to shift left
        sta quotient   ; Update quotient
        lda numCopy    ; Load the copy of the number
        lsr            ; Shift to the right to get next digit
        sta numCopy    ; Update the copy of the number
        bra check      ; Branch to check next digit

done    lda quotient   ; Load the driving number
        cmp sum        ; Compare the sum with the original number
        beq narcissistic ; Branch if they are equal
        jmp notNarcissistic ; Jump if not a narcissistic number

narcissistic
        ; Code for narcissistic number
        lda #$01       ; Store 1 in the accumulator to show it is a narcissistic number
        jmp end

notNarcissistic
        ; Code for not narcissistic number
        lda #$00       ; Store 0 in the accumulator to show it is not a narcissistic number

end     sta result     ; Store the result in the 'result' variable
        ; End of program

number  .byte $12      ; Input number here
result  .byte $00
sum     .byte $00      ; Variable to store the sum of digits
quotient .byte $00     ; Variable to store a working number
numCopy .byte $00      ; Copy of the input number

        .end
