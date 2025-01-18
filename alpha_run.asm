
.org $0200

START:
    LDX #0         ; Initialize loop counter X
    LDY #3         ; Initialize loop counter Y

; Matrix A
MATRIX_A:
    LDA A,X        ; Load element from matrix A
    CLC            ; Clear carry flag
    ADC B,X        ; Add element from matrix B
    STA RESULT,X   ; Store result in matrix RESULT

    INX            ; Increment X
    CPX #9         ; Compare X with matrix size
    BNE MATRIX_A   ; Loop if X is not equal to matrix size

; Matrix B
MATRIX_B:
    LDA B,X        ; Load element from matrix B
    SEC            ; Set carry flag
    SBC A,X        ; Subtract element from matrix A
    STA RESULT,X   ; Store result in matrix RESULT

    INX            ; Increment X
    CPX #9         ; Compare X with matrix size
    BNE MATRIX_B   ; Loop if X is not equal to matrix size

    RTS            ; Return from subroutine

A:  .byte 1, 2, 3, 4, 5, 6, 7, 8, 9   ; Matrix A
B:  .byte 9, 8, 7, 6, 5, 4, 3, 2, 1   ; Matrix B
RESULT: .ds 9                           ; Result matrix

.end
