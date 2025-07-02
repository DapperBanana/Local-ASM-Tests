
        .org    $0200

matrix  .byte   1, 2, 3, 4
        .byte   2, 5, 6, 7
        .byte   3, 6, 8, 9
        .byte   4, 7, 9, 10

        .org    $0300
result  .byte   0

        .org    $0400
        lda     #0
        sta     result

        lda     #0
outer   sta     index
        lda     #0
inner   sta     index2

check_symmetry:
        lda     index
        cmp     #4
        beq     done

        lda     index2
        cmp     #4
        beq     next_row

        lda     index
        clc
        adc     index2
        tax
        lda     matrix, x
        lda     index2
        clc
        adc     index
        tax
        lda     matrix, x
        cmp     a
        bne     not_symmetric

        inc     index2
        bra     inner

next_row:
        lda     index
        clc
        adc     #1
        sta     index
        lda     #0
        sta     index2
        bra     outer

not_symmetric:
        lda     #1
        sta     result
        bra     done

done:
        lda     result
        rts

index   .byte   0
index2  .byte   0

        .end
