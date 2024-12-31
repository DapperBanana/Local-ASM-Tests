
        .org $1000

matrix  .byte 1, 2
        .byte 3, 4

result  .byte 0

        lda matrix
        sta $00
        lda matrix+1
        sta $01
        lda matrix+2
        sta $02
        lda matrix+3
        sta $03
        
        lda $00
        clc
        lda $03
        adc $02
        beq invertible

not_invertible
        lda #0
        sta result
        rts

invertible
        lda #1
        sta result
        rts
