
        .org    $0200

; Define matrices A and B
A       .byte   1, 2, 3, 4
B       .byte   5, 6, 7, 8

; Define matrix C to store the result of multiplication
C       .byte   0, 0, 0, 0

        lda     #$00      ; Initialize loop counter
        sta     $FC       ; Store loop counter in memory location $FC

multiply_loop:
        ldx     #$00      ; Initialize inner loop counter

inner_loop:
        lda     A, x      ; Load element from matrix A
        ldy     B, x      ; Load element from matrix B
        clc
        adc     C, x      ; Add to corresponding element in matrix C
        sta     C, x      ; Store result in matrix C

        inx                ; Increment inner loop counter
        cpx     #$02      ; Check if end of row
        bne     inner_loop

        lda     $FC       ; Load outer loop counter
        clc
        adc     #$01      ; Increment outer loop counter
        sta     $FC       ; Store updated outer loop counter

        cmp     #$02      ; Check if end of row
        bne     multiply_loop

done:
        rts
