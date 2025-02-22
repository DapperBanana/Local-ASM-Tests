
        .text
        .globl _start
        
_start:
        LDA number       ; load number into accumulator
        AND #$01         ; bitwise AND with 1 to check LSB
        BNE odd         ; branch if result is not zero (odd)
        
        ; if LSB is 0, number is even
        LDA #$01         ; load 1 into accumulator for even
        STA result      ; store 1 in result
        BR exit         ; branch to exit
        
odd:
        LDA #$00         ; load 0 into accumulator for odd
        STA result      ; store 0 in result
        
exit:
        ; end of program
        BR exit
        
        .data
number: .byte 14         ; test number to check if even or odd
result: .byte 0          ; variable to store result (0 for odd, 1 for even)
