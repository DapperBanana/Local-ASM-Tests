
        ; This program checks if a given number is a perfect square
        ; It stores the given number in the memory location 0xAA
        ; It stores the square root of the number in the memory location 0xAB
        ; It then calculates the square of the square root and compares it with the original number
        ; If they are equal, the number is a perfect square, otherwise it is not
        
        LDA #36            ; Load the number to be checked into the accumulator
        STA $AA            ; Store the number in memory location 0xAA
        
        JSR SQRT           ; Call the subroutine to calculate the square root
        
        LDX $AB            ; Load the square root from memory location 0xAB into the X register
        TXA                ; Transfer the square root to the accumulator
        CLC                ; Clear the carry flag
        ADC $AB            ; Add the square root to the accumulator
        TAX                ; Transfer the result back to the X register
        
        LDA $AA            ; Load the original number back into the accumulator
        CMP $AB            ; Compare it with the square of the square root
        
        BEQ PERFECT        ; Branch if the numbers are equal
        
NOT_PERFECT:
        JMP $0000          ; The number is not a perfect square, jump to the end of the program
        
PERFECT:
        JMP $0000          ; The number is a perfect square, jump to the end of the program
        
SQRT:
        LDX $AA            ; Load the original number from memory location 0xAA into the X register
        LDA #$00           ; Clear the accumulator
        STA $AB            ; Clear the memory location 0xAB
        
SQRT_LOOP:
        CLC                ; Clear the carry flag
        ROL $AB            ; Shift the result left by one bit
        LDA $AA            ; Load the original number into the accumulator
        SBC $AB            ; Subtract the result from the original number
        
        BCC SQRT_DONE      ; Branch if the result is negative
        
        STA $AA            ; Store the result in memory location 0xAA
        INC $AB            ; Increment the result in memory location 0xAB
        
        BRA SQRT_LOOP      ; Branch back to the start of the loop
        
SQRT_DONE:
        RTS                ; Return from the subroutine
