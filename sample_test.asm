
LDA number   ; Load the number into the accumulator
AND #$01     ; Perform a bitwise AND operation with 00000001 to check the least significant bit
BEQ is_even  ; If the result is zero, the number is even
JMP is_odd   ; Otherwise, the number is odd

is_even:
    ; Number is even
    ; Do something here
    JMP end

is_odd:
    ; Number is odd
    ; Do something here
    JMP end

end:
    ; End of program
    BRK

number: .byte 42 ; Change this to test with different numbers
