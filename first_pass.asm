
        .org $0200

start   LDX #0          ; Initialize X register to 0
        LDY #15         ; Initialize Y register to 15 (number of iterations)
        LDA #64         ; Load the number for which to find the square root (e.g. 64)
        STA number

loop    LDA number      ; Load the number into the A register
        LSR             ; Divide the number by 2 by shifting right
        STA number      ; Store the new number back
        LDY #15         ; Reset the counter for the number of iterations

calc    LDA root        ; Load the current guess of the square root
        ADC number      ; Add the number to the current guess
        LSR             ; Divide the result by 2 by shifting right
        STA root        ; Store the new guess of the square root

        DEY             ; Decrement the iteration counter
        BNE calc        ; Repeat the calculation for the specified number of iterations

done    BRK             ; Break and end the program

number  .byte 0         ; Variable to store the input number
root    .byte 0         ; Variable to store the current guess of the square root

        .end
