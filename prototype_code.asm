
; Magic Torus Checker program for 6502 Assembly

; Define constants
MATRIX_SIZE = 5          ; Size of the matrix
MAGIC_CONSTANT = 65      ; Magic constant for a 5x5 matrix

; Define memory locations
MATRIX_START = $0200     ; Start address of the matrix
RESULT = $00FF           ; Result of the magic torus check

; Initialize program
    LDA #$00
    STA RESULT
    
; Loop through the rows of the matrix
CHECK_ROWS:
    LDX #$00               ; Initialize column index
    
; Loop through the columns of the matrix
CHECK_COLS:
    LDA MATRIX_START, X   ; Load matrix element
    CLC
    ADC RESULT            ; Add to the running total
    STA RESULT
    
    INX
    CPX #MATRIX_SIZE      ; Check if end of row
    BNE CHECK_COLS        ; If not, continue checking columns
    
    DEX
    CPX #MATRIX_SIZE+1    ; Check if end of matrix
    BNE CHECK_ROWS        ; If not, continue checking next row
    
; Check if total sum is equal to magic constant
    LDA RESULT
    CMP #MAGIC_CONSTANT
    BEQ IS_MAGIC_TORUS
    
IS_NOT_MAGIC_TORUS:
    NOP
    
IS_MAGIC_TORUS:
    NOP
    
    ; Program ends here
