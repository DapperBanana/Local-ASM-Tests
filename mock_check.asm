
        .org $0600

YEAR    = $00
TEMP    = $01
ANSWER  = $02

        LDA #2021    ; Load the year to be checked
        STA YEAR

        LDX #03      ; Initialize loop count
CHECK_LOOP:
        LDA YEAR,X   ; Load the digit from the year
        STA TEMP     ; Store the digit in temporary variable
        
        LDA YEAR     ; Load the year again
        CMP TEMP     ; Compare the digit with the corresponding digit from the other end
        BNE NOT_PALINDROME   ; Branch if not equal
        
        DEX          ; Decrement loop count
        CPX #$00     ; Check if end of year is reached
        BNE CHECK_LOOP      ; Branch back to loop
        
        LDA #$01     ; Set answer to 1 if palindrome year
        STA ANSWER
        JMP END

NOT_PALINDROME:
        LDA #$00     ; Set answer to 0 if not palindrome year
        STA ANSWER
        
END:
        NOP          ; End of program
        
        .end
