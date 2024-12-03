
        .org $1000
start   LDX #$05        ; Load X register with the number for which factorial is to be calculated
        JSR factorial   ; Jump to factorial subroutine
        BRK             ; Break

factorial
        CPX #$00        ; Check if X register is 0
        BEQ end         ; If X is 0, return 1
        DEX             ; Decrement X register
        JSR factorial   ; Recursive call to factorial subroutine
        PHA             ; Push return value (result of recursive call) onto the stack
        LDY #$01        ; Load Y register with 1
        TXA             ; Transfer X register (current number) to A register
loop    JSR multiply    ; Call multiply subroutine to multiply accumulator by Y
        DEY             ; Decrement Y register
        BNE loop        ; Continue looping until Y is 0
        PLA             ; Pop the result of recursive call from stack
        RTS             ; Return from subroutine

multiply
        SEC             ; Set carry flag
        ADC $0001       ; Add the value stored in memory location $0001 to accumulator
        STA $0001       ; Store the result back in memory location $0001
        SBC #$00        ; Subtract 0 from accumulator (discard carry)
        RTS             ; Return from subroutine

end     LDA #$01        ; Load accumulator with 1
        RTS             ; Return from subroutine

        .org $FFFA
        .word start
