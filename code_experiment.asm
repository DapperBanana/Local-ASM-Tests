
LDA #$00
STA current_row

validate_sudoku:
    LDA #$00
    STA current_col

next_row:
    LDA current_row
    CLC
    ADC #$09
    STA row_end
    
next_col:
    LDA current_col
    CLC
    ADC #$09
    STA col_end
    
    LDX #$00
    
validate_row:
    LDA (current_row, X)
    BEQ validate_col
    STA number_seen
    
    INX
    CPX row_end
    BNE validate_row
    
validate_col:
    LDX #$00
    
validate_col_loop:
    LDA (X, current_col)
    BEQ next_col
    CMP number_seen
    BEQ next_col
    INX
    CPX col_end
    BNE validate_col_loop
    
    INY
    CPY #$09
    BNE next_col
    
    CLC
    ADC #$09
    BEQ sudoku_valid
    STA current_row
    JMP validate_sudoku
    
sudoku_valid:
    ; Sudoku solution is valid
    BRK
    
current_row: .byte $00
current_col: .byte $00
row_end: .byte $00
col_end: .byte $00
number_seen: .byte $00
