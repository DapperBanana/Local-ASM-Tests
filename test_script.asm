
        .org $0200

sentence    .asciiz "Hello world! This is a test sentence."
reversed    .ds 40
temp        .byte 0
index       .byte 0

init:
        lda #sentence
        sta index
        lda #reversed
        sta index+1

reverseLoop:
        lda (index),y
        beq end

        cmp #$20
        bne notSpace

        jsr reverseWord
        jmp reverseLoop

notSpace:
        dey
        bpl reverseLoop

end:
        rts

reverseWord:
        iny
        stx temp

reverseCharLoop:
        dey
        lda (index),y
        sta (index),x
        lda (index),y
        sta (index),y
        inx
        cpx temp
        bne reverseCharLoop

        ldx temp
        stx temp
        rts

        .end
