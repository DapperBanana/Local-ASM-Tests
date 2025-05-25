
        .org $1000

checkMagicTorus:
        lda #0              ; Initialize sum to 0
        sta sum

        lda matrix_size     ; Load matrix size
        clc
        adc matrix_size     ; Double the size for correct number of elements
        tax                  ; Store the double size in X register

loop:
        lda matrix, x       ; Load element from matrix
        clc
        adc sum             ; Add element to sum
        sta sum             ; Store the new sum
        dex                  ; Decrement X
        bpl loop             ; Check if all elements have been processed

        lda sum              ; Load final sum

        ldx #0               ; Initialize index for checking rows
checkRows:
        ldy #0               ; Initialize index for checking columns
checkColumns:
        lda matrix, x, y     ; Load element from matrix
        clc
        adc sum             ; Add element to sum
        bne notMagicTorus   ; Branch if sum does not equal expected value
        iny                  ; Increment Y
        cpy matrix_size     ; Check if all columns have been checked
        bne checkColumns
        inx                  ; Increment X
        cpx matrix_size     ; Check if all rows have been checked
        bne checkRows

        lda #1              ; Set flag to 1 if magic torus
        rts

notMagicTorus:
        lda #0              ; Set flag to 0 if not a magic torus
        rts

        .org $2000
matrix:
        .byte 1, 2, 3
        .byte 4, 5, 6
        .byte 7, 8, 9

matrix_size:
        .byte 3

        .end
