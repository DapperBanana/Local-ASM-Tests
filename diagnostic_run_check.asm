
        .org $0200  ; Start program at memory location $0200

year    .byte $00    ; Year to check (e.g. 2022)
result  .byte $00    ; Result of palindrome check (1 = palindrome, 0 = not palindrome)

start:
        LDA #year   ; Load year into accumulator
        STA $0000    ; Store year in memory location $0000
        
        LDA #$03     ; Load the number of digits (2) in years
        STA $0001    ; Store in memory location $0001

        LDX #$00     ; Initialize index to 0
        LDY $0001    ; Load the number of digits in years
        LDA $0000, X ; Load the first digit from years
        CMP $0000, Y ; Compare with the last digit from years
        BEQ palindrome ; If equal, continue checking palindrome
        LDA #$00     ; If not equal, set result to 0
        BRA end      ; Branch to end

palindrome:
        INX          ; Increment index
        DEY          ; Decrement number of digits
        INY          ; Increment number of digits
        CPX $0001    ; Compare index with number of digits
        BNE start    ; If not equal, continue checking palindrome
        LDA #$01     ; If palindrome, set result to 1
        BRA end      ; Branch to end

end:
        STA result   ; Store result in memory location result
        NOP          ; No operation
        NOP          ; No operation

        BRK          ; Break and end program
