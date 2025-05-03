
; 6502 Assembly program to generate a random walk plot using a library like Matplotlib

; Include necessary libraries for plotting
.include "matplotlib.h"

; Constants
SCREEN_WIDTH = 320
SCREEN_HEIGHT = 200
PIXEL_SIZE = 1

; Variables
x_pos = $00
y_pos = $00

; Initialize random number generator
lda #<seed
sta rand_seed
lda #>seed
sta rand_seed + 1

loop:
; Generate random direction
    jsr random
    cmp #4
    bcs down
    cmp #3
    bcs up
    cmp #2
    bcs right
    cmp #1
    bcs left

left:
    lda x_pos
    sec
    sbc #PIXEL_SIZE
    cmp #0
    bne draw
    jmp loop

right:
    lda x_pos
    clc
    adc #PIXEL_SIZE
    cmp #SCREEN_WIDTH
    bne draw
    jmp loop

up:
    lda y_pos
    sec
    sbc #PIXEL_SIZE
    cmp #0
    bne draw
    jmp loop

down:
    lda y_pos
    clc
    adc #PIXEL_SIZE
    cmp #SCREEN_HEIGHT
    bne draw
    jmp loop

draw:
    jsr plot_point
    lda x_pos
    sta temp
    lda y_pos
    sta temp + 1
    jsr plot_point
    lda temp
    sta x_pos
    lda temp + 1
    sta y_pos
    jmp loop

; Subroutine to generate random number between 0-255
random:
    jsr rand
    clc
    and #%11111111
    rts

; Subroutine to plot a point on the plot
plot_point:
    lda x_pos
    sta matplotlib_plot_x
    lda y_pos
    sta matplotlib_plot_y
    lda #$FF ; pixel color
    sta matplotlib_plot_color
    jsr plot_pixel
    rts
