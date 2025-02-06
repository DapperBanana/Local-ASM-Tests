
.INVERTIBLE_MATRIX_CHECK
    LDA MATRIX     ; Load the first element of the matrix into the accumulator
    STA TEMP1      ; Store it in TEMP1

    LDA MATRIX+1   ; Load the second element of the matrix into the accumulator
    STA TEMP2      ; Store it in TEMP2

    LDA MATRIX+2   ; Load the third element of the matrix into the accumulator
    STA TEMP3      ; Store it in TEMP3

    LDA MATRIX+3   ; Load the fourth element of the matrix into the accumulator
    STA TEMP4      ; Store it in TEMP4

    JSR DETERMINANT ; Call the determinant subroutine

    BEQ NON_INVERTIBLE  ; If the determinant is 0, the matrix is not invertible

    JMP INVERTIBLE  ; Jump to the invertible label if the determinant is not 0

NON_INVERTIBLE
    ; If the determinant is 0, the matrix is not invertible
    ; Handle the case here...

INVERTIBLE
    ; If the determinant is not 0, the matrix is invertible
    ; Handle the case here...

DETERMINANT
    ; Calculate the determinant of the matrix
    LDA TEMP1
    STA ACC_TEMP1

    LDA TEMP2
    STA ACC_TEMP2

    LDA TEMP3
    STA ACC_TEMP3

    LDA TEMP4
    STA ACC_TEMP4

    ; Calculate the determinant (ad-bc)
    LDA ACC_TEMP1
    CLC
    ADC ACC_TEMP4
    STA TEMP_DET1

    LDA ACC_TEMP2
    SEC
    SBC ACC_TEMP3
    STA TEMP_DET2

    CLC
    LDA TEMP_DET1
    ADC TEMP_DET2

    RTS

TEMP1   .BYTE 0
TEMP2   .BYTE 0
TEMP3   .BYTE 0
TEMP4   .BYTE 0
TEMP_DET1 .BYTE 0
TEMP_DET2 .BYTE 0
ACC_TEMP1 .BYTE 0
ACC_TEMP2 .BYTE 0
ACC_TEMP3 .BYTE 0
ACC_TEMP4 .BYTE 0

MATRIX  .BYTE 1,2,3,4  ; Input your 2x2 matrix data here
