
; Random Walk program in 6502 Assembly

.include "vcs.h"

.segment "BSS"
x_pos: .byte 0    ; X position
y_pos: .byte 0    ; Y position

.segment "CODE"
.org $1000

start:
    lda #0
    sta x_pos    ; Initialize X position
    sta y_pos    ; Initialize Y position

loop:
    ; Generate random direction
    lda #$01
    jsr rand    ; Call random number generation subroutine
    and #$03    ; Mask lower 2 bits

    cmp #$00
    beq north
    cmp #$01
    beq east
    cmp #$02
    beq south
    cmp #$03
    beq west

north:
    dec y_pos    ; Move North
    bne draw_point
    inc y_pos
    jmp loop

east:
    inc x_pos    ; Move East
    bne draw_point
    dec x_pos
    jmp loop

south:
    inc y_pos    ; Move South
    bne draw_point
    dec y_pos
    jmp loop

west:
    dec x_pos    ; Move West
    bne draw_point
    inc x_pos
    jmp loop

draw_point:
    ; Draw point at (x_pos, y_pos) using Matplotlib
    lda x_pos
    sta 2    ; Plot X coordinate
    lda y_pos
    sta 3    ; Plot Y coordinate
    jsr PLOT

    jmp loop

rand:
    lda $d013    ; Read timer
    ror        ; Rotate right
    ror
    ror
    ror
    tax
    rts

.include "plotter.s" ; Include Matplotlib plotter subroutine

.end 
