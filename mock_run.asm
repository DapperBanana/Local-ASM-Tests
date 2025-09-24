
; Load the maze into memory.
        .org $2000
maze    .byte 8,8,8,8,8,8,8,8
        .byte 8,0,8,0,0,0,0,8
        .byte 8,0,0,0,8,0,8,8
        .byte 8,0,8,0,8,0,0,8
        .byte 8,0,0,0,0,0,8,8
        .byte 8,8,8,8,8,8,8,8
        
start
        lda #1
        sta current_row
        lda #1
        sta current_col
        jsr solve_maze
        
; Print the solved maze.
        jsr print_maze
        rts

solve_maze
next_cell
        ; Check if we have reached the finish cell.
        lda current_row
        cmp #5
        beq maze_solved
        
        ; Check if we have already visited this cell.
        lda current_row
        asl
        clc
        adc current_col
        tax
        lda visited_cells, x
        cmp #1
        beq backtrack
        
        ; Mark the current cell as visited.
        lda current_row
        asl
        clc
        adc current_col
        tax
        lda #1
        sta visited_cells, x
        
        ; Check if we can move down.
        lda maze, x
        cmp #0
        beq move_down
        
        ; Check if we can move right.
        lda current_col
        cmp #6
        beq move_down
        inx
        lda maze, x
        cmp #0
        beq move_right
        
        ; Check if we can move left.
        lda current_col
        beq move_down
        dex
        lda maze, x
        cmp #0
        beq move_left
        
        ; Move up.
        beq move_right
        
move_up jmp next_cell
move_down
        lda current_row
        inc
        sta current_row
        jmp next_cell
move_left
        lda current_col
        dec
        sta current_col
        jmp next_cell
move_right
        lda current_col
        inc
        sta current_col
        jmp next_cell

backtrack
        ; Unmark the current cell as visited.
        lda current_row
        asl
        clc
        adc current_col
        tax
        lda #0
        sta visited_cells, x
        
        ; Move back to the previous cell.
        lda current_col
        cmp #1
        beq backtrack_up
        lda current_col
        cmp #6
        beq backtrack_down
        dex
        jmp next_cell
        
backtrack_up
        lda current_row
        dec
        sta current_row
        jmp next_cell
backtrack_down
        lda current_row
        inc
        sta current_row
        jmp next_cell

maze_solved
        rts

print_maze
        lda #1
        sta current_row
print_row
        lda current_row
        asl
        clc
        adc current_col
        tax
        lda visited_cells, x
        cmp #1
        bne print_wall
        lda maze, x
        jsr print_char
        
print_wall
        lda maze, x
        cmp #8
        bne print_empty
        lda #42
        jsr print_char
        
print_empty
        lda #32
        jsr print_char
        
        lda current_col
        inc
        cmp #8
        bne print_row
        
        lda current_row
        inc
        cmp #6
        bne print_row
        
        rts

print_char
        sta $d020
        lda $d012
        lda #1
        sta $d018
        lda #60
        jsr delay
        lda #0
        sta $d018
        lda #0
        jsr delay
        rts

delay   ldx #0
loop    lda #$FF
        dex
        bne loop
        rts

current_row .byte 0
current_col .byte 0
visited_cells .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

; Run the program
        jsr start
        rts
