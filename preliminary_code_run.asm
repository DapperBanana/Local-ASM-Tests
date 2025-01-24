
START	SEI         ; Disable interrupts
        CLD         ; Clear decimal mode
        LDX #8      ; Load the counter with 8 (number of digits in a year)
        LDA #0      ; Clear the carry flag
LP      LDA YEAR,X  ; Load the Xth digit of the year
        CMP YEAR,X  ; Compare with the corresponding digit from the other end
        BNE NOT_PALINDROME ; If not equal, it's not a palindrome year
        DEX         ; Decrement the counter
        BPL LP      ; Loop until all digits have been checked
        ; If the loop completes without finding a mismatch, it's a palindrome year
        JSR PALINDROME_FOUND
NOT_PALINDROME
        ; If a mismatch is found, it's not a palindrome year
        JSR NOT_PALINDROME_FOUND
HLT     JMP $       ; Halt the program

YEAR    .BYTE 2,0,2,2     ; Define the year to be checked

PALINDROME_FOUND
        LDA #$01    ; Set the result to 1 (palindrome year)
        STA RESULT
        RTS

NOT_PALINDROME_FOUND
        LDA #$00    ; Set the result to 0 (not a palindrome year)
        STA RESULT
        RTS

RESULT  .BYTE 0       ; Result variable

        .ORG $FFFC
        .WORD START ; Reset Vector
    
