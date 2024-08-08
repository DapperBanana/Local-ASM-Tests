
            .org $0200      ; Start program at address $0200

            LDA MATRIX     ; Load first element of matrix into A register
            STA TEMP1       ; Store it into TEMP1

            LDA MATRIX+1    ; Load second element of matrix into A register
            STA TEMP2       ; Store it into TEMP2

            LDA MATRIX+2    ; Load third element of matrix into A register
            STA TEMP3       ; Store it into TEMP3

            LDA MATRIX+3    ; Load fourth element of matrix into A register
            STA TEMP4       ; Store it into TEMP4

            ; Check if the determinant of the matrix is non-zero
            LDX TEMP1       ; Load TEMP1 into X register
            LDY TEMP4       ; Load TEMP4 into Y register
            JSR MULTIPLY    ; Call subroutine to multiply TEMP1 and TEMP4
            STA PRODUCT1    ; Store the result in PRODUCT1

            LDX TEMP2       ; Load TEMP2 into X register
            LDY TEMP3       ; Load TEMP3 into Y register
            JSR MULTIPLY    ; Call subroutine to multiply TEMP2 and TEMP3
            STA PRODUCT2    ; Store the result in PRODUCT2

            LDA PRODUCT1    ; Load PRODUCT1 into A register
            STA TEMP5       ; Store it into TEMP5

            LDA PRODUCT2    ; Load PRODUCT2 into A register
            STA TEMP6       ; Store it into TEMP6

            LDX TEMP5       ; Load TEMP5 into X register
            SEC             ; Set carry flag
            SBC TEMP6       ; Subtract TEMP6 from A register
            BNE INVERTIBLE  ; If result is non-zero, matrix is invertible
            JMP NOT_INVERTIBLE ; If result is zero, matrix is not invertible

INVERTIBLE: JMP $FF00     ; Jump to location $FF00 if matrix is invertible

NOT_INVERTIBLE: JMP $FF00 ; Jump to location $FF00 if matrix is not invertible

MULTIPLY:   CLC         ; Clear carry flag
            ADC Y       ; Add Y register to A register
            RTS         ; Return from subroutine

            .org $FF00    ; Reserved memory location for program
MATRIX:     .byte 1, 2, 3, 4  ; Define the 2x2 matrix to be checked

TEMP1:      .byte 0      ; Temporary storage for first element of matrix
TEMP2:      .byte 0      ; Temporary storage for second element of matrix
TEMP3:      .byte 0      ; Temporary storage for third element of matrix
TEMP4:      .byte 0      ; Temporary storage for fourth element of matrix
TEMP5:      .byte 0      ; Temporary storage for determinant calculation
TEMP6:      .byte 0      ; Temporary storage for determinant calculation
PRODUCT1:   .byte 0      ; Temporary storage for product of elements
PRODUCT2:   .byte 0      ; Temporary storage for product of elements
