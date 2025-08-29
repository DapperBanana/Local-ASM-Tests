
ORG $0600

Matrix1:
    .byte $01, $00, $00
    .byte $00, $01, $00
    .byte $00, $00, $01

Matrix2:
    .byte $01, $00, $00
    .byte $00, $01, $01
    .byte $00, $01, $-1

CheckOrthogonal:
    LDA Matrix1    ; Load the memory address of Matrix1
    STA $00
    LDX $00        ; Load the X index register with the memory address of Matrix1
    LDY $00        ; Load the Y index register with the memory address of Matrix1
    
CheckNextRow:
    LDA Matrix1, X   ; Load the first element of the current row
    STA $01          ; Store it in a temporary memory location
    
    LDX $00
    LDA Matrix1, X+  ; Load the second element of the current row
    STA $02          ; Store it in a temporary memory location
    
    LDX $00
    LDA Matrix1, X+  ; Load the third element of the current row
    STA $03          ; Store it in a temporary memory location
    
    LDX $00
    LDA Matrix1, Y   ; Load the first element of the next row
    STA $04          ; Store it in a temporary memory location
    
    LDX $00
    LDA Matrix1, Y+  ; Load the second element of the next row
    STA $05          ; Store it in a temporary memory location
    
    LDX $00
    LDA Matrix1, Y+  ; Load the third element of the next row
    STA $06          ; Store it in a temporary memory location
    
    ; Calculate dot product of the two rows
    LDA $01
    CLC
    ADC $04
    STA $07
    
    LDA $02
    CLC
    ADC $05
    STA $08
    
    LDA $03
    CLC
    ADC $06
    STA $09
    
    ; If the dot product is not zero, the matrix is not orthogonal
    BEQ MatrixOrthogonal
    BRA MatrixNotOrthogonal
    
MatrixOrthogonal:
    LDA #$01
    STA $F0          ; Store 1 in memory to indicate matrix is orthogonal
    BRK
    
MatrixNotOrthogonal:
    LDA #$00
    STA $F0          ; Store 0 in memory to indicate matrix is not orthogonal
    BRK
    
    .END
