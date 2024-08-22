
        .org $0200

msg     .asc "HELLO, WORLD!"
key     .byte 3
len     = * - msg

encrypt:
        ldx #0
loop:
        lda msg, x
        beq done
        cmp #$41
        bcc skip
        cmp #$5B
        bcc is_lower

is_upper:
        clc
        adc key
        cmp #$5B
        bcc store
        sbc #$1A

store:
        sta msg, x
        inx
        bne loop
        bcs done

skip:
        inx
        bne loop
        bcs done

is_lower:
        clc
        adc key
        cmp #$7B
        bcc store
        sbc #$1A
        bcs store

done:
        rts

decrypt:
        ldx #0
dloop:
        lda msg, x
        beq ddone
        cmp #$41
        bcc dskip
        cmp #$45
        bcs dis_lower

dis_upper:
        sec
        sbc key
        cmp #$40
        bcc dstore
        adc #$1A

dstore:
        sta msg, x
        inx
        bne dloop
        bcs ddone

dskip:
        inx
        bne dloop
        bcs ddone

dis_lower:
        sec
        sbc key
        cmp #$60
        bcc dstore
        adc #$1A
        bcs dstore

ddone:
        rts

        .end
