
    ORG $0200

start:
    LDX #$08        ; Load the bit count
    LDA #$3A        ; Load the decimal number to convert (58 in this example)
    STA number

loop:
    LDA number      ; Load the decimal number
    AND #$80        ; Mask the most significant bit
    BEQ zero        ; If it is zero, branch to zero
    SEC             ; Set carry flag
    ROL             ; Rotate left
    STA number      ; Store the new number
    LSR             ; Shift right
    DEX             ; Decrease bit count
    BNE loop        ; If bit count is not zero, loop back

    ; Output binary result
    LDA number
    STA $FD         ; Store result in memory
    BRK

zero:
    SEC             ; Set carry flag
    LSR             ; Shift right
    ROR             ; Rotate right
    ROR             ; Rotate right
    ROR             ; Rotate right
    STA number      ; Store the new number
    DEX             ; Decrease bit count
    BNE loop        ; If bit count is not zero, loop back

number:
    .BYTE $00

    END start
