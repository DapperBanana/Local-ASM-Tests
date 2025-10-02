
        .org $0200  ; Start address of the program

number  .byte $12    ; Number to calculate sum of digits (example: $12 = 18 in decimal)
result  .byte $00    ; Variable to store the sum of digits

        LDX #0       ; Initialize X register to 0
loop    LDA number,X ; Load the digit at index X
        BEQ end      ; If digit is zero, end loop
        ADC result   ; Add the digit to the result
        STA result   ; Store the sum in result
        INX          ; Increment X
        BNE loop     ; Branch to loop if X is not zero
end     BRK          ; Exit the program

        .org $FFFC  ; Reset vector
        .word $0200 ; Start address of the program
