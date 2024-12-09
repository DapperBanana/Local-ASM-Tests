
        .org $1000

start   LDX #2              ; Start with the smallest prime factor
        LDA #64             ; Number to find prime factors for
        STA number

loop    CPX number          ; Check if X is greater than number
        BCS end             ; If X > number then stop

        LDA number          ; Load the divisor
        JSR divide          ; Divide the number by X
        BEQ next            ; If division was successful, check the divisor again

        INX                 ; Increment X
        BRA loop            ; Loop back to check next prime factor

next    LDA number          ; Load the remainder after division
        BEQ end             ; If remainder is 0, then number is a prime factor

        INX                 ; Increment X to check next possible factor
        BRA loop            ; Loop back to check next factor

end     BRK                 ; Program end

divide  SEC                 ; Set carry flag
        LDA number          ; Load the number to be divided
        SBC dividend        ; Subtract the divisor
        BCC done            ; If result is negative, skip next step
        CLC                 ; Clear carry flag
        STA number          ; Store the result back into number
        INC dividend        ; Increment the divisor
        JMP divide          ; Repeat the division

done    RTS                 ; Return from subroutine

dividend .byte 0            ; Divisor storage

number  .byte 0              ; Number to find prime factors for

        .end
