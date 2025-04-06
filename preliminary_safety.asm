
    .text
    .org $0200

array:  .byte 5, 2, 8, 6, 3, 6, 9, 7
n:      .byte 8
lis:    .byte 0

    lda #0
    sta lis

loop:
    ldx n
    lda array, x
    sec
    sbc #1
    sta curr
    lda #0
    sta max_len

inner_loop:
    dex
    lda array, x
    cmp curr
    bcc get_next

    lda #1
    sta flag1

    lda lis
    clc
    adc #1
    sta lis
    
    lda lis
    cmp max_len
    bcc update_max_len

get_next:
    dex
    bne inner_loop

update_max_len:
    lda lis
    sta max_len

next:
    lda n
    clc
    adc #1
    sta n
    cmp #8
    bne loop

done:
    rts
