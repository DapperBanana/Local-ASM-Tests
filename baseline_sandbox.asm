
; Assume the matrix is stored in memory starting at address $2000
; The matrix size is 3x3

LDX #0 ; Initialize row index to 0
LDY #0 ; Initialize column index to 0

loop:
    LDA $2000,X ; Load current element from matrix
    
    ; Multiply current row with other rows
    LDX #0 ; Reset column index
    multiply:
        LDA $2000,X ; Load current element from matrix
        CMP $2000,Y ; Compare it with element in current row
        BNE not_orthogonal ; If not orthogonal, exit loop
        INX
        CPX #3
        BNE multiply
    
    INY
    CPY #3
    BNE loop

orthogonal:
    ; Matrix is orthogonal
    BRK

not_orthogonal:
    ; Matrix is not orthogonal
    BRK
