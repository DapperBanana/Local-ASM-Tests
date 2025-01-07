
START equ $0200  ; start of program
mazeStart equ $0300  ; start of maze data

* = START

    LDA #$00       ; load accumulator with 0
    STA currentRow ; store 0 in currentRow
    STA currentCol ; store 0 in currentCol

nextMove:
    LDX currentRow ; load currentRow to X register
    LDY currentCol ; load currentCol to Y register
    JSR checkExit  ; check if exit has been reached
    BEQ endProgram ; if exit has been reached, end program

    JSR checkRight ; check if can move right
    BEQ checkDown  ; if can move right, check down
    JSR moveRight  ; otherwise, move right
    BRA nextMove   ; go to next move

checkDown:
    JSR checkDown  ; check if can move down
    BEQ checkLeft  ; if can move down, check left
    JSR moveDown   ; otherwise, move down
    BRA nextMove   ; go to next move

checkLeft:
    JSR checkLeft  ; check if can move left
    BEQ checkUp    ; if can move left, check up
    JSR moveLeft   ; otherwise, move left
    BRA nextMove   ; go to next move

checkUp:
    JSR checkUp    ; check if can move up
    BEQ moveBack   ; if can move up, move back
    JSR moveUp     ; otherwise, move up
    BRA nextMove   ; go to next move

moveBack:
    LDX currentRow ; load currentRow to X register
    LDY currentCol ; load currentCol to Y register
    JSR moveBack   ; move back
    BRA nextMove   ; go to next move

endProgram:
    RTS            ; return from subroutine

; subroutine to check if exit has been reached
checkExit:
    LDA (mazeStart),Y ; load data from maze
    CMP #'E'          ; compare with exit character
    BEQ exitFound     ; if exit found, go to exitFound
    BEQ checkDown     ; move on to checkDown if not exit
    RTS              ; return from subroutine

exitFound:
    RTS              ; return from subroutine

; subroutine to check if can move right
checkRight:
    LDA currentCol ; load currentCol to accumulator
    CMP #$06       ; compare with maze width
    BEQ cantMove   ; if at right edge, can't move right
    INY            ; increment currentCol
    LDA (mazeStart),Y ; load data from maze
    CMP #'X'         ; compare with wall character
    BEQ cantMove     ; if wall, can't move right
    CLC              ; clear carry flag (can move)
    RTS              ; return from subroutine

; subroutine to move right
moveRight:
    INY            ; increment currentCol
    STA currentCol ; store updated value
    RTS            ; return from subroutine

; subroutine to check if can move down
checkDown:
    LDA currentRow ; load currentRow to accumulator
    CMP #$05       ; compare with maze height
    BEQ cantMove   ; if at bottom edge, can't move down
    CLC            ; clear carry flag (can move)
    RTS            ; return from subroutine

; subroutine to move down
moveDown:
    INX            ; increment currentRow
    STA currentRow ; store updated value
    RTS            ; return from subroutine

; subroutine to check if can move left
checkLeft:
    LDA currentCol ; load currentCol to accumulator
    BEQ cantMove   ; if at left edge, can't move left
    DEY            ; decrement currentCol
    LDA (mazeStart),Y ; load data from maze
    CMP #'X'         ; compare with wall character
    BEQ cantMove     ; if wall, can't move left
    CLC              ; clear carry flag (can move)
    RTS              ; return from subroutine

; subroutine to move left
moveLeft:
    DEY            ; decrement currentCol
    STA currentCol ; store updated value
    RTS            ; return from subroutine

; subroutine to check if can move up
checkUp:
    LDA currentRow ; load currentRow to accumulator
    BEQ cantMove   ; if at top edge, can't move up
    CLC            ; clear carry flag (can move)
    RTS            ; return from subroutine

; subroutine to move up
moveUp:
    DEX            ; decrement currentRow
    STA currentRow ; store updated value
    RTS            ; return from subroutine

; subroutine to move back
moveBack:
    DEY            ; decrement currentCol
    STA currentCol ; store updated value
    RTS            ; return from subroutine

; subroutine to indicate can't move
cantMove:
    SEC            ; set carry flag (can't move)
    RTS            ; return from subroutine

currentRow: .byte 0  ; variable to store current row
currentCol: .byte 0  ; variable to store current column

; maze data - example maze: 6x6
mazeData:
    .byte 'X','X','X','X','X','X'
    .byte 'S',' ','X',' ','X','X'
    .byte 'X',' ','X',' ',' ','X'
    .byte 'X',' ','X','X',' ','X'
    .byte 'X',' ',' ','X','E','X'
    .byte 'X','X','X','X','X','X'

* = mazeStart
    .word mazeData

