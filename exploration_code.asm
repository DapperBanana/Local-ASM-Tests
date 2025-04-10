
STACK_START = $FF00
STACK_PTR = $00
STACK_SIZE = 16

    .org $FF00
stack_data .rs STACK_SIZE
    .org $FF00

main:
    lda #STACK_START
    sta STACK_PTR

    ; Push 1 onto the stack
    lda #1
    jsr push

    ; Push 2 onto the stack
    lda #2
    jsr push

    ; Pop the last value from the stack
    jsr pop
    sta $F0

    ; Pop the next value from the stack
    jsr pop
    sta $F1

    ; Halt
    brk

push:
    lda STACK_PTR
    sta $FF
    lda #$01
    clc
    adc $FF
    sta $FF
    tax
    lda stack_data, x
    sta $FF
    rts

pop:
    lda STACK_PTR
    sta $FF
    lda #$FF
    clc
    adc $FF
    sta $FF
    tax
    lda stack_data, x
    jsr clear_top
    rts

clear_top:
    lda STACK_PTR
    sta $FF
    lda #$00
    tax
    lda stack_data, x
    sta stack_data, x
    rts
