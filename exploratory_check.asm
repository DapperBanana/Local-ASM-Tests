
        .org $c000

mazeSize = 8
mazeStartX = 0
mazeStartY = 0
mazeEndX = mazeSize-1
mazeEndY = mazeSize-1

maze:
        .byte   mazeSize,mazeSize
        .addr   mazeData

mazeData:
        .fill   mazeSize*mazeSize, 0

start:
        ldx     #mazeStartX
        ldy     #mazeStartY
        jsr     solveMaze

loop:
        jmp     loop

solveMaze:
        lda     mazeSize
        clc
        adc     mazeSize
        sta     size2
        lda     mazeSize
        sec
        sbc     #$01
        sta     size2m1

        lda     #0
        sta     x
        sta     y
        lda     #0
        sta     stackPtr

pushStack:
        lda     stackPtr
        asl
        tay
        lda     x
        sta     (stack),y
        lda     stackPtr
        clc
        adc     #1
        sta     stackPtr
        inx
        lda     x
        cmp     mazeEndX
        beq     .right
        cmp     size2m1
        bcc     .down
.right:
        lda     x
        cmp     #0
        beq     .left
        lda     mazeData,y
        cmp     #0
        bne     .left
        sta     mazeData,y
        dex
        lda     x
        cmp     mazeEndX
        beq     .back
        cmp     size2m1
        bcc     .pushStack
.back:
        iny
        lda     y
        cmp     mazeEndY
        beq     .popStack
.down:
        lda     mazeData,y
        cmp     #0
        bne     .pushStack
        sta     mazeData,y
        iny
        lda     y
        cmp     mazeEndY
        beq     .popStack
.left:
        dey
        lda     y
        cmp     #0
        bne     .pushStack
        lda     mazeData,x
        cmp     #0
        bne     .pushStack
        sta     mazeData,x
        lda     x
        cmp     mazeEndX
        beq     .back
        cmp     size2m1
        bcc     .nextCol
        lda     y
        cmp     #0
        beq     .popStack
.nextCol:
        lda     x
        cmp     mazeEndX
        bne     .left
        lda     #0
.continue:
        clc
        rts

popStack:
        lda     stackPtr
        bpl     .popLoop
        rts

.popLoop:
        lda     stackPtr
        sbc     #1
        tax
        lda     (stack),x
        sta     y
        lda     (stack),x
        tax
        lda     mazeData,x
        and     #$fe
        sta     mazeData,x
        lda     (stack),x
        clc
        iny
        cmp     mazeEndY
        beq     .popLoop
        bpl     .yNotZero
        lda     #$f0
        clc
.yNotZero:
        sta     y
        lda     (stack),x
        cmp     mazeEndX
        bne     .popLoop
        bpl     .xNotZero
        lda     #$0f
        clc
.xNotZero:
        sta     x
        jmp     .popStack

stack:
        .byte   mazeSize*mazeSize
stackPtr:
        .byte   0
x:
        .byte   0
y:
        .byte   0
size2:
        .byte   0
size2m1:
        .byte   0
