
; Sudoku validation program for 9x9 grid
; Check each row, column, and 3x3 square for duplicates

START   LDA #0         ; Initialize valid flag
        STA VALID

        JSR CHECK_ROWS     ; Check rows for duplicates
        JSR CHECK_COLS     ; Check columns for duplicates
        JSR CHECK_SQUARES  ; Check 3x3 squares for duplicates

        LDA VALID      ; Check valid flag
        BEQ INVALID     ; Branch if invalid
        BRK           ; Exit program

INVALID
        LDA #0
        STA $6000      ; Display invalid message
        LDA #1
        STA $6001
        LDA #2
        STA $6002
        BRK

CHECK_ROWS
        LDX #0         ; Initialize row index
CHECK_ROWS_LOOP
        LDY #0         ; Initialize column index
CHECK_ROWS_COL_LOOP
        LDA BOARD,X    ; Load number from board
        BEQ CHECK_COLS_OK  ; Branch if end of row
        STA NUMBER     ; Store number
CHECK_ROWS_COL_LOOP_CHECK
        INY            ; Increment column index
        CPY #9         ; Check end of row
        BNE CHECK_ROWS_COL_LOOP  ; Branch if not end of row
        INX            ; Increment row index
        CPX #9         ; Check end of board
        BNE CHECK_ROWS_LOOP  ; Branch if not end of board
        RTS

CHECK_COLS
        LDX #0         ; Initialize column index
CHECK_COLS_LOOP
        LDY #0         ; Initialize row index
CHECK_COLS_ROW_LOOP
        LDA BOARD,Y    ; Load number from board
        BEQ CHECK_SQUARES_OK  ; Branch if end of column
        STA NUMBER     ; Store number
CHECK_COLS_ROW_LOOP_CHECK
        INY            ; Increment row index
        CPY #9         ; Check end of column
        BNE CHECK_COLS_ROW_LOOP  ; Branch if not end of column
        INX            ; Increment column index
        CPX #9         ; Check end of board
        BNE CHECK_COLS_LOOP  ; Branch if not end of board
        RTS

CHECK_SQUARES
        LDX #0         ; Initialize square index
CHECK_SQUARES_LOOP
        LDY #0         ; Initialize offset index
CHECK_SQUARES_OFFSET_LOOP
        LDA BOARD,X,Y  ; Load number from board
        BEQ CHECK_SQUARES_OK  ; Branch if end of square
        STA NUMBER     ; Store number
CHECK_SQUARES_OFFSET_LOOP_CHECK
        INY            ; Increment offset index
        CPY #9         ; Check end of square
        BNE CHECK_SQUARES_OFFSET_LOOP  ; Branch if not end of square
        INX            ; Increment square index
        CPX #9         ; Check end of board
        BNE CHECK_SQUARES_LOOP  ; Branch if not end of board
        RTS

CHECK_ROWS_OK
        LDA NUMBER     ; Load number to compare
        CMP TEMP       ; Compare with temporary number
        BNE CHECK_COLS_OK  ; Branch if not equal
        LDA #1          ; Set flag to invalid
        STA VALID
        RTS

CHECK_COLS_OK
        LDA NUMBER     ; Load number to compare
        CMP TEMP       ; Compare with temporary number
        BNE CHECK_SQUARES_OK  ; Branch if not equal
        LDA #1          ; Set flag to invalid
        STA VALID
        RTS

CHECK_SQUARES_OK
        LDA NUMBER     ; Load number to compare
        CMP TEMP       ; Compare with temporary number
        BNE CHECK_SQUARES_END  ; Branch if not equal
        LDA #1          ; Set flag to invalid
        STA VALID
CHECK_SQUARES_END
        INY            ; Increment offset index
        CPY #9         ; Check end of square
        BNE CHECK_SQUARES_OFFSET_LOOP  ; Branch if not end of square
        RTS

BOARD   .BYTE 1, 2, 3, 4, 5, 6, 7, 8, 9
        .BYTE 4, 5, 6, 7, 8, 9, 1, 2, 3
        .BYTE 7, 8, 9, 1, 2, 3, 4, 5, 6
        .BYTE 2, 3, 4, 5, 6, 7, 8, 9, 1
        .BYTE 5, 6, 7, 8, 9, 1, 2, 3, 4
        .BYTE 8, 9, 1, 2, 3, 4, 5, 6, 7
        .BYTE 3, 4, 5, 6, 7, 8, 9, 1, 2
        .BYTE 6, 7, 8, 9, 1, 2, 3, 4, 5
        .BYTE 9, 1, 2, 3, 4, 5, 6, 7, 8

NUMBER  .BYTE 0
TEMP    .BYTE 0
VALID   .BYTE 0

        .ORG $FFFC
        .WORD START
