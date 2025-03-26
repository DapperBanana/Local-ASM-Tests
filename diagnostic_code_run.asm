
START:
    lda #0        ; Initialize variables
    sta index
    lda #0
    sta low
    lda #9
    sta high
    lda #5        ; Key to search for
    sta key

BINARY_SEARCH:
    lda low
    clc
    adc high
    lsr
    sta mid

    lda mid
    asl
    ldx mid
    lda list, x
    cmp key
    beq FOUND
    bcc LOW_HALF

HIGH_HALF:
    lda mid
    inx
    sta low
    bne BINARY_SEARCH

LOW_HALF:
    lda mid
    dex
    sta high

    lda low
    cmp high
    bcc BINARY_SEARCH

NOT_FOUND:
    lda #0xff
    rts

FOUND:
    lda mid
    rts

list:
    .byte 1, 2, 3, 4, 5, 6, 7, 8, 9
    .end
