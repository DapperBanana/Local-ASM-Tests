
; Area of a Parallelogram Calculator

    lda #10         ;Length of base
    sta base

    lda #5          ;Height
    sta height

    lda base
    clc
    adc height
    tax

    lda height
    tax

    lda base
    tax

    lda base
    tax

    lda tax
    sta area

    ; output the result
    lda #area       ; load area into accumulator
    sta $0200       ; store accumulator to memory location $0200

    ; end of program..
    brk

base .byte 0
height .byte 0
area .byte 0
