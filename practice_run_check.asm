
        .org $0200  ; Start program at address $0200

start   LDX #0      ; Initialize X register to 0
        LDY #0      ; Initialize Y register to 0
        LDA number  ; Load number into accumulator
loop    AND #$0F    ; Mask off the lower 4 bits
        CLC        ; Clear carry flag
        ADC X      ; Add the masked number to X
        ROR        ; Shift number 4 bits to the right
        INY        ; Increment Y to count the number of digits
        CMP #$00   ; Compare with 0
        BNE loop   ; If not zero, continue looping
        
done    STX sum    ; Store the sum of digits in memory location 'sum'

        ; Your program should continue here
        
number  .byte $56   ; Change this value to test with different numbers
sum     .byte $00   ; Store the sum of digits here

        .end        ; End of program
