
        .org $0600

matrix  .byte 3, 6, 9
        .byte 1, 4, 7
        .byte 2, 5, 8

result  .byte 0

start   lda #0
        sta result

        ldx #0
loop    lda matrix, x
        cmp #0
        beq continue

        lda matrix, x
        sta $fe
        lda matrix, x+1
        sta $ff
        lda matrix, x+2
        sta $100

        ldy #0
        lda matrix, y
        sta $fc
        lda matrix, y+3
        sta $fd
        lda matrix, y+6
        sta $fe

        lda matrix, y+1
        sta $fb
        lda matrix, y+4
        sta $fc
        lda matrix, y+7
        sta $fd

        lda matrix, y+2
        sta $fa
        lda matrix, y+5
        sta $fb
        lda matrix, y+8
        sta $fc

        lda $fc
        asl
        asl
        asl
        sta $ee

        lda $fd
        asl
        asl
        asl
        sta $ef

        lda $100
        asl
        asl
        asl
        sta $f0

        lda $fb
        asl
        asl
        asl
        sta $f1

        lda $fa
        asl
        asl
        asl
        sta $f2

        lda $fd
        asl
        asl
        asl
        sta $f3

        lda $fc
        asl
        asl
        asl
        sta $f4

        lda $f2
        clc
        adc $f3
        sta $f5
        lda $f2
        adc $f4
        sta $f6

        lda $ee
        clc
        adc $f5
        sta result

continue
        inx
        cpx #3
        bne loop

        rts
