
        ORG $1000

start   LDX #$00        ; Initialize index register X to 0
        LDA $F0,X       ; Load the first digit into the accumulator
        BEQ end         ; If the digit is 0, exit the loop
loop    CLC             ; Clear the carry flag
        ADC $F1         ; Add the digit to the sum
        STA $F1         ; Store the result in memory
        INX             ; Increment the index register
        LDA $F0,X       ; Load the next digit into the accumulator
        BNE loop        ; If not zero, continue the loop
end     BRK             ; Exit the program

        .ORG $2000
        .BYTE $00       ; Placeholder for input number
        .BYTE $0A       ; Placeholder for sum of digits

        .ORG $FFFC
        .WORD start
