
.org $0200

LDA #0           ; Initialize row counter
STA row

LDA #2           ; Initialize column counter
STA column

loop_row:
    LDA row
    CMP #3       ; Check if all rows have been processed
    BEQ done
    
    LDX #0       ; Initialize column index
    
loop_column:
    LDA matrix, X
    STA temp
    
    LDX matrix + column
    LDA temp
    STA matrix + column
    
    STA temp
    LDX temp
    
    INX          ; Move to the next column
    CPX #3       ; Check if all columns have been processed
    BEQ next_row
    
    JMP loop_column
    
next_row:
    INY          ; Move to the next row
    DEX          ; Decrement column counter
    BNE loop_column
    
    LDA row
    INY          ; Move to the next row
    STA row
    
    LDA #2
    STA column
    
    JMP loop_row

done:
    BRK
    
temp: .byte 0
row: .byte 0
column: .byte 0

matrix: 
    .byte 1, 2, 3
    .byte 4, 5, 6
    .byte 7, 8, 9
