
.ORG $0200

    LDA MATRIX1    ; Load the first element of the matrix into the accumulator
    STA TEMP1      ; Store it in a temporary variable

    LDA MATRIX2    ; Load the second element of the matrix into the accumulator
    STA TEMP2      ; Store it in a temporary variable

    LDA MATRIX3    ; Load the third element of the matrix into the accumulator
    STA TEMP3      ; Store it in a temporary variable

    LDA MATRIX4    ; Load the fourth element of the matrix into the accumulator
    STA TEMP4      ; Store it in a temporary variable

    ; Calculate the determinant of the matrix
    CLC
    LDA TEMP1
    ADC TEMP4
    STA PRODUCT1
    LDA TEMP2
    ADC TEMP3
    STA PRODUCT2

    LDA PRODUCT1
    SEC
    SBC PRODUCT2
    STA DETERMINANT

    ; Check if the determinant is non-zero (i.e., if the matrix is invertible)
    LDA DETERMINANT
    BNE INVERTIBLE

NOT_INVERTIBLE:
    ; Matrix is not invertible
    LDA #$00
    STA RESULT
    BRK

INVERTIBLE:
    ; Matrix is invertible
    LDA #$01
    STA RESULT
    BRK

MATRIX1  .BYTE  $01    ; Element (1,1) of the matrix
MATRIX2  .BYTE  $02    ; Element (1,2) of the matrix
MATRIX3  .BYTE  $03    ; Element (2,1) of the matrix
MATRIX4  .BYTE  $04    ; Element (2,2) of the matrix

TEMP1    .BYTE  $00    ; Temporary variable for element (1,1)
TEMP2    .BYTE  $00    ; Temporary variable for element (1,2)
TEMP3    .BYTE  $00    ; Temporary variable for element (2,1)
TEMP4    .BYTE  $00    ; Temporary variable for element (2,2)

PRODUCT1 .BYTE  $00    ; Temporary variable for product of element (1,1) and element (2,2)
PRODUCT2 .BYTE  $00    ; Temporary variable for product of element (1,2) and element (2,1)

DETERMINANT .BYTE $00  ; Determinant of the matrix

RESULT   .BYTE  $00    ; Result of the invertibility check

    .END
