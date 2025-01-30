
START:  LDX #0         ; Initialize row counter
        LDY #0         ; Initialize column counter
        LDA MATRIX,X   ; Load first element of matrix
        BEQ NOT_INVERTIBLE  ; If element is zero, matrix is not invertible
        INX            ; Increment row counter
        BNE NEXT_ROW   ; If row counter is not zero, go to next row
        INY            ; Increment column counter
        TYA
        CMP #2         ; Check if all elements have been checked
        BEQ INVERTIBLE ; If all elements have been checked, matrix is invertible
NEXT_ROW:
        LDA MATRIX,X   ; Load next element of matrix
        BEQ NOT_INVERTIBLE  ; If element is zero, matrix is not invertible
        INX            ; Increment row counter
        BNE NEXT_ROW   ; If row counter is not zero, go to next row
        INY            ; Increment column counter
        TYA
        CMP #2         ; Check if all elements have been checked
        BEQ INVERTIBLE ; If all elements have been checked, matrix is invertible
NOT_INVERTIBLE:
        LDX #0         ; Set invertible flag to 0
        JMP END        ; End program
INVERTIBLE:
        LDX #1         ; Set invertible flag to 1
END:    RTS            ; End of program

MATRIX: .BYTE 1, 2     ; Define 2x2 matrix

