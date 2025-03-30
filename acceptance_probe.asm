
        .inesprg 1
        .inesmir 1
        .proc zpvar
zp_tmp .dsb 2
zp_index .dsb 1
zp_len .dsb 1
        .endproc

        .proc reverse_words
        lda #<sentence
        sta zpvar
        lda #>sentence
        sta zpvar + 1
        ldx #0
        ldy #0
        lda (zpvar), y
        beq end_reverse

find_word:
        lda (zpvar), y
        beq end_sentence
        cmp #" "
        beq end_word
        iny
        cpy #0
        bne find_word

end_word:
        lda zp_index
        inx
        sta zp_index
        sta zp_tmp + 1, x
        cpx #0
        beq end_sentence
        lda #0
        sta zp_index
        inx
        sta zp_tmp, x
        lda #" "
        sta zp_tmp + 1, x
        inc y
        ldy #0
        cpx #0
        beq find_word

end_sentence:
        lda zp_index
        bne reverse
        dec x

reverse:
        lda zp_tmp, x
        sta (zpvar), y
        lda zp_tmp + 1, x
        sta (zpvar), y + 1
        iny
        iny
        dex
        bpl reverse
        lda #" "
        sta (zpvar), y
        lda #" "
        sta (zpvar), y + 1
        jmp find_word

end_reverse:
        rts
        
sentence:
        .asciiz "Hello world Assembly program"

        .endproc

        .proc main
        jsr reverse_words
        rts
        .endproc
