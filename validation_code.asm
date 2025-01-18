
.INVERTIBLE_MATRIX_CHECK

    LDA MATRIX         ; Load matrix element a
    BEQ NOT_INVERTIBLE ; If a = 0, matrix is not invertible

    LDX #2             ; Load loop counter with 2
FIND_DETERMINANT:
    LDA MATRIX, X      ; Load matrix element b or c
    STA TEMP           ; Store in temporary variable
    INX                ; Increment X to load next element
    LDA MATRIX, X      ; Load matrix element c or d
    CMP #0             ; Check if d is 0
    BEQ NOT_INVERTIBLE ; If d = 0, matrix is not invertible
    SBC TEMP           ; Subtract b*c from a*d
    BNE INVERTIBLE     ; If determinant is not zero, matrix is invertible
NOT_INVERTIBLE:
    LDA #0             ; Load 0 to indicate matrix is not invertible
    JMP END_PROGRAM
INVERTIBLE:
    LDA #1             ; Load 1 to indicate matrix is invertible
END_PROGRAM:
    RTS

; Matrix definition
MATRIX: .BYTE 1, 2, 3, 0     ; Define a 2x2 matrix [a b ; c d]
TEMP:   .BYTE 0

