
.INCLUDE "6502.h"

; Define constants
DIM = 3                ; Dimension of the matrix
SIZE = DIM * DIM       ; Total number of elements in the matrix

; Define variables
matrix: .BYTE SIZE     ; Define matrix of size DIM x DIM
is_magic_square: .BYTE 1 ; Flag to check if matrix is magic square

; Entry point
start:
    LDX #0              ; Initialize X register to 0
check_magic:
    LDA matrix, X       ; Load element from matrix
    STA $00             ; Store element to temporary location
    STA $FF             ; Copy element to another temporary location for comparison

    LDA (matrix, X)     ; Load element from matrix
    CLC
    ADC $FF             ; Add element to cumulative sum
    STA $FF             ; Store cumulative sum

    INX                   ; Increase X
    CPX DIM              ; Compare if end of row is reached
    BNE check_magic      ; Branch if not end of row

    LDA $FF              ; Load cumulative sum
    CMP #15              ; Compare with magic number (sum of each row/column/diagonal)
    BEQ is_magic         ; Branch if magic square found

    LDA #0               ; Clear the flag
    STA is_magic_square

is_magic:
    ; Check if matrix is magic square
    LDA is_magic_square   ; Load flag from memory
    BEQ not_magic         ; Branch if not a magic square

    LDA #$01             ; Load 1 to print message that matrix is a magic square
    BNE end              ; Branch to end

not_magic:
    LDA #$00             ; Load 0 to print message that matrix is not a magic square

end:
    BRK                   ; Exit program

.END
