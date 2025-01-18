
; Random Maze Generator and Solver
;
; Algorithm:
; 1. Generate a random maze using depth-first search algorithm
; 2. Solve the maze using a simple depth-first search algorithm

; Definitions
maze_width = 10
maze_height = 10
stack_size = 50

; Variables
maze_data = $2000
stack_data = $3000

; Main program
start:
    jsr generate_maze
    jsr solve_maze
    rts

; Generate a random maze
generate_maze:
    lda #$00
    sta maze_data, x
    lda #$00
    sta stack_data, x
    lda #$00
    sta stack_data + 1, x
    lda #$00
    sta stack_data + 2, x
    lda #$00
    sta stack_data + 3, x
    lda #$01
    sta stack_data + 4, x
    lda #$01
    sta stack_data + 5, x
    lda #$01
    sta stack_data + 6, x
    lda #$01
    sta stack_data + 7, x
    lda #$01
    sta stack_data + 8, x
    lda #$00
    sta stack_data + 9, x
    lda #$00
    sta stack_data + 10, x

    ; Initialize maze
    lda #$01
    ldx #$00
init_maze_loop:
    sta maze_data, x
    inc x
    cpx #maze_width
    bne init_maze_loop

    lda #$01
    ldx #$00
    txa
    asl
    clc
    adc #maze_width
    tax

    ldx #$00
init_maze_loop2:
    sta maze_data, x
    txs
    jsr generate_maze_recursive
    tsx

    inc x
    cpx #maze_height
    bne init_maze_loop2

    rts

generate_maze_recursive:
    ; Generate random direction
    lda stack_data + 10
    and #$01
    beq generate_maze_recursive_x

    lda stack_data + 10
    lsr
    sta stack_data + 10
    lda stack_data + 9
    lsr
    sta stack_data + 9
    lda stack_data + 9
    asl
    clc
    adc maze_width
    sta stack_data + 9
    lda stack_data, x
    asl
    tax
    lda stack_data + 9
    adc x
    sta stack_data + 9
    tax
    jmp generate_maze_done

generate_maze_recursive_x:
    lda stack_data + 10
    lsr
    sta stack_data + 10
    lda stack_data + 9
    lsr
    sta stack_data + 9
    lda stack_data + 9
    asl
    clc
    adc #$01
    sta stack_data + 9
    lda stack_data, x
    asl
    tax
    lda stack_data + 9
    adc x
    sta stack_data + 9
    tax

generate_maze_done:
    lda stack_data + 9
    sta stack_data, x
    lda stack_data + 9
    asl
    tax
    lda stack_data, x
    asl
    tax
    lda maze_data, x
    ora #$10
    sta maze_data, x
    lda maze_data + 1, x
    ora #$01
    sta maze_data + 1, x
    ldc #$05
    clc
    adc #$02
    clc
    sta stack_data + 11, x

generate_maze_done2:
    ldax
    sta stack_data + 12, x
    txa
    asl
    tax
    txa
    asl
    tax
    lda maze_data, x
    clc
    ora #$10
    sta maze_data, x
    lda maze_data + 1, x
    ora #$01
    sta maze_data + 1, x

    lda stack_data + 12, x
    sta stack_data, x
    inx
    lda stack_data + 11, x
    cmp #$02
    bcc generate_maze_recursive
    ldx stack_data + 2, x
    lda stack_data + 1, x
    inx
    lda stack_data + 2, x
    rol
    clc
    adc #maze_width
    sta x
    lda stack_data + 1, x
    sec
    sbc #$01
    sta stack_data + 1, x
    lda stack_data + 2, x
    clc
    adc #maze_height
    sta stack_data + 2, x
    jmp generate_maze_done2

; Solve the maze
solve_maze:
    ; Initialize maze solver
    lda #$00
    sta stack_data

    lda #maze_width
    sta stack_data + 1
    lda #maze_height
    sta stack_data + 2

    lda #$00
    tay

solver_loop:
    lda maze_data, y
    and #$01
    beq solver_loop_next

    lda maze_data + 1, y
    beq solver_loop_next

    lda maze_data + 2, y
    beq solver_loop_next

    lda maze_data + 3, y
    beq solver_loop_next

    lda maze_data + 4, y
    beq solver_loop_next

    lda stack_data + 14
    tax
    lda y
    inx
    tay
    lda #maze_width
    sec
    sbc stack_data + 2
    inx
    tay
    tax
    lda x
    cmp #maze_width
    bne solver_loop_next
