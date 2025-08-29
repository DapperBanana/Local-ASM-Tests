
SudokuValidator:
    LDX #0              ; initialize column index to 0

CheckRows:
    LDA #0              ; initialize foundRowFlags to 0
    STA foundRowFlags
    LDA #0              ; clear row bitmask
    STA rowBitmask

CheckNextRow:
    LDA (SudokuGrid),X  ; load a value from the SudokuGrid
    CMP #0              ; check if it is 0 (empty cell)
    BEQ SkipCheckRow    ; if it is, skip the row check
    TAX
    ASL                 ; shift the value left 1 bit
    ORA rowBitmask      ; set the corresponding bit in the row bitmask
    STA rowBitmask

    LDA rowBitmask
    AND foundRowFlags   ; check if the bit is already set
    BNE InvalidSolution ; if it is, then it is invalid

    ORA foundRowFlags   ; set the corresponding bit in the foundRowFlags
    STA foundRowFlags

SkipCheckRow:
    INX
    CPX #9              ; check if all columns have been checked
    BNE CheckNextRow

    LDA foundRowFlags   ; check if all rows have been found
    CMP #0xFF
    BNE InvalidSolution ; if not, then it is invalid

    INX
    CPX #81             ; check if all cells have been validated
    BNE CheckRows

ValidSolution:
    RTS

InvalidSolution:
    LDA #0              ; store error value in A
    RTS

; Place the SudokuGrid data here
SudokuGrid:
    .byte 5,3,4,6,7,2,1,9,8
    .byte 6,7,8,1,9,5,3,4,2
    .byte 9,1,2,3,4,8,5,6,7
    .byte 8,5,9,7,6,1,4,2,3
    .byte 4,2,6,8,5,3,7,9,1
    .byte 7,9,1,2,4,6,8,5,3
    .byte 1,6,7,9,8,4,2,3,5
    .byte 3,4,5,2,1,7,9,8,6
    .byte 2,8,3,4,6,9,1,7,0 ; example invalid solution
