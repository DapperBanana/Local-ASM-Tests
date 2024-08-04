
LDA NUMBER1     ; Load the first number into the accumulator
STA NUM1

LDA NUMBER2     ; Load the second number into the accumulator
STA NUM2

JSR GCD          ; Call the subroutine to calculate GCD

BRK

GCD:
    LDX NUM1     ; Load the first number into X register
    LDY NUM2     ; Load the second number into Y register

LOOP:
    CPX #$00     ; Compare X to zero
    BEQ END      ; If X = 0, end the loop
    CPY #$00     ; Compare Y to zero
    BEQ END      ; If Y = 0, end the loop

    CPX CPY      ; Compare X to Y
    BEQ DONE     ; If X = Y, we have found the GCD

    BCC XSMALL   ; If X < Y, jump to XSMALL
    SEC          ; Set carry flag
    SBC CPY      ; Subtract Y from X
    TAX          ; Copy the result to X
    BNE LOOP     ; If result is not zero, repeat the loop
    BRA DONE     ; If result is zero, we have found the GCD

XSMALL:
    SEC          ; Set carry flag
    SBC CPX      ; Subtract X from Y
    TAY          ; Copy the result to Y
    BNE LOOP     ; If result is not zero, repeat the loop

END:
    RTS          ; Return from subroutine

DONE:
    LDX CPX      ; Load the GCD into X register
    RTS

NUMBER1 .BYTE 12  ; First number
NUMBER2 .BYTE 18  ; Second number
NUM1    .BYTE 0   ; First number copy
NUM2    .BYTE 0   ; Second number copy
CPX     .BYTE 0   ; GCD
CPY     .BYTE 0   ; Temporary variable
