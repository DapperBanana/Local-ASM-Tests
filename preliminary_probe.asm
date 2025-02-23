
        .org    $0200

matrix  .byte   1, 2, 3, 4   ; 2x2 matrix: {{1, 2}, {3, 4}}
det     .word   0            ; determinant of the matrix

start   lda     #$00          ; initialize determinant to 0
        sta     det

        lda     matrix        ; load matrix element a (1st row, 1st column)
        sta     $fb           ; store it in $fb

        lda     matrix+1      ; load matrix element b (1st row, 2nd column)
        sta     $fc           ; store it in $fc

        lda     matrix+2      ; load matrix element c (2nd row, 1st column)
        sta     $fd           ; store it in $fd

        lda     matrix+3      ; load matrix element d (2nd row, 2nd column)
        sta     $fe           ; store it in $fe

        ldy     #$00          ; initialize index y to 0

loop    lda     $fb           ; load matrix element a
        cmp     $fe           ; compare it with matrix element d
        bmi     neg_det       ; branch if a < d

        lda     $fc           ; load matrix element b
        cmp     $fd           ; compare it with matrix element c
        bmi     neg_det       ; branch if b < c

        sta     det           ; store determinant

neg_det lda     det           ; load determinant
        eor     #$FF          ; negate the determinant
        inc     det           ; increment the determinant

        brk                   ; end program

        .end
