
    .org $1000
start:
    lda #10            ; load maze width
    sta mazeWidth
    lda #10            ; load maze height
    sta mazeHeight
    
    lda #maze          ; load maze address
    sta mazeAddr
    
    lda #startPos      ; load starting position
    sta currentPos
    
    jsr solveMaze
    
    jmp $ffff          ; halt program
    
solveMaze:
    lda mazeAddr
    sta addrL
    lda mazeAddr+1
    sta addrH
    
    lda currentPos
    sta curPosL
    lda currentPos+1
    sta curPosH
    
nextMove:
    lda curPosL
    clc
    adc mazeWidth
    cmp mazeAddr
    bcc checkMove
    
    lda curPosL
    clc
    sbc mazeWidth
    cmp mazeAddr
    bcs checkMove
    
    lda curPosH
    clc
    adc #1
    sta curPosH
    jmp nextMove
    
checkMove:
    lda addrL
    clc
    adc curPosL
    lda addrH
    adc curPosH
    tax
    lda maze, x
    cmp #wall
    beq nextMove
    
    lda mazeEnd
    clc
    adc #1
    sta mazeEnd
    lda maze, x
    cmp #end
    beq foundEnd
    
    lda maze, x
    cmp #path
    beq nextMove
    
    lda addrL
    sta curPosL
    lda addrH
    sta curPosH
    jmp solveMaze
    
foundEnd:
    lda mazeEnd
    rts
    
mazeWidth:  .byte 0
mazeHeight: .byte 0
mazeAddr:   .word 0
mazeEnd:    .byte 0
currentPos: .word 0
addrL:      .byte 0
addrH:      .byte 0
curPosL:    .byte 0
curPosH:    .byte 0
    
maze:       .byte wall, wall, wall, wall, wall, wall, wall, wall, wall, wall
            .byte wall, path, path, wall, end,  wall, path, path, wall, wall
            .byte wall, wall, path, wall, wall, wall, wall, path, path, wall
            .byte wall, wall, path, wall, path, path, wall, wall, path, wall
            .byte wall, path, path, wall, wall, wall, wall, path, path, wall
            .byte wall, path, wall, wall, wall, wall, wall, wall, path, wall
            .byte wall, path, path, path, wall, path, path, wall, path, wall
            .byte wall, wall, wall, wall, wall, path, path, path, path, wall
            .byte wall, wall, wall, wall, wall, wall, wall, wall, wall, wall
            .byte wall, wall, wall, wall, wall, wall, wall, wall, wall, wall
    
end:
wall:
path:
    rts
