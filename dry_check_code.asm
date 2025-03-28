
START:
    LDX #0          ; Initialize index variable to 0
    LDY #10         ; Set n to 10

SUM_LOOP:
    CLC             ; Clear carry flag
    ADC X           ; Add the value of X to the accumulator
    INX             ; Increment X
    CPY #0          ; Compare Y with 0
    BEQ DONE        ; If Y is 0, go to DONE
    DEY             ; Decrement Y
    BRA SUM_LOOP    ; Repeat SUM_LOOP

DONE:
    STX RESULT      ; Store the result in RESULT
    NOP             ; No operation
    NOP             ; No operation

RESULT: .BYTE 0     ; Result variable

    .ORG $FFFC      ; Reset Vector table
    .WORD START     ; Start of the program

    .END
