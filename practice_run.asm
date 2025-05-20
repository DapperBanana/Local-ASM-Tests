
        ;
        ; Check if a given matrix is orthogonal
        ; Assumption: Matrix is a square matrix
        ;

        .org $0200

        ; Define the matrix
        matrix .byte $01, $00, $00
                .byte $00, $-1, $00
                .byte $00, $00, $1

        ; Load the address of the matrix
        lda #<matrix
        sta matrix_ptr
        lda #>matrix
        sta matrix_ptr+1
        
        ; Initialize the flag for orthogonal matrix
        lda #true
        sta is_orthogonal

check_rows:
        ; Load row index
        lda row_index
        clc
        lda matrix_ptr
        adc row_index
        sta row_ptr

        lda #0
        sta col_index

check_cols:
        ; Load col index
        lda col_index
        clc
        lda row_ptr
        adc col_index
        tax
        lda (matrix_ptr), x

        ; Multiply current row with current column
        clc
        lda A_reg
        mul (matrix_ptr), x
        sta A_reg

        ; Update column index
        inx
        cpx #3
        bne check_cols

        ; Check if the sum is 0
        lda A_reg
        bne not_orthogonal

        ; Update row index
        inc row_index
        cmp #3
        bne check_rows

done:
        lda #true
        rts

not_orthogonal:
        lda #false
        rts

        .org $0300
        
        ; Data
matrix_ptr .word 0
row_ptr .word 0
row_index .byte 0
col_index .byte 0
A_reg .byte 0
is_orthogonal .byte 0

true .byte 255
false .byte 0
