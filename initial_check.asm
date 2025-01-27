
ORG $8000

LDX #$00       ; Initialize X Register to 0

CheckOrthogonal:
    LDA matrix, X  ; Load value from matrix data into A Register
    STA $FF        ; Store value in temporary memory location $FF
    
    INX            ; Increment X Register
    CPX #$09       ; Check if all elements in the matrix have been processed
    BNE CheckOrthogonal  ; If not, continue loop
    
    LDX #$00       ; Reset X Register to 0
    
CheckOrthogonalLoop:
    LDA matrix, X  ; Load value from matrix data into A Register
    STA $FE        ; Store value in temporary memory location $FE
    
    LDX #$00       ; Reset X Register to 0
    
    CheckOrthogonalInnerLoop:
        LDA matrix, X  ; Load value from matrix data into A Register
        CLC
        ADC matrix, X  ; Add value from matrix data to A Register
        BEQ NotOrthogonal  ; If sum is 0, matrix is not orthogonal
        
        INX            ; Increment X Register
        CPX #$02       ; Check if all elements in the row have been processed
        BNE CheckOrthogonalInnerLoop  ; If not, continue inner loop
        
    INX            ; Increment X Register
    CPX #$09       ; Check if all rows in the matrix have been processed
    BNE CheckOrthogonalLoop  ; If not, continue loop
    
    JMP IsOrthogonal  ; Matrix is orthogonal
    
NotOrthogonal:
    JMP NotOrthogonal  ; Matrix is not orthogonal
    
IsOrthogonal:
    JMP IsOrthogonal  ; Matrix is orthogonal

matrix:
    .byte 1, 0, 0
    .byte 0, 1, 0
    .byte 0, 0, 1

END
