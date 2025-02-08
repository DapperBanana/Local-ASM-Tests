
LDX #0    ; X = 0
LDY #0    ; Y = 0

LDA #8    ; Load A with the coefficient of x^2 (a = 8)
STA COEFF1 ; Store the coefficient of x^2 in memory location COEFF1

LDA #6    ; Load A with the coefficient of x (b = 6)
STA COEFF2 ; Store the coefficient of x in memory location COEFF2

LDA #1    ; Load A with the constant (c = 1)
STA COEFF3 ; Store the constant in memory location COEFF3

LDA COEFF2 ; Load A with the coefficient of x
LDX COEFF3 ; Load X with the constant
STA TEMP1  ; Store the constant in memory location TEMP1

LDX COEFF1 ; Load X with the coefficient of x^2
CLC        ; Clear the carry flag
ADC TEMP1  ; Add the constant to the coefficient of x^2
STA TEMP2  ; Store the result in memory location TEMP2

LDA TEMP2  ; Load A with the sum of coefficients
LDY #4     ; Load Y with the offset for squaring
JSR SQUARE ; Call the SQUARE subroutine
STA TEMP3  ; Store the result in memory location TEMP3

LDA COEFF1 ; Load A with the coefficient of x^2
LDY #0     ; Load Y with the offset for storing the result
JSR MULT   ; Call the MULT subroutine
STA TEMP4  ; Store the result in memory location TEMP4

LDA COEFF2 ; Load A with the coefficient of x
LDY #1     ; Load Y with the offset for storing the result
JSR MULT   ; Call the MULT subroutine
STA TEMP5  ; Store the result in memory location TEMP5

LDA TEMP3  ; Load A with the squared term
LDY #2     ; Load Y with the offset for adding
LDA TEMP5
CLC        ; Clear the carry flag
ADC TEMP4  ; Add the result of multiplying coefficients
STA TEMP6  ; Store the result in memory location TEMP6

LDA TEMP6  ; Load A with the discriminant
JSR ROOTS  ; Call the ROOTS subroutine
STA TEMP7  ; Store the result in memory location TEMP7

LDA TEMP5  ; Load A with the -b term
LDY #3     ; Load Y with the offset for subtracting
LDA #0     ; Load A with zero
JSR SUB    ; Call the SUB subroutine
STA TEMP8  ; Store the result in memory location TEMP8

LDA TEMP8  ; Load A with the numerator
LDY #4     ; Load Y with the offset for dividing
JSR DIV    ; Call the DIV subroutine
STA TEMP9  ; Store the result in memory location TEMP9

LDA TEMP9  ; Load A with the first root
LDY #0     ; Load Y with the offset for displaying
JSR DISP   ; Call the DISP subroutine

LDA #1    ; Load A with -1
STA TEMP10 ; Store -1 in memory location TEMP10

LDA TEMP8 ; Load A with the numerator
LDY #5    ; Load Y with the offset for multiplying
JSR MULT  ; Call the MULT subroutine
STA TEMP11 ; Store the result in memory location TEMP11

LDA TEMP11 ; Load A with the numerator * -1
LDY #4     ; Load Y with the offset for dividing
JSR DIV    ; Call the DIV subroutine
STA TEMP12 ; Store the result in memory location TEMP10

LDA TEMP12 ; Load A with the second root
LDY #1     ; Load Y with the offset for displaying
JSR DISP   ; Call the DISP subroutine

BRK        ; Break

SQUARE:
    JSR MULT ; Call the MULT subroutine
    RTS      ; Return

MULT:
    LDA (Y),Y ; Load A with the first operand
    CLC       ; Clear the carry flag
    ADC (Y),Y ; Add the second operand to A
    RTS       ; Return

SUB:
    LDA (Y),Y ; Load A with the first operand
    SEC       ; Set the carry flag
    SBC (Y),Y ; Subtract the second operand from A
    RTS       ; Return

DIV:
    LDA (Y),Y ; Load A with the numerator
    SEC       ; Set the carry flag
    SBC TEMP10 ; Add the -1 factor
    LSR       ; Shift the result right (divide by 2)
    CLC       ; Clear the carry flag
    SBC TEMP10 ; Add the -1 factor back
    RTS       ; Return

ROOTS:
    LDA TEMP6 ; Load A with the discriminant
    LSR       ; Shift right to divide by 4
    RTS       ; Return

DISP:
    STA (Y),Y ; Store A in memory location
    LDX (Y),Y ; Load X with the result offset
    LDA #44   ; Load A with the offset for '0'
    ADC #48   ; Add '0' to convert to ASCII
    STA RESULT,X ; Store the ASCII character in memory location
    LDY X     ; Load the offset into Y
    LDY (Y),Y ; Load Y with the result offset
    LDA #32   ; Load A with the ASCII code for space
    STA RESULT,Y ; Store the space character in memory location
    RTS       ; Return

COEFF1: .BYTE 0
COEFF2: .BYTE 0
COEFF3: .BYTE 0
TEMP1: .BYTE 0
TEMP2: .BYTE 0
TEMP3: .BYTE 0
TEMP4: .BYTE 0
TEMP5: .BYTE 0
TEMP6: .BYTE 0
TEMP7: .BYTE 0
TEMP8: .BYTE 0
TEMP9: .BYTE 0
TEMP10: .BYTE 0
TEMP11: .BYTE 0
TEMP12: .BYTE 0
RESULT: .BYTE 6, 0

.done
