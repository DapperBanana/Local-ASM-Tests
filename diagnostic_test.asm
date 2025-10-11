
start:
    LDX #0         ; Initialize row index
check_rows:
    LDA matrix,X   ; Load first element of current row
    STA temp1      ; Store it in temp variable
    LDX #0         ; Initialize column index
check_columns:
    LDA matrix,X   ; Load first element of current column
    STA temp2      ; Store it in temp variable
    
    LDA temp1      ; Load first element of current row
    CLC            ; Clear carry flag
    ADC temp2      ; Add current column element to accumulator
    BNE not_orthogonal  ; If result is not zero, matrix is not orthogonal
    
    INX            ; Increment column index
    CPX #4         ; Check if all columns have been checked
    BNE check_columns   ; If not, go to next column
    
    INX            ; Increment row index
    CPX #4         ; Check if all rows have been checked
    BNE check_rows      ; If not, go to next row
    
    ; If program reaches this point, matrix is orthogonal
    RTS
    
not_orthogonal:
    ; If program reaches here, matrix is not orthogonal
    BRK

matrix:
    .byte 1, 0, 0, 0
    .byte 0, 1, 0, 0
    .byte 0, 0, 1, 0
    .byte 0, 0, 0, 1
    
temp1: .byte 0
temp2: .byte 0
