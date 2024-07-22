
        .org $0600

maze_data:
        .byte %11111111   ; Maze map data - 1 represents wall, 0 represents path
        .byte %10000001
        .byte %10110101
        .byte %10111101
        .byte %10000001
        .byte %11111111

start_x:
        .byte 1            ; Starting position x-coordinate
start_y:
        .byte 1            ; Starting position y-coordinate

current_x:
        .byte 1            ; Current position x-coordinate
current_y:
        .byte 1            ; Current position y-coordinate

        lda start_x
        sta current_x
        lda start_y
        sta current_y

check_wall:
        lda maze_data, x ; Load current cell value
        beq check_path   ; Branch if current cell is path (0)

        ; Wall encountered - backtrack to last known path
backtrack:
        lda current_x
        cmp start_x
        beq done         ; Exit if at starting position
        sbc #1
        sta current_x

        lda current_y
        cmp start_y
        beq done
        sbc #1
        sta current_y

        jmp check_wall

check_path:
        ; Check if at the exit
        lda current_x
        cmp #6
        beq done
        lda current_y
        cmp #4
        beq done

        ; Move to the next cell
        inc current_x             ; Move right
        jmp check_wall

done:
        rts

        .end
