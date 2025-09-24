
        .org $0600

start   lda #5             ; Load the number of sides (pentagon)
        sta sides

        lda #10            ; Load the side length
        sta sideLength

        jsr calculateArea  ; Calculate the area of the pentagon

        lda area           ; Load the calculated area
        sta $0700          ; Store it in memory location $0700

end     lda #$FF           ; End of program
        jsr $FFFE

calculateArea
        lda sides
        clc
        adc #-2            ; Decrease the number of sides by 2 to get the number of triangles
        lsr                ; Divide by 2 (shift right)

        tax                ; Save the value in X register for loop

loop    lda sideLength
        asl                ; Multiply side length by 2
        sta base           ; Store base of triangle

        lda sideLength
        tax                ; Move side length to X register
        ldx #$02           ; Load multiplier

multiply
        clc
        lda base
        adc sideLength     ; Add side length to base
        sta base

        dex
        bne multiply       ; Repeat multiply loop until X = 0

        lda base
        sta area           ; Save the area of the triangle

        dex
        bne loop           ; Repeat loop until X = 0

        rts
area    .byte 0
sides   .byte 0
sideLength .byte 0
base    .byte 0
