
; Program to check if a given number is a perfect square
;
; Input:  A register contains the number to be checked
; Output: Z flag is set if the number is a perfect square, otherwise it is clear

        ORG $0200

start   LDA #$00         ; Initialize sum to 0
        STA sum

        LDX #$00         ; Initialize counter to 0
        STX counter

loop    CLC              ; Clear carry flag
        LDA sum          ; Load accumulator with the current sum
        ADC counter      ; Add the current value of the counter
        STA sum          ; Store the new sum
        INX              ; Increment counter
        CPX A            ; Compare counter with input number
        BNE loop         ; Loop until counter equals input number

        LDA sum          ; Load accumulator with the final sum
        CMP A            ; Compare sum with input number
        BNE not_square    ; Jump to not_square if they are not equal

        CLC              ; Clear carry flag to set Z flag
        RTS              ; Return from subroutine

not_square
        SEC              ; Set carry flag to clear Z flag
        RTS              ; Return from subroutine

sum     .BYTE $00       ; Variable to store the sum
counter .BYTE $00       ; Variable to store the counter

        END
