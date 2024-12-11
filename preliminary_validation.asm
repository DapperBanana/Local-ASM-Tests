
; Constants
NUM_ROWS = 3
NUM_COLS = 3

; Matrix A
A .byte 1, 2, 3
   .byte 4, 5, 6
   .byte 7, 8, 9

; Matrix B
B .byte 9, 8, 7
   .byte 6, 5, 4
   .byte 3, 2, 1

; Result Matrix
RESULT .ds NUM_ROWS * NUM_COLS

; Start of program
        lda #NUM_ROWS      ; Load number of rows
        sta ROWS
        lda #NUM_COLS      ; Load number of columns
        sta COLS
        
        ; Perform addition
        ldx #0             ; Initialize row index
add_loop:
        lda ROWS           ; Load number of rows
        clc
        cmp #NUM_ROWS      ; Compare with total number of rows
        beq add_done       ; If all rows are processed, exit loop
        
        ldy #0             ; Initialize column index
add_col_loop:
        lda ROWS           ; Load number of rows
        mul COLS           ; Multiply by number of columns
        clc
        tay                ; Store in Y register
        
        lda A, x           ; Load element from matrix A
        clc
        adc B, x           ; Add corresponding element from matrix B
        sta RESULT, x      ; Store result in result matrix
        
        iny                ; Move to next column
        inx                ; Move to next row
        tya                ; Load back to Y register
        
        lda ROWS
        clc
        tay                ; Store in Y register
        
        cmp Y              ; Compare with total number of elements
        bne add_col_loop   ; If all columns are not processed, continue with next column
        
        inx                ; Move to next row
        jmp add_loop       ; Continue with next row
        
add_done:

        ; Perform subtraction
        ldx #0             ; Initialize row index
sub_loop:
        lda ROWS           ; Load number of rows
        clc
        cmp #NUM_ROWS      ; Compare with total number of rows
        beq sub_done       ; If all rows are processed, exit loop
        
        ldy #0             ; Initialize column index
sub_col_loop:
        lda ROWS           ; Load number of rows
        mul COLS           ; Multiply by number of columns
        clc
        tay                ; Store in Y register
        
        lda A, x           ; Load element from matrix A
        sec
        sbc B, x           ; Subtract corresponding element from matrix B
        sta RESULT, x      ; Store result in result matrix
        
        iny                ; Move to next column
        inx                ; Move to next row
        tya                ; Load back to Y register
        
        lda ROWS
        clc
        tay                ; Store in Y register
        
        cmp Y              ; Compare with total number of elements
        bne sub_col_loop   ; If all columns are not processed, continue with next column
        
        inx                ; Move to next row
        jmp sub_loop       ; Continue with next row
        
sub_done:

        ; End of program
        rts

ROWS    .byte 0
COLS    .byte 0

