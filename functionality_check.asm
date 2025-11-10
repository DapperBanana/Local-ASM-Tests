
start:
    lda #0         ; Initialize maze array to all walls
    sta mazeptr
    ldx #0
initmaze:
    lda #15
    sta (mazeptr),y
    iny
    cpy #16
    bne initmaze
    inx
    cpx #16
    bne initmaze

    lda #0         ; Set starting point
    sta maze
    sty maze+1

    jsr genmaze    ; Generate the maze

end:
    jmp end

genmaze:
    jsr randomize  ; Get a random direction

    ldy #$ff
getdirection:
    lda mazeptr
    clc
    adc direction,y
    sta newmaze
    cpy #16
    bne nextdirection
    lda mazeptr+1
    adc #$10
    sta newmaze+1

nextdirection:
    lda (newmaze),y   ; Check if new direction is already visited
    bne genmaze
    sta (newmaze),y

    lda direction,y
    clc
    adc #$02
    sta direction,y

    jsr visit
    lda newmaze
    sta mazeptr
    lda newmaze+1
    sta mazeptr+1
    jsr checkneighbors

checkneighbors:
    ldy #0
checkneighbor:
    lda mazeptr
    clc
    adc neighbors,y
    sta checkmaze
    bcc notvisited

    lda mazeptr+1
    adc neighbors+1,y
    sta checkmaze+1

    lda (checkmaze),y
    beq visited
notvisited:
    iny
    cpy #4
    bne checkneighbor
    jmp backtrack

visited:
    lda #0
    sta flag
    iny
    lda (checkmaze),y
    beq connect

connect:
    ldy #0
makepath:
    lda mazeptr
    clc
    adc neighbors,y
    sta connectmaze
    bcc skip
    lda mazeptr+1
    adc neighbors+1,y
    sta connectmaze+1

skip:
    iny
    iny
    lda neighbors,y
    beq makepath

    lda #0
    sta flag

    lda connectmaze
    sta mazeptr
    lda connectmaze+1
    sta mazeptr+1
    jsr visit
    lda flag
    beq checkneighbors

backtrack:
    lda mazeptr     ; Backtrack to previous cell
    sec
    sbc direction,y
    sta mazeptr
    lda mazeptr+1
    sbc direction+1,y
    sta mazeptr+1

    lda mazeptr     ; Check if backtracked to starting point
    cmp maze
    bne checkneighbors
    lda mazeptr+1
    cmp maze+1
    bne checkneighbors

    rts

visit:
    lda mazeptr
    clc
    adc #$80
    sta visitedmaze
    lda mazeptr+1
    adc #$80
    sta visitedmaze+1

    lda #1
    sta (visitedmaze),y

    rts

randomize:
    lda randomizer
    adc #$17
    sta randomizer
    lda randomizer+1
    adc #$57
    sta randomizer+1

    lda randomizer
    lsr
    sec
    sbc #$05
    sta direction
    lda randomizer+1
    lsr
    sec
    sbc #$02
    sta direction+1

    rts

maze:   .byte 2,2,2,3,0,2,3,0,2,2,0,3,0,2,3,0
neighbors:  .byte 0,1,0,-1
randomizer:     .word 1234
visitedmaze:    .word $c000
mazeptr:        .word $c000
direction:  .word 0
newmaze:        .word 0
connectmaze:    .word 0
flag:       .byte 0
