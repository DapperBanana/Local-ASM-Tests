
; Decimal number to fraction converter

LDA #$00       ; Clear accumulator
STA result    ; Initialize result to 0
LDA decimal   ; Load decimal number into accumulator
ADC #$00       ; Decimal to BCD conversion (multiply by 10)
STA dividend  ; Store BCD decimal number

LDA #$01       ; Initialize denominator to 1
STA divisor

loop:
    LDA dividend  ; Load dividend
    CMP divisor   ; Compare dividend with divisor
    BCC skip      ; If dividend < divisor, skip to next step
    
    LDA result    ; Load result
    CLC           ; Clear carry flag
    ADC #$01      ; Increment result
    STA result    ; Store result
    
    LDA dividend  ; Load dividend
    SEC           ; Set carry flag
    SBC divisor   ; Subtract divisor from dividend
    STA dividend  ; Store new dividend

    BRA loop      ; Repeat loop

skip:
    LDX #$08      ; Initialize loop counter to 8 (for 8 bits after decimal point)

frac_loop:
    ASL result    ; Shift result left by 1
    BCC frac_zero ; If carry flag is not set, skip to next step
    
    SEC           ; Set carry flag
    SBC divisor   ; Subtract divisor from result
    BCC frac_zero ; If carry flag is not set, skip to next step

    SEC           ; Set carry flag
    SBC divisor   ; Subtract divisor from result

frac_zero:
    DEX           ; Decrement loop counter
    BNE frac_loop ; Repeat loop until counter is zero

    RTS           ; Return from subroutine

decimal:
    .byte 50     ; Decimal number to convert
dividend:
    .byte 0      ; Storage for dividend
divisor:
    .byte 1      ; Storage for divisor
result:
    .byte 0      ; Storage for result
