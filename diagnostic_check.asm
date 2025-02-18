
; Constants
ROW_SIZE = 3
COL_SIZE = 3
MAT      = $4000 ; Memory address of matrix

; Initialize the row-echelon form to be the same as the original matrix
COPY_MAT:
    LDX #0
COPY_ROW:
    LDA MAT, X
    STA MAT + ROW_SIZE, X
    LDA MAT + ROW_SIZE, X
    STA MAT + ROW_SIZE * 2, X
    INX
    CPX ROW_SIZE
    BNE COPY_ROW

; Perform Gaussian elimination
LOOP:
    LDX #0
FORWARD_ELIM:
    LDA MAT, X
    BEQ NEXT_ROW ; Skip if leading element is zero
    LDA MAT + ROW_SIZE, X
    STA MAT, X
    LDA #0
    STA MAT + ROW_SIZE, X ; Zero out elements below leading element
    LDA MAT + ROW_SIZE * 2, X
    STA MAT + ROW_SIZE * 2, X
    INX
    CPX ROW_SIZE
    BNE FORWARD_ELIM

    ; Check if all elements in row are zero
    LDX #0
    CHECK_ROW:
    LDA MAT, X
    BNE NOT_INVERTIBLE ; Matrix is not invertible if any row is all zero
    INX
    CPX ROW_SIZE
    BNE CHECK_ROW

    ; Matrix is invertible
    BRA INVERTIBLE

NOT_INVERTIBLE:
    LDA #$00
    STA $D020 ; Display NOT INVERTIBLE message
    RTS

INVERTIBLE:
    LDA #$01
    STA $D021 ; Display INVERTIBLE message
    RTS
