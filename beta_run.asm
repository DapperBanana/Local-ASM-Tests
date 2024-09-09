
    processor 6502
    include "vcs.h"

start
    lda #$00
    sta COLUBK
    lda #<pattern
    sta ptr0
    lda #>pattern
    sta ptr0+1
    ldx #$00
loop
    lda random,x
    sta GRP0
    lda random+1,x
    sta GRP1
    lda random+2,x
    sta GRP0
    lda random+3,x
    sta GRP1
    dex
    bne loop

    jmp loop

    .org $F000
random
    .byte $AA,$55,$FF,$00,$F0,$0F,$C3,$3C
