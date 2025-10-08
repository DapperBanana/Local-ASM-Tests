
        .org $0600

NUMBER  .byte 36       ; Change this to the number you want to check

        LDA NUMBER     ; Load the number into the accumulator
        STA $00        ; Store the number in memory location $00
        LDX #$00       ; Initialize X register to 0
        LDY #$01       ; Initialize Y register to 1

LOOP    LDA $00        ; Load the number from memory into the accumulator
        SEC            ; Set the carry flag
        SBC Y          ; Subtract Y from the accumulator
        BEQ SQUARE     ; Branch to SQUARE if the result is 0
        CPY $00        ; Compare Y with the number
        BCC NOT_SQUARE ; Branch to NOT_SQUARE if Y is greater than the number
        INX            ; Increment X
        INY            ; Increment Y
        JMP LOOP       ; Jump back to LOOP

SQUARE  ; If we reach here, the number is a perfect square
        LDA #$01       ; Load 1 into the accumulator
        STA $01        ; Store 1 in memory location $01
        RTS            ; Return from subroutine

NOT_SQUARE
        LDA #$00       ; Load 0 into the accumulator
        STA $01        ; Store 0 in memory location $01
        RTS            ; Return from subroutine

        .end
