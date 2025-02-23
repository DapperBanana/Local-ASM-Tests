
; 6502 Assembly program to generate a random maze and find its solution

; Constants
GRID_SIZE = 8
STACK_SIZE = 64

; Variables
maze GRID_SIZE*GRID_SIZE
stackX STACK_SIZE
stackY STACK_SIZE
top STACK_SIZE-1
startX .byte 0
startY .byte 0
endX .byte 0
endY .byte 0

; Random number generator subroutine
rand:
    lda $d41a
    lsr
    lsr
    lsr
    lsr
    adc #$01
    sta $d41a
    jmp $e462

; Initialize stack
init_stack:
    ldy #STACK_SIZE
    sty top
    rts

; Push coordinates onto stack
push:
    lda stackX, y
    sta (stackX), y
    lda stackY, y
    sta (stackY), y
    dey
    sty top
    rts

; Pop coordinates from stack
pop:
    lda (stackX), y
    sta stackX, y
    lda (stackY), y
    sta stackY, y
    iny
    sty top
    rts

; Check if coordinates are valid
is_valid:
    lda #GRID_SIZE
    cmp #00
    bcc :exit
    cmp GRID_SIZE
    bcs :exit
    lda #01
    cmp #00
    bcc :exit
    cmp GRID_SIZE
    bcs :exit
    lda #01
    rts
:exit
    lda #00
    rts

; Find solution using depth-first search
find_solution:
    jsr init_stack
    lda startX
    sta (stackX), y
    lda startY
    sta (stackY), y
    dex
    lda #00
    cpy top
:loop
    lda (stackX), y
    sta currentX
    lda (stackY), y
    sta currentY
    lda currentX
    cmp endX
    lda currentY
    cmp endY
    beq :solved
    lda currentX
    lda currentY
    cmp maze, x+GRID_SIZE*currentY
    jmp :up
    cmp maze, x+GRID_SIZE*currentY
    jmp :right
    cmp maze, x+GRID_SIZE*currentY
    jmp :down
    cmp maze, x+GRID_SIZE*currentY
    jmp :left
    cmp maze, x+GRID_SIZE*currentY
    jmp :backtrack
:up
    ora #01
    jmp :check_direction
:right
    ora #02
    jmp :check_direction
:down
    ora #04
    jmp :check_direction
:left
    ora #08
    jmp :check_direction
:backtrack
    lda #00
    sta maze, x+GRID_SIZE*currentY
    jsr pop
    jmp :loop
:check_direction
    cmp maze, x+GRID_SIZE*currentY
    bne :advance
    ora #0f
    and #maze, x+GRID_SIZE*currentY
    jsr push
    jmp :loop
:advance
    tax
    lda #00
    ora #maze, x+GRID_SIZE*currentY
    sta maze, x+GRID_SIZE*currentY
    inx
    sta (stackX), y
    lda currentY
    sta (stackY), y
    iny
    dey
    cpy top
    bne :loop
    rts
:solved
    lda #01
    rts

; Main program
    jsr rand ; Seed random number generator
    lda #0
    sta startX  ; Start position
    lda #0
    sta startY
    lda #GRID_SIZE-1
    sta endX    ; End position
    lda #GRID_SIZE-1
    sta endY
    ldx #GRID_SIZE*GRID_SIZE-1
:init_maze
    jsr rand
    and #01
    sta maze, x
    dex
    bpl :init_maze
    jsr find_solution
    rts
