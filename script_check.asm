
    .org $0200               ; Start program at address $0200

    LDY #$00                ; Initialize Y register to 0

generate_maze:
    LDA #$FF                ; Load the value $FF (wall) into the accumulator
    STA $0000,Y             ; Set the first cell of the maze to a wall
    INY                     ; Increment Y
    CPY #$20                ; Check if we have completed a row of the maze
    BNE generate_maze       ; If not, continue generating maze

    LDY #$01               ; Start the depth-first search at the second cell
    JSR solve_maze          ; Solve the maze

    BRK                    ; End program

solve_maze:
    LDA $0000,Y            ; Load the current cell
    AND #$0F               ; Mask off the highest four bits
    STA $0100              ; Save the cell in the stack
    LSR                    ; Shift the current cell to the right by one bit
    LSR
    LSR
    LSR
    TAY                    ; Transfer the remainder to Y
    LDA $0100              ; Load the saved current cell
    ORA #$80               ; Set the highest bit
    STA $0100              ; Save the modified current cell
    STA $0000,Y            ; Update the maze with the modified current cell
    LDA $0000,Y            ; Load the modified current cell back
    AND #$F0               ; Mask off the lowest four bits
    STA $0100              ; Save the modified current cell
    LDA $0100              ; Load the modified current cell
    TAY                    ; Transfer the remainder to Y
    LDA $0000,Y            ; Load the cell to the left
    BEQ next_cell          ; If the left cell is empty, move to the next cell
    AND #$F0               ; Mask off the lowest four bits
    BNE solve_maze         ; If the left cell is not empty, continue solving the maze

next_cell:
    LDA $0000,Y            ; Load the current cell
    CMP #$0F               ; Check if the current cell is the last cell
    BNE check_up           ; If not, check the cell above

    RTS                    ; If this is the last cell, return from subroutine

check_up:
    CPY #$20               ; Check if we are at the top row of the maze
    BEQ check_down         ; If we are at the top row, check the cell below
    DEY                    ; Move to the cell above
    LDA $0000,Y            ; Load the cell above
    AND #$0F               ; Mask off the highest four bits
    BNE solve_maze         ; If the cell above is not empty, continue solving the maze

check_down:
    CPY #$1F               ; Check if we are at the bottom row of the maze
    BEQ check_right        ; If we are at the bottom row, check the cell on the right
    INY                    ; Move to the cell below
    LDA $0000,Y            ; Load the cell below
    AND #$0F               ; Mask off the highest four bits
    BNE solve_maze         ; If the cell below is not empty, continue solving the maze

check_right:
    LDA $0000,Y            ; Load the current cell
    CMP #$FF               ; Check if the current cell is a wall
    BEQ back_track         ; If the current cell is a wall, backtrack
    INY                    ; Move to the cell on the right
    BNE solve_maze         ; Continue solving the maze

back_track:
    LDA $0100              ; Load the saved current cell
    AND #$F0               ; Mask off the lowest four bits
    TAY                    ; Transfer the remainder to Y
    LDA $0000,Y            ; Load the cell to the left
    AND #$0F               ; Mask off the highest four bits
    BEQ back_track         ; If the cell to the left is empty, backtrack
    LDA $0100              ; Load the saved current cell
    AND #$0F               ; Mask off the highest four bits
    DEY                    ; Move to the cell above
    LDA $0000,Y            ; Load the cell above
    AND #$0F               ; Mask off the highest four bits
    BNE solve_maze         ; If the cell above is not empty, continue solving the maze

