
; Program to determine if a number is even or odd
;
; Input:  8-bit number stored in memory location $00
; Output: $FF if number is even, $00 if number is odd

        LDA $00      ; Load the number into the accumulator
        AND #$01     ; Mask the least significant bit to determine if it is odd or even
        BEQ Even     ; Branch if the LSB is zero (even number)
        JMP Odd      ; Jump if the LSB is one (odd number)

Even:   LDA #$FF     ; Load $FF into the accumulator for even number
        STA $01      ; Store the result in memory location $01
        JMP End

Odd:    LDA #$00     ; Load $00 into the accumulator for odd number
        STA $01      ; Store the result in memory location $01

End:    RTS         ; Return from subroutine and end the program
