
        .org $0200

matrixA:        .byte 1, 2, 3
                .byte 4, 5, 6
                .byte 7, 8, 9

matrixB:        .byte 9, 8, 7
                .byte 6, 5, 4
                .byte 3, 2, 1

resultMatrix:   .byte 0, 0, 0
                .byte 0, 0, 0
                .byte 0, 0, 0

start:
        ldx #0             ; Initialize index variable x to zero
        ldy #0             ; Initialize index variable y to zero

addLoop:
        lda matrixA, x     ; Load element from matrix A
        clc                ; Clear the carry flag
        adc matrixB, x     ; Add element from matrix B
        sta resultMatrix, x ; Store result in result matrix

        inx                ; Increment x index
        cpx #3             ; Check if x index reaches 3
        bne addLoop        ; Loop back if not

        iny                ; Increment y index
        cpy #3             ; Check if y index reaches 3
        bne start          ; Continue if not

        rts

        .end
