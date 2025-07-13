
* Load starting address of matrix into X
    LDX #MATRIX_START

* Load number of rows into Y
    LDY #3

* Loop through each row
LOOP_ROW:
    * Load starting address of current row into Z
    LDA X
    STA Z
    INX
    LDA X
    STA Z+1
    INX
    LDA X
    STA Z+2
    INX

    * Load number of columns into AC
    LDA #3

    * Load starting address of current column into Y
    LDA Z
    STA Y

* Loop through each column within the row
LOOP_COL:
    * Load value at current cell into ACC
    LDA (Y),Y
    STA TEMP

    * Load value from corresponding cell in reversed order into ACC
    LDA (Z),Y
    STA (Y),Y

    * Store value from ACC into reversed cell
    LDA TEMP
    STA (Z),Y

    * Move to next column
    INY

    * Decrement number of columns
    DEC 

    * Check if end of row is reached
    BNE LOOP_COL

    * Move to next row
    INC Z
    DEC Y

    * Decrement number of rows
    DEY

    * Check if end of matrix is reached
    BNE LOOP_ROW

MATRIX_START .BYTE 1, 2, 3
            .BYTE 4, 5, 6
            .BYTE 7, 8, 9

TEMP .BYTE 0
