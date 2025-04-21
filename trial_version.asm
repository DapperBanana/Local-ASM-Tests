
LDA number   ; load the number into the accumulator
AND #$01     ; bitwise AND with 1 to clear all bits except the least significant bit
BEQ isEven   ; if the result is zero, the number is even
JMP isOdd    ; if the result is non-zero, the number is odd

isEven:
    LDA #$00  ; load 0 into the accumulator (even number)
    STA result ; store the result
    JMP end    ; jump to the end of the program

isOdd:
    LDA #$01  ; load 1 into the accumulator (odd number)
    STA result ; store the result

end:
    ; Your code here

number: .BYTE 12   ; test number (change it to test different numbers)
result: .BYTE 0    ; result variable
