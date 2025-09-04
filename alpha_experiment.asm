
; Constants
WIDTH = 10
HEIGHT = 10
START_ROW = 1
START_COL = 1
END_ROW = HEIGHT - 2
END_COL = WIDTH - 2
MAZE_SIZE = WIDTH*HEIGHT

; Variables
maze: .block MAZE_SIZE
visited: .block MAZE_SIZE
stack: .block MAZE_SIZE*2
stack_ptr: .word 0
solution: .block MAZE_SIZE
solution_ptr: .word 0
adjacent: .block 4
adjacent_ptr: .word 0

; Entry point
start:
    lda #0
    sta maze, x
    sta visited, x
    lda #1
    sta visited, START_ROW*WIDTH + START_COL
    ldx #START_ROW
    ldy #START_COL
    jsr generate_maze
    jsr solve_maze
    rts

; Generate the maze
generate_maze:
    lda #0
    sta stack_ptr
    lda #0
    sta solution_ptr
    ldx #START_ROW
    ldy #START_COL
    jsr visit_cell
    ldx #END_ROW
    ldy #END_COL
    jsr visit_cell
    .repeat MAZE_SIZE
        ldy #0
        lda maze, x
        tay
        .repeat 8
            jsr get_random_adjacent
            cpy #4
            beq continue
            jsr visit_adjacent
            lda adjacent_ptr
            iny
            sta adjacent, y
            inx
            lda adjacent_ptr
            iny
            sta adjacent, y
            dex
            lda adjacent_ptr
            iny
            sta adjacent, y
            inx
            lda adjacent_ptr
            iny
            sta adjacent, y
        .until y #4
        continue:
        lda #0
        sta adjacent_ptr
        lda stack_ptr
        cmp solution_ptr
        bcs backtrack
        lda stack, x
        ldx #0
        sta solution, y
        iny
        lda stack, x
        sta solution, y
        iny
        inx
        lda #1
        sta stack_ptr
        lda stack, x
        sta x
        rts
        backtrack:
        dex
        lda solution, x
        sta y
        dey
        lda solution, x
        sta y
        rts
    .until x #MAZE_SIZE

; Visit a cell in the maze
visit_cell:
    lda visited, x
    bne end
    sta visited, x
    lda stack_ptr
    sta stack, y
    iny
    lda x
    sta stack, y
    iny
    inx
    sta stack_ptr
    lda #1
    sta x
    jsr mark_cell
    lda y
    sta y
    lda x
    sta x
    lda #1
    sta adjacent_ptr
    rts
    end:
    rts

; Mark a cell as visited
mark_cell:
    lda x
    asl
    clc
    adc y
    sta z
    lda #1
    sta maze, z
    rts

; Get a random adjacent cell
get_random_adjacent:
    lda #0
    sta adjacent_ptr
    lda maze, z
    beq next
    lda #1
    sta adjacent, y
    iny
    lda z
    sta adjacent, y
    iny
    lda #1
    sta adjacent_ptr
    rts
    next:
    lda #1
    sta adjacent_ptr
    rts

; Visit an adjacent cell
visit_adjacent:
    lda adjacent_ptr
    asl
    tay
    lda adjacent, y
    bne next
    lda adjacent, x
    bne next
    ldw #1
    sta adjacent_ptr
    rts
    next:
    lda adjacent_ptr
    asl
    tay
    dec y
    lda y
    sta y
    lda adjacent_ptr
    asl
    tay
    dec y
    lda y
    sta y
    lda adjacent_ptr
    asl
    tay
    lda y
    sta y
    ldx y
    ldy adjacent_ptr
    lda x
    sta y
    lda x
    sta y
    lda #0
    sta adjacent_ptr
    jsr visit_cell
    lda x
    asl
    clc
    adc y
    sta z
    lda #1
    sta maze, z
    rts

; Solve the maze using depth-first search
solve_maze:
    lda stack, x
    sta x
    inx
    lda stack, x
    sta y
    inx
    jsr visit_cell
    rts

; Utility functions
get_random:
    jsr get_random_byte
    lda random_value
    rts

get_random_byte:
    lda #123 ; seed for random number generator
    ldx #123 ; seed for random number generator
    jsr random
    rts
random:
    asl
    rol random_value
    asl
    rol random_value
    asl
    rol random_value
    asl
    rol random_value
    asl
    rol random_value
    asl
    rol random_value
    asl
    rol random_value
    lda random_value
    rts

