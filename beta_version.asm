
DATA_START = $1000
SCREEN_START = $4000
SCREEN_WIDTH = 40
SCREEN_HEIGHT = 20

    .org $0200
start:
    lda #0
    sta $D020      ; Clear screen
    sta $D021
    
    ldx #0
    lda #<DATA_START
    ldy #>DATA_START

draw_loop:
    lda (x),y        ; Load x-coordinate
    tax
    inx
    lda (x),y        ; Load y-coordinate
    sta $D800,x      ; Plot data point
    
    inx
    cpx #SCREEN_WIDTH
    bne draw_loop
    
    rts

; Data dictionary
.word 5,10    ; Data point 1
.word 10,15   ; Data point 2
.word 15,5    ; Data point 3
.word 20,20   ; Data point 4
.word 25,10   ; Data point 5

    .org $FFFA
    .word start
    .word start
    .word start
