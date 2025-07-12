
        LDA $0200      ; Load the number to check into the A register
        CMP #$02       ; Check if the number is less than 2
        BCC NotPrime   ; Branch if less than 2
        CMP #$02       ; Check if the number is equal to 2
        BEQ Prime      ; Branch if equal to 2
        LDX #$02       ; Initialize X register to 2 (divisor)
CheckDivisor:
        CPX $0200      ; Compare divisor with the number
        BEQ Prime      ; If divisor equals number, it's a prime number
        CPY #$00       ; Clear Y register for division
        LDA $0200      ; Load the number to check into A register
        CLC            ; Clear carry flag
        SBC $0200      ; Subtract divisor from number
        BCS NotDivisible  ; Branch if number is less than divisor
        INY            ; Increment Y register
        JMP CheckDivisor  ; Continue checking divisors
NotDivisible:
        LDA #$00       ; Load 0 into A register (not prime)
        STA $0201      ; Store result at memory address $0201
        RTS            ; Return from subroutine
NotPrime:
        LDA #$00       ; Load 0 into A register (not prime)
        STA $0201      ; Store result at memory address $0201
        RTS            ; Return from subroutine
Prime:
        LDA #$01       ; Load 1 into A register (prime)
        STA $0201      ; Store result at memory address $0201
        RTS            ; Return from subroutine
