
.nolist
.include "vcs.h"
.list

.byte $78,$A9,$FF,$8D,$FE,$02,$A9,$FF
.byte $8D,$FF,$02,$A9,$00,$8D,$00,$02,$A9
.byte $00,$8D,$01,$02,$60

.proc main
    LDA #$FF
    STA $02FE
    LDA #$FF
    STA $02FF
    LDA #$00
    STA $0200
    LDA #$00
    STA $0201

    jsr plot_random_walk

    rts
.endproc

.proc plot_random_walk
    LDA #$00
    STA $02FA
    LDA #$00
    STA $02FB

random_loop:
    jsr plot_point

    ; Generate random direction
    lda rand_seed
    clc
    adc $02FA
    tax
    lda rand_table,x
    adc $02FB
    sta $02FA

    lda rand_seed+1
    clc
    adc $02FA
    tax
    lda rand_table,x
    adc $02FB
    sta $02FB

    iny

    cpy #$10
    bne random_loop

    rts
.endproc
