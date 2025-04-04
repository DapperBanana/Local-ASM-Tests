
        ; Assume the matrix is represented in memory at address MAT_START
        ; with each row stored consecutively in memory and each element
        ; taking up a byte

        LDX #0 ; Initialize index for row number
LOOP    LDA MAT_START, X ; Load first element of row
        STA ELEMENT ; Store in a temporary location
        LDA ELEMENT ; Load element for comparison
        STA SUM_ROW ; Initialize sum for current row
        LDA #0 ; Initialize index for column number
COL_LOOP
        LDA MAT_START, X ; Load current element
        CLC
        ADC SUM_ROW ; Add to current row sum
        STA SUM_ROW ; Update row sum
        INX ; Move to next column
        CPX #3 ; Check if end of row reached
        BNE COL_LOOP ; Loop back if not
        CMP ELEMENT ; Check if row sum is equal to first element
        BNE NOT_MAGIC ; If not equal, matrix is not magic square
        INX ; Move to next row
        CPX #3 ; Check if end of matrix reached
        BNE LOOP ; Loop back if not
        JMP IS_MAGIC ; If all rows are equal to first element, matrix is magic
NOT_MAGIC
        ; Output not magic square
        LDA #$00 ; Exit program
        JSR $FFD2

IS_MAGIC
        ; Output magic square
        LDA #$01 ; Exit program
        JSR $FFD2

ELEMENT .BYTE 0
SUM_ROW .BYTE 0
MAT_START .BYTE 1,2,3,4,5,6,7,8,9
