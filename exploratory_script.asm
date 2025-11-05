
   .data
step        .byte    0        ; step size
num_steps   .byte    100      ; number of steps
x_pos       .byte    0        ; x position
y_pos       .byte    0        ; y position

   .text
   .org $C000

start:
   lda #0
   sta step
   sta x_pos
   sta y_pos

loop:
   lda step
   jsr randomize_step
   clc
   adc x_pos
   sta x_pos
   lda step
   jsr randomize_step
   clc
   adc y_pos
   sta y_pos

   lda x_pos
   sta $0200, x
   lda y_pos
   sta $0201, x

   inc step
   cmp num_steps
   bne loop

   jsr plot_graph

   rts

randomize_step:
   lda #$01
   jsr rand
   and #$03
   cmp #$01
   beq randomize_step
   sta step
   rts

rand:
   lda $D012
   ora $D011
   ror
   ror
   ror
   ror
   sta $D011
   lda $D011
   rts

plot_graph:
   lda #$01
   sta $D020

   lda x_pos
   sta $0200
   lda y_pos
   sta $0201

   jsr $FFEE    ; jump to Matplotlib library to plot graph

   lda #$00
   sta $D020

   rts
