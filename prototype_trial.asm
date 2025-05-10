
        .org $2000

        lda #6        ; Load the number of rows
        sta rows

        lda #3        ; Load the number of columns
        sta cols

        lda #<- Numbers for Matrix A -> ; Load Matrix A data
        sta matrixA
        lda #<- Numbers for Matrix B -> ; Load Matrix B data 
        sta matrixB

        jsr add_matrices   ; Call subroutine to add matrices
        jsr print_result   ; Call subroutine to print result

        jsr subtract_matrices   ; Call subroutine to subtract matrices
        jsr print_result        ; Call subroutine to print result

end:    brk

; Subroutine to add two matrices
add_matrices:
        ldx #0
loop1:  lda matrixA, x
        clc
        adc matrixB, x
        sta result, x
        inx
        cpx rows
        bne loop1
        rts

subtract_matrices:
        ldx #0
loop2:  lda matrixA, x
        sec
        sbc matrixB, x
        sta result, x
        inx
        cpx rows
        bne loop2
        rts

print_result:
        ldx #0
        ldy #0
print_loop:
        lda result, x
        jsr print_hex
        inx
        iny
        cpx rows
        bne print_loop
        rts

print_hex:
        lda #$30
        jsr print_char
        and #$0F
        clc
        adc #$30
        jsr print_char
        rts

print_char:
        sta $D020
        lda #$0D
        sta $D021
        lda #$0A
        sta $D021
        rts

        .org $3000

rows:   .byte 0
cols:   .byte 0

matrixA: .byte 0, 1, 2, 3, 4, 5, 6, 7, 8
matrixB: .byte 8, 7, 6, 5, 4, 3, 2, 1, 0
result: .byte 0, 0, 0, 0, 0, 0, 0, 0, 0

        .end
