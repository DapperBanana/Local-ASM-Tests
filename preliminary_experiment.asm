
; Binary Search in 6502 Assembly

    .org $1000

list    .byte $10, $20, $30, $40, $50, $60, $70, $80, $90, $A0
size    = *-list

start
    lda #0
    sta index
    lda #size
    sta end
    lda #0
    sta found

search_loop
    lda end
    cmp index
    beq end_search

    lda index
    lsr
    lsr
    lsr
    lsr
    clc
    adc #list
    tax

    lda target
    cmp $00,x
    beq found

    bcc update_index
    lda index
    clc
    adc #1
    sta index
    bra search_loop

update_index
    lda index
    sec
    sbc #1
    sta end

end_search
    lda found
    rts

found
    lda #1
    sta found
    rts
