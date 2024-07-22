
        .org $0200
start   lda #<text
        sta ptr
        lda #>text
        sta ptr+1

encrypt lda (ptr),y
        cmp #0
        beq done
        adc #shift
        sta (ptr),y
        iny
        bne encrypt

done    rts

text    .byte "HELLO, WORLD!",0
ptr     .word 0
shift   .byte 3
