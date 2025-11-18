
START:
    ; Load the matrix into memory
    LDX #0         ; Outer loop counter
OUTER_LOOP:
    LDY #0         ; Inner loop counter
INNER_LOOP:
    LDA MATRIX,X   ; Load value from matrix into accumulator
    STA TEMP1      ; Store value in temporary variable 1
    INY            ; Increment inner loop counter
    CPY #3         ; Check if inner loop counter reaches 3
    BNE CHECK_ROW  ; If not, check the row
    LDA #0         ; Reset inner loop counter
    STA Y          
    
CHECK_ROW:
    LDA TEMP1      ; Load value from temporary variable 1 into accumulator
    ADC MATRIX,Y   ; Add value from matrix
    CMP #15        ; Check if sum is equal to 15 (for 3x3 magic square)
    BNE NOT_MAGIC  ; If not, matrix is not a magic square
    INX            ; Increment outer loop counter
    CPX #3         ; Check if outer loop counter reaches 3
    BNE OUTER_LOOP ; If not, continue checking rows
    JMP MAGIC_SQUARE

NOT_MAGIC:
    LDA #0         ; Not a magic square
    RTS

MAGIC_SQUARE:
    LDA #1         ; Magic square
    RTS

; Define the 3x3 matrix values
MATRIX:
    .byte 4, 9, 2
    .byte 3, 5, 7
    .byte 8, 1, 6
    
TEMP1:
    .byte 0
