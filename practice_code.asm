
LDX #2         ; Load the size of the matrix (2x2)
LDA MATRIX,X   ; Load the element a00 of the matrix
STA A00        
LDA MATRIX,X   ; Load the element a01 of the matrix
STA A01
DEX            ; Decrement X to load the next row
LDA MATRIX,X   ; Load the element a10 of the matrix
STA A10
LDA MATRIX,X   ; Load the element a11 of the matrix
STA A11

; Calculate the determinant of a 2x2 matrix (a00 * a11 - a01 * a10)
LDA A00
CLC
ADC A11
STA DET1
LDA A01
SEC
SBC A10
STA DET2

; Print the determinant result
LDA DET1        ; Lo byte of the result
STA $6000
LDA DET2        ; Hi byte of the result
STA $6001

; Halt
BRK

MATRIX:  .BYTE 2, 3, 1, 4  ; Define the input matrix
A00:     .BYTE 0
A01:     .BYTE 0
A10:     .BYTE 0
A11:     .BYTE 0
DET1:    .BYTE 0
DET2:    .BYTE 0
