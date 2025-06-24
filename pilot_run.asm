
    .org $0600

start:  LDA number    ; Load the number to be squared
        JSR square   ; Call the square subroutine
        LDA result+1 ; Load the high byte of the result
        STA squareRoot ; Store it as the most significant byte of the square root
        LDA result   ; Load the low byte of the result
        STA squareRoot+1 ; Store it as the least significant byte of the square root

end:    NOP         ; End of program

square: LDX #0       ; Initialize the square to 0
loop:   CLC
        ADC #1       ; Add 1 to the square
        STA result   ; Store the current square value in memory
        LDA result   ; Load the current square value
        CMP number   ; Compare it with the original number
        BCC loop     ; Continue the loop if the square is less than the number
        RTS         ; Return from subroutine

number: .byte 16     ; The number to find the square of
result: .word 0      ; Variable to store the current square value
squareRoot: .word 0  ; Variable to store the square root

    .end
