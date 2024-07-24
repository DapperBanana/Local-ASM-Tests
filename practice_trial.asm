
    .org $0200
    
mazeStart:
    lda #0              ; Initialize random number seed
    sta randSeed
    
    jsr generateMaze    ; Generate random maze
    jsr printMaze       ; Print generated maze
    
    jsr solveMaze       ; Find solution to maze
    jsr printMaze       ; Print maze with solution
    
    rts                 ; End program
    
; GenerateRandomNumber subroutine
generateRandomNumber:
    lda randSeed        ; Load current random number
    asl                 ; Shift left to generate new random number
    eor randSeed        ; XOR with current random number
    sta randSeed        ; Store new random number
    rts                 ; Return
    
; GenerateMaze subroutine
generateMaze:
    ldx #0
generateMazeLoop:
    lda randSeed        ; Get random number
    and #$03            ; Mask to get bottom 2 bits
    sta maze,X          ; Store random byte in maze array
    inx
    cpx #$40            ; Check if loop is done
    bne generateMazeLoop
    rts
    
; PrintMaze subroutine
printMaze:
    lda #0
    ldx #0
printMazeLoop:
    lda maze,X
    jsr printChar
    inx
    cpx #$40            ; Check if loop is done
    bne printMazeLoop
    rts
    
; PrintChar subroutine
printChar:
    jsr $fda4          ; Kernal routine to print character
    rts

; SolveMaze subroutine
solveMaze:
    lda #0              ; Initialize position
    sta startX
    sta startY
    
    jsr recursiveSolve  ; Find solution using recursive algorithm
    rts

; RecursiveSolve subroutine
recursiveSolve:
    lda startX
    clc
    adc startY
    tax
    lda maze,X          ; Load current maze cell
    cmp #$FF            ; Check if already visited
    beq solveDone       ; Exit if already visited
    
    sta maze,X          ; Mark cell as visited
    
    ; Try moving in each direction: left, up, right, down
    lda startY
    cmp #0
    beq skipLeft
    jsr moveLeft
skipLeft:

    lda startX
    cmp #0
    beq skipUp
    jsr moveUp
skipUp:

    lda startX
    cmp #$3F
    beq skipRight
    jsr moveRight
skipRight:

    lda startY
    cmp #$3F
    beq skipDown
    jsr moveDown
skipDown:

    rts

moveLeft:
    dex                 ; Move left
    jsr recursiveSolve  ; Recursively solve
    clc
    inx                 ; Move back right
    rts

moveUp:
    lda startY
    sec
    sbc #$40            ; Move up
    tax
    lda startX
    sta startX
    lda tax
    jsr recursiveSolve  ; Recursively solve
    lda startX
    sta startX
    lda startY
    clc
    adc #$40            ; Move back down
    sta startY
    rts

moveRight:
    inx                 ; Move right
    jsr recursiveSolve  ; Recursively solve
    dex                 ; Move back left
    rts

moveDown:
    lda startY
    clc
    adc #$40            ; Move down
    tax
    lda startX
    sta startX
    lda tax
    jsr recursiveSolve  ; Recursively solve
    lda startX
    sta startX
    lda startY
    sec
    sbc #$40            ; Move back up
    sta startY
    rts

; Variables
maze:
    .blkw $40           ; Maze array, size 64 bytes
startX:
    .byt 0              ; X coordinate of starting position
startY:
    .byt 0              ; Y coordinate of starting position
randSeed:
    .byt 0              ; Random number seed

    .end
