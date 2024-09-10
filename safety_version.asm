
 LDA number     ; Load the number into the accumulator
 AND #$01       ; Perform bitwise AND with 1
 BEQ is_even    ; Branch if result is zero (even)
 JMP is_odd     ; Jump if result is not zero (odd)

is_even:
    ; Number is even
    ; Add code for even number here
    JMP end

is_odd:
    ; Number is odd
    ; Add code for odd number here
    JMP end

end:
    ; End of program

number: .BYTE 10  ; Replace '10' with the number to check
