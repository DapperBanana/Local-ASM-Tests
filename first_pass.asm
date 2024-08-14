
    .org $0200
    
MatrixData:
    .byte 1, 2, 3, 4  ; Sample 2x2 matrix
    
    LDA MatrixData    ; Load matrix element A
    STA $01           ; Store element A in memory location $01
    
    LDA MatrixData+1  ; Load matrix element B
    STA $02           ; Store element B in memory location $02
    
    LDA MatrixData+2  ; Load matrix element C
    STA $03           ; Store element C in memory location $03
    
    LDA MatrixData+3  ; Load matrix element D
    STA $04           ; Store element D in memory location $04
    
    ; Calculate the determinant of the matrix
    LDA $01           ; Load element A
    CLC
    ADC $04           ; Add element D
    STA $05           ; Store A + D
    
    LDA $02           ; Load element B
    CLC
    ADC $03           ; Add element C
    STA $06           ; Store B + C
    
    ; Calculate determinant
    LDA $05
    CLC
    ADC $06
    STA $07           ; Store determinant value
    
    ; Check if the determinant is non-zero
    LDA $07
    BEQ NotInvertible ; Branch if determinant is zero
    
    ; Determinant is non-zero, matrix is invertible
    JMP Invertible
    
NotInvertible:
    ; Determinant is zero, matrix is not invertible
    JMP NotInvertible
    
Invertible:
    ; Matrix is invertible, add your code here
    
    BRK               ; End program
    
    .org $FFFC
    .word $0200
