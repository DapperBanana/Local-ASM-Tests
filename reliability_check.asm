
; Hexagon Area Calculation Program

ORG $0200

START:
    LDX #$06         ; Number of sides (hexagon)
    LDY #$1F         ; Side length (example value)

    JSR MULT         ; Multiply side length by 6 to get perimeter
    STY PERIM        ; Store the perimeter value

    LDA PERIM        ; Load the perimeter value
    ASL A            ; Shift left to multiply by 2 (perimeter*2)
    STA PERIM        ; Store the doubled perimeter value

    LDX PERIM        ; Load the doubled perimeter value
    LDA $00          ; Load accumulator with 0 (clear accumulator)

LOOP:
    CLC              ; Clear carry flag
    ADC XSUM         ; Add current value of XSUM to accumulator
    INX              ; Increment X register (starting with 1)
    BNE LOOP         ; Branch if result is not zero

    LSR              ; Divide by 2 to get area (perimeter*side length/2)
    LSR              ; Shift right to divide by 2
    LDX A            ; Move area value to X register

END:
    ; End of program

MULT:                ; Multiply Y register by X register
    LDA #$00         ; Clear A register
    CLC              ; Clear carry flag
    LOOP2:
        ADC Y         
        DEY
        BNE LOOP2
    RTS

PERIM: .BYTE 0       ; Storage for the perimeter value
XSUM:  .BYTE 0       ; Storage for the sum of X register
