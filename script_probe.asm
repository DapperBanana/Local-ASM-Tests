
; Constants
LDX #3          ; Matrix size
LDA #0          ; Initialize sum variables
STA sum
STA rowSum
STA colSum

; Matrix data
matrix:
    .byte 2, 9, 4
    .byte 7, 5, 3
    .byte 6, 1, 8

; Check rows
checkRows:
    LDA #0          ; Initialize index
    STA index
    
checkRowLoop:
    LDX #3          ; Reset row sum
    STA rowSum
    
checkRowCol:
    LDA matrix,X    ; Load value from matrix
    CLC
    ADC rowSum      ; Add to row sum
    STA rowSum
    
    INX             ; Increment column index
    DEX             ; Decrement matrix index
    BNE checkRowCol ; Repeat for all columns
    
    LDA rowSum
    CMP sum         ; Compare row sum to total sum
    BNE notMagic    ; If not equal, matrix is not a magic square
    
    INC index       ; Increment row index
    CPX #9
    BNE checkRows   ; Repeat for all rows
    
    ; Matrix is a magic square
    JMP magicSquare
    
notMagic:
    ; Matrix is not a magic square
    JMP notMagicSquare

magicSquare:
    ; Magic square message or further processing
    
notMagicSquare:
    ; Not magic square message or further processing
