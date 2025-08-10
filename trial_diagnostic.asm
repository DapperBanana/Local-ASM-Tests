
    .org $0200

radius      .byte 10         ; radius of the sector
angle       .byte 60         ; angle of the sector
area        .word 0          ; variable to store the calculated area

    lda radius              ; load radius
    ldx angle               ; load angle
    ldy #360                ; load 360
    jsr divide              ; divide angle by 360
    sta angle               ; store result back in angle

    lda radius              ; load radius
    ldx angle               ; load angle
    jsr multiply            ; calculate radius * angle
    tay                     ; store the result in Y

    ldx #2                  ; load 2
    jsr divide              ; divide by 2
    txa                     ; store the result in X

    ldy y                   ; load radius * angle / 2
    tax                     ; store in X for result
    sty area                ; store in area

    .end

divide:     ; divide Y by X, result in X
loop:       cpY #0
            beq done
            dey
            dex
            bne loop
done:       rts

multiply:   ; Multiply X by Y, result in Y
mloop:      pha
            clc
            lda y
            sec
            sbc #$00
            tax
            lda x
            ldy #$00
            clc
            lda #$00
mlp:        adc x
            dey
            bne mlp
            tax
            plA
            inx
            bne mLoop
            rts

y           .byte 0
x           .byte 0
