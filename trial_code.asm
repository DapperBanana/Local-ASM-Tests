
; Random Maze Generation and Solver using Depth-First-Search Algorithm
; Author: Assistant

; Constants
WIDTH = 16
HEIGHT = 16
MAZE_SIZE = WIDTH * HEIGHT
STACK_SIZE = MAZE_SIZE + 1
UP = 0
RIGHT = 1
DOWN = 2
LEFT = 3

; Variables
ZP_PTR = $00
MAZE = $0100
STACK = MAZE + MAZE_SIZE

; Entry Point
START:
    ; Initialize random seed
    LDA #<START
    STA $FA
    LDA #>START
    STA $FB

    ; Generate random maze
    JSR generate_maze

    ; Solve maze using depth-first search algorithm
    JSR solve_maze

    ; End program
    BRK

; Generate Random Maze
generate_maze:
    LDX #0
    STX ZP_PTR
loop_generate_maze:
    TXA
    CLC
    ADC #$80
    ROR A
    STA (ZP_PTR),Y
check_end_generate_maze:
    INX
    CPX #MAZE_SIZE
    BNE loop_generate_maze
    RTS

; Solve Maze using Depth-First Search
solve_maze:
    LDA #MAZE + WIDTH + 1
    STA STACK

    LDX #2
    STX ZP_PTR

loop_solve_maze:
    LDY (ZP_PTR),Y
    LDY #4
loop_directions:
    LDA (ZP_PTR),Y
    BEQ end_directions

    CMP #UP
    BEQ up_direction
    CMP #RIGHT
    BEQ right_direction
    CMP #DOWN
    BEQ down_direction
    CMP #LEFT
    BEQ left_direction

    JMP next_direction
up_direction:
    TXA
    SEC
    SBC #16
    BPL next_direction
    STY (ZP_PTR)
    DEY
    JMP loop_directions
right_direction:
    TXA
    SEC
    SBC #1
    CMP ZP_PTR
    BNE next_direction
    STY (ZP_PTR)
    DEY
    JMP loop_directions
down_direction:
    TXA
    CLC
    ADC #16
    BPL next_direction
    STY (ZP_PTR)
    DEY
    JMP loop_directions
left_direction:
    TXA
    CLC
    ADC #1
    CMP ZP_PTR
    BNE next_direction
    STY (ZP_PTR)
    DEY
    JMP loop_directions
end_directions:
    JMP next_iteration
next_direction:
    INY
    JMP loop_directions
next_iteration:
    INC ZP_PTR
    LDA (ZP_PTR)
    STA (STACK),Y
    DEY

    TXA
    CLC
    ADC #1
    CMP ZP_PTR
    BCC loop_solve_maze
    DEC STACK
    JMP next_iteration
