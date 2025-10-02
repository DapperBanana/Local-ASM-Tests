
; Sudoku Validator Program

; Constants
GRID_SIZE = 9

ORG $0000

START:
    JSR VALIDATE_SUDOKU
    BRK

VALIDATE_SUDOKU:
    LDX #0
CHECK_ROWS:
    ; Check each row for duplicates
    JSR CHECK_ROW
    INX
    CPX GRID_SIZE
    BNE CHECK_ROWS

    LDX #0
CHECK_COLS:
    ; Check each column for duplicates
    JSR CHECK_COL
    INX
    CPX GRID_SIZE
    BNE CHECK_COLS

    LDX #0
CHECK_SUBGRIDS:
    ; Check each 3x3 subgrid for duplicates
    JSR CHECK_SUBGRID
    INX
    CPX GRID_SIZE
    BNE CHECK_SUBGRIDS

    RTS

CHECK_ROW:
    LDA #1
CHECK_COL:
    STA $FF ; Initialize flags to check for duplicates

    LDX #0
CHECK_DIGIT:
    LDY #0
    LDA BOARD, X ; Load current digit
    CMP $FF
    BEQ DUPLICATE_FOUND

    INY
    CPY GRID_SIZE
    BNE CHECK_NEXT

    RTS

DUPLICATE_FOUND:
    LDA #0
    STA $FF
    RTS

CHECK_NEXT:
    INY
    LDA BOARD, Y ; Load digit to compare
    CMP BOARD, X
    BEQ DUPLICATE_FOUND

    INX
    CPX GRID_SIZE
    BNE CHECK_DIGIT

    RTS

CHECK_SUBGRID:
    LDA #0
    STA $FF

    LDX #0
    LDY #0
CHECK_SUBGRID_ROW:
    TYA
    CMP #3
    BEQ NEXT_SUBGRID

    LDY #0
CHECK_SUBGRID_COL:
    LDX #0

    LDA BOARD, X
    CMP $FF
    BEQ SUBGRID_DUPLICATE_FOUND

    INY
    CPY #3
    BNE CHECK_DIGIT_SUBGRID

    INC Y
    JMP CHECK_SUBGRID_COL

SUBGRID_DUPLICATE_FOUND:
    LDA #0
    STA $FF
    RTS

CHECK_DIGIT_SUBGRID:
    LDA BOARD, X
    CMP BOARD, Y
    BEQ SUBGRID_DUPLICATE_FOUND

    INX
    CPX #3
    BNE CHECK_DIGIT_SUBGRID

    INC Y
    JMP CHECK_SUBGRID_COL

NEXT_SUBGRID:
    LDX #3
    INY
    CPY #3
    BNE CHECK_SUBGRID_ROW

    RTS

; Sudoku board data
BOARD:
    .byte 5, 3, 4, 6, 7, 8, 9, 1, 2
    .byte 6, 7, 2, 1, 9, 5, 3, 4, 8
    .byte 1, 9, 8, 3, 4, 2, 5, 6, 7
    .byte 8, 5, 9, 7, 6, 1, 4, 2, 3
    .byte 4, 2, 6, 8, 5, 3, 7, 9, 1
    .byte 7, 1, 3, 9, 2, 4, 8, 5, 6
    .byte 9, 6, 1, 5, 3, 7, 2, 8, 4
    .byte 2, 8, 7, 4, 1, 9, 6, 3, 5
    .byte 3, 4, 5, 2, 8, 6, 1, 7, 9

.END
