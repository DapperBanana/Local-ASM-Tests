
        LDA number    ; Load the input number into the accumulator
        AND #$01       ; Perform a bitwise AND operation with binary 00000001 to check the least significant bit
        BEQ is_even    ; If the result is zero, the number is even
        JMP is_odd     ; If the result is non-zero, the number is odd

is_even:
        ; Output message that the number is even
        LDX #$02       ; Load X register with ASCII code for '0'
        STX $02        ; Store '0' in memory location $02 (for output)
        LDX #$45       ; Load X register with ASCII code for 'E'
        STX $03        ; Store 'E' in memory location $03 (for output)
        JMP end        ; Jump to end of program

is_odd:
        ; Output message that the number is odd
        LDX #$01       ; Load X register with ASCII code for '1'
        STX $02        ; Store '1' in memory location $02 (for output)
        LDX #$4F       ; Load X register with ASCII code for 'O'
        STX $03        ; Store 'O' in memory location $03 (for output)

end:
        ; Halt the program
        BRK

number: .byte 35        ; Input number to check (change this value to test different numbers)
