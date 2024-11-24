
        .org $0200

matrix  .byte $01, $02, $03
        .byte $04, $05, $06
        .byte $07, $08, $09

det     .word $0000

        ldx #0
        ldy #0

row1    lda matrix, x
        clc
        adc matrix+4, y
        adc matrix+8, x
        sta det
        
row2    lda matrix+1, x
        clc
        adc matrix+5, y
        adc matrix+7, x
        sta det
        
row3    lda matrix+2, x
        clc
        adc matrix+6, y
        adc matrix+8, x
        sta det
        
        ldy det
        sty det+1
        
        rts
