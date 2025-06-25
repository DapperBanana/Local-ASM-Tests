
        .org $1000

; Maze Constants
WALL = %1111
SPACE = %0000
VISITED = %0010

; Maze Size
WIDTH = 8
HEIGHT = 8

; Maze Data
maze_data: .ds 64
solution: .ds 64

start_addr = $1800

        lda #$20
        sta $4017

; Initialize Random Number Generator
init_random:
        lda #<seed_value
        sta $FF
        lda #>seed_value
        sta $FE

; Generate Random Maze
generate_maze:
        ldx #0
loop_x:
        ldy #0
loop_y:
        lda $FF
        ; Generate random value for each cell
        and #1
        tay
        sta maze_data, x, y
        dey
        ; Check if reached end of row
        bne loop_y
        inx
        ; Check if reached end of maze
        cpx #WIDTH
        bne loop_x

; Find Solution
find_solution:
        lda #<start_addr
        sta $200
        lda #>start_addr
        sta $201
        ldx #0
        ldy #0
loop:
        lda maze_data, x, y
        ; Check if current cell is the exit
        cmp #$80
        beq found_solution
        ; Check if current cell is a wall or visited
        cmp #$10
        bne not_wall_or_visited
        ; Move to next cell
        inx
        jmp loop
not_wall_or_visited:
        ; Mark cell as visited
        ora #$10
        sta maze_data, x, y
        ; Move to next cell
        jmp next_cell
found_solution:
        lda #$FF
        sta maze_data, x, y
next_cell:
        jmp loop

seed_value: .byte $5A

        .org $1800

; Main Program
start:
        jsr init_random
        jsr generate_maze
        jsr find_solution
        rts

        .end
