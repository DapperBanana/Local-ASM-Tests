
ORG $5000

start:
    LDA #$00       ; Initialize counter to 0
    STA counter

check_rows:
    LDA #$00
    STA row

check_columns:
    LDA #$00
    STA column

    LDX #$00

check_row_loop:
    LDY #$00

check_column_loop:
    LDA sudoku, X
    CMP temp, Y
    BEQ match
    INC Y
    BNE check_column_loop
    JMP invalid

match:
    INC X
    CPX #$10
    BNE check_row_loop

    JMP next_column

invalid:
    LDA #$FF
    STA $6000
    BRK

next_column:
    INC row
    CPY #$09
    BNE check_column_loop

    INC column
    CPY #$09
    BNE check_rows

    LDA #$FF
    STA $6000
    BRK

sudoku:
    .BYTE $01, $02, $03, $04, $05, $06, $07, $08, $09, $01
    .BYTE $02, $03, $04, $05, $06, $07, $08, $09, $01, $02
    .BYTE $03, $04, $05, $06, $07, $08, $09, $01, $02, $03
    .BYTE $04, $05, $06, $07, $08, $09, $01, $02, $03, $04
    .BYTE $05, $06, $07, $08, $09, $01, $02, $03, $04, $05
    .BYTE $06, $07, $08, $09, $01, $02, $03, $04, $05, $06
    .BYTE $07, $08, $09, $01, $02, $03, $04, $05, $06, $07
    .BYTE $08, $09, $01, $02, $03, $04, $05, $06, $07, $08
    .BYTE $09, $01, $02, $03, $04, $05, $06, $07, $08, $09
    .BYTE $01, $02, $03, $04, $05, $06, $07, $08, $09, $01

temp:
    .BYTE $01, $02, $03, $04, $05, $06, $07, $08, $09, $00

counter:
    .BYTE $00
row:
    .BYTE $00
column:
    .BYTE $00

    END start
