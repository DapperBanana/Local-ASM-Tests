
        .org $1000

init:
        lda #0
        sta $02
        lda #0
        sta $03
        lda #255
        sta $04
        lda #255
        sta $05
        jmp generate
loop:
        lda $00
        cmp #$10
        bne generate
        lda $01
        cmp #$10
        bne finished
generate:
        lda $02
        clc
        adc #$01
        sta $02
        lda $02
        lsr
        lsr
        lsr
        sta $06
        lda $02
        and #$07
        sta $07
        lda $03
        clc
        adc #$01
        sta $03
        lda $03
        lsr
        lsr
        lsr
        sta $08
        lda $03
        and #$07
        sta $09
        lda $06
        rol
        ora $07
        sta $0A
        lda $08
        rol
        ora $09
        sta $0B
        lda ($0A),x
        ora #$08
        sta ($0A),x
        lda ($0B),y
        ora #$80
        sta ($0B),y
        lda ($0A),x
        and #$08
        bne generate
        lda ($0B),y
        and #$80
        bne generate
        lda $00
        clc
        adc #$01
        sta $00
        bne loop
        inc $01
        bne loop
finished:
        brk

maze:
        .ds 256
        .end
