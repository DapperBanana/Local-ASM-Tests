
    ; Maze generation using Recursive Depth-first Search algorithm

    .org $1000

start:
    jsr init_maze
    jsr generate_maze

    ; Place your code for finding maze solution here

    rts

init_maze:
    lda #$ff
    sta maze, y
    sty maze_index
    rts

generate_maze:
    jsr carve_passage
    jsr carve_passage
    jsr carve_passage
    jsr carve_passage
    rts

carve_passage:
    lda maze, y
    bne skip
    lda maze_index
    sta (maze, y)
    iny
    lda maze_index
    sta (maze, y)
    lda maze_index
    clc
    adc #$01
    sta maze_index
    jsr generate_maze
skip:
    dec maze_index
    rts

maze:
    .ds 64
maze_index:
    .byte 0

    .end
