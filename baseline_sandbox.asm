
START:
    lda #$00            ; Initialize variables
    sta curX
    lda #$00
    sta curY
    lda #$00
    sta mazePosY

generate_maze:
    jsr get_random      ; Get random number
    and #$0F            ; Mask to only allow values from 0-15
    sta maze[mazePosY]  ; Store random value in maze
    inc mazePosY

    lda mazePosY
    cmp #$40
    bne generate_maze   ; Continue generating maze until 64 cells are filled

solve_maze:
    lda curX
    sta startX
    lda curY
    sta startY

    lda #$01
    sta sp

    jmp move

move:
    jsr can_go_up
    jsr can_go_down
    jsr can_go_left
    jsr can_go_right
    jsr done

can_go_up:
    lda curY
    cmp #$00
    beq done
    lda mazePosY
    sbc #$10
    ldx maze
    lda (maze),x
    cmp #$00
    bne done
    dec curY
    sta sp
    lda sp
    sta mazePosX
    lda mazePosY
    ldx maze
    lda sp
    sta (maze),x
    rts

can_go_down:
    lda curY
    cmp #$03
    beq done
    lda mazePosY
    clc
    adc #$10
    ldx maze
    lda (maze),x
    cmp #$00
    bne done
    inc curY
    sta sp
    lda sp
    sta mazePosX
    lda mazePosY
    ldx maze
    lda sp
    sta (maze),x
    rts

can_go_left:
    lda curX
    cmp #$00
    beq done
    lda mazePosY
    sbc #$01
    ldx maze
    lda (maze),x
    cmp #$00
    bne done
    dec curX
    sta sp
    lda sp
    sta mazePosX
    lda mazePosY
    ldx maze
    lda sp
    sta (maze),x
    rts

can_go_right:
    lda curX
    cmp #$03
    beq done
    lda mazePosY
    clc
    adc #$01
    ldx maze
    lda (maze),x
    cmp #$00
    bne done
    inc curX
    sta sp
    lda sp
    sta mazePosX
    lda mazePosY
    ldx maze
    lda sp
    sta (maze),x
    rts

done:
    lda #$00
    sta mazePosY
    lda curX
    cmp startX
    bne done1
    lda curY
    cmp startY
    bne done1
    lda #$01
    sta doneFlag
    done1:
    lda doneFlag
    cmp #$01
    bne move
    rts

get_random:
    lda randSeed
    lsr 
    rol randSeed
    ror randSeed
    ror randSeed
    ror randSeed
    ror randSeed
    rts

.END
