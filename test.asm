
.data
mazeWidth = 6
mazeHeight = 4
maze:
    .byte $00, $01, $02, $03, $04, $05
    .byte $06, $07, $08, $09, $0A, $0B
    .byte $0C, $0D, $0E, $0F, $10, $11
    .byte $12, $13, $14, $15, $16, $17

.text
start:
    ldx #0 ; starting x position
    ldy #0 ; starting y position
    jsr solveMaze ; solve the maze
    rts

solveMaze:
    lda maze, x ; load the current cell value
    cmp #$17 ; check if it is the finish cell
    beq mazeSolved ; if yes, maze is solved
    sta maze, x ; mark current cell as visited

    ; try moving right
    inx
    cmp mazeWidth
    bcc checkRight

    ; boundary check failed, backtrack
    dex
    bvc tryDown
    rts

checkRight:
    lda maze, x
    beq tryRight
    inx
    bcs tryLeft

tryRight:
    jsr solveMaze
    bcc mazeSolved

    inx
    bvc tryDown
    rts

tryLeft:
    dex
    lda maze, x
    beq tryUp
    jsr solveMaze
    bcc mazeSolved

    dex
    bvc tryDown
    rts

tryUp:
    dey
    lda maze, x
    beq tryLeft
    jsr solveMaze
    bcc mazeSolved

    dey
    bvc tryDown
    rts

tryDown:
    iny
    lda maze, x
    beq tryRight
    jsr solveMaze
    bcc mazeSolved

    iny
    rts

mazeSolved:
    clc
    rts
