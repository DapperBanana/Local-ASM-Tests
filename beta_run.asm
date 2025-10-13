
; Set up maze dimensions
maze_width = 10
maze_height = 10
maze_size = maze_width * maze_height

; Declare variables
maze_data .block maze_size
stack .block 256

; Generate random maze
generate_maze:
    lda #0
    sta maze_data, x
    inx
    cpx #maze_size
    bne generate_maze

; Find solution
find_solution:
    lda #0
    sta stack, x
    lda #0
    sta stack+1, x
    ldx #1

next_step:
    lda stack, x
    cmp maze_size
    beq solution_found

    ; Move up
    lda stack+1, x
    sec
    sbc maze_width
    bcs next_dir

    ; Push up
    inc stack+1, x
    lda stack+1, x
    sta stack, x
    inx
    jmp next_step

next_dir:
    ; Move down
    clc
    adc maze_width
    bcc next_dir

    ; Move left
    lda stack+1, x
    sec
    sbc #1
    bcs next_dir

    ; Push left
    inc stack+1, x
    lda stack+1, x
    sta stack, x
    inx
    lda stack, x
    jmp next_step

solution_found:
    ; Output solution
    lda #0
    ldx #0
output_solution:
    lda stack, x
    sta maze_data, x
    inx
    lda stack+1, x
    sta maze_data, x
    inx
    lda #'.'
    sta maze_data, x
    inx
    cpx #maze_size
    bne output_solution

    ; Halt program
    rts

    .end
