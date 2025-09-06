
ORG $1000

    ; Input sides of the triangle
    LDA #1
    STA SIDE1
    LDA #2
    STA SIDE2
    LDA #3
    STA SIDE3

    ; Calculate semi-perimeter
    LDA SIDE1
    CLC
    ADC SIDE2
    ADC SIDE3
    ASL
    STA SEMI_PERIMETER

    ; Calculate area of the triangle using Heron's formula
    LDA SEMI_PERIMETER
    SEC
    SBC SIDE1
    SBC SIDE2
    SBC SIDE3
    LDX #2
    JSR SQUARE_ROOT
    STA AREA

    ; Output the result
    LDA AREA
    JSR PRINT_RESULTS

    ; End of program
    BRK

; Function to calculate square root of a number
SQUARE_ROOT:
    LSR
    CLC
    ROL
    ADC #$FF
    LSR
    CLC
    ROL
    ADC #$FF
    LSR
    CLC
    ROL
    ADC #$FF
    LSR
    CLC
    ROL
    AND #$F0
    ADC $0000
    RTS

; Output the result
PRINT_RESULTS:
    LDX #2
PRINT_LOOP:
    LDA AREA,X
    JSR $FFD2  ; Print character to console
    DEX
    BPL PRINT_LOOP
    RTS

SIDE1    .BYTE 0
SIDE2    .BYTE 0
SIDE3    .BYTE 0
SEMI_PERIMETER  .BYTE 0
AREA    .BYTE 0

    .END
