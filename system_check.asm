
        .org $0200

start:
        lda matrix1      ; load matrix values
        sta $FE          ; store in zero page
        lda matrix2
        sta $FF
        lda matrix3
        sta $100

        jsr determinant  ; calculate determinant
        jmp $FFD2        ; break

matrix1:
        .byte 1, 2, 3
matrix2:
        .byte 4, 5, 6
matrix3:
        .byte 7, 8, 9

determinant:
        lda #0
        sta $FD          ; initialize determinant

        lda $FE
        sta $F0          ; store matrix values
        lda $FF
        sta $F1
        lda $100
        sta $F2

        lda $FE          ; calculate determinant
        ldy $FF
        ldx $100
        clc
        lda $F0
        adc $F4
        adc $F8
        sta $F4
        lda $F1
        adc $F6
        adc $FA
        sta $F6
        lda $F2
        adc $F2
        adc $F6
        sta $F8
        lda $FE
        sbc $F4
        sbc $F8
        sta $FE
        lda $FF
        sbc $F5
        sbc $F9
        sta $FF
        lda $100
        sbc $F6
        sbc $FA
        sta $100

        lda $FE
        mul $F0
        sta $FD
        lda $FF
        mul $F6
        clc
        adc $FD
        sta $FD
        lda $100
        mul $FA
        clc
        adc $FD
        sta $FD

        lda $FE
        mul $F6
        sec
        sbc $FD
        sta $FD
        lda $FF
        mul $F2
        sec
        sbc $FD
        sta $FD
        lda $100
        mul $F4
        sec
        sbc $FD
        sta $FD

        rts


        .org $FFD2
        .word start
