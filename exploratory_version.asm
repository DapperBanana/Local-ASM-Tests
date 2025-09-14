
; 6502 Assembly program to solve a basic text-based maze

START    LDA #$00         ; Load start position
         STA current_row
         LDA #$00
         STA current_col

         JSR print_maze   ; Print maze
         JSR solve_maze    ; Solve maze

         BRK

print_maze
         LDA #$03         ; Load maze size
         STA maze_size

print_loop ; Print maze loop
         LDA current_row
         CLC
         ADC current_col
         STA temp

         LDX temp
         LDA maze_text, X
         JSR $FFD2       ; Print character

         INX
         TXA
         CLC
         ADC #$03
         TXA
         STA current_col

         LDX current_col
         CPX maze_size
         BNE print_loop

         LDA current_row
         INC
         STA current_row

         LDX maze_size
         CPX maze_size
         BNE print_loop

         RTS

solve_maze
         LDA current_row
         CMP #$04           ; Check if reached end of maze
         BEQ end

         LDA current_col
         CMP #$04

         BEQ end

         LDA current_row
         CLC
         ADC current_col
         TAX

         LDA maze_text, X
         CMP #$20           ; Check if wall
         BEQ next_direction

         LDA current_col
         CMP #$00
         BEQ next_direction

         DEC current_col     ; Move left
         JMP solve_maze

next_direction
         LDA current_row
         CLC
         ADC current_col
         TAX

         LDA maze_text, X
         CMP #$20           ; Check if wall
         BEQ next_direction2

         LDA current_col
         CMP #$0F
         BEQ next_direction2

         INC current_col     ; Move right
         JMP solve_maze

next_direction2
         LDA current_row
         CLC
         ADC current_col
         TAX

         LDA #$20
         STA maze_text, X
         STA current_col

         INC current_row     ; Move down
         JMP solve_maze

end      RTS

current_row .BYTE
current_col .BYTE
maze_size   .BYTE
temp        .BYTE

maze_text  .BYTE  "#### ##  ####", $00
