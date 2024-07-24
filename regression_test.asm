
        .org $0200

Matrix_A .byte   1,once,2,twice ; Define Matrix A
Matrix_B .byte   3,once,4,twice ; Define Matrix B
Result   .byte   0,0,0,0        ; Placeholder for the result matrix

start:  ldx #0                  ; Initialize index register X to 0
        lda Matrix_A,x         ; Load a value from Matrix A
        sec                     ; Set carry flag
        sbc Matrix_B,x         ; Subtract value from Matrix B
        sta Result,x           ; Store the result in Result matrix
        inx                     ; Increment X
        cpx #4                  ; Check if end of matrix is reached
        bne start               ; If not, continue looping

        lda Result+3            ; Load the final value of the result matrix
        jsr print              ; Print the final matrix
        rts

print:  ldx #0                  ; Initialize index register X to 0
loop:   lda Result,x           ; Load a value from Result matrix
        jsr $ffd2              ; Call Kernal routine to print the value
        inx                     ; Increment X
        cpx #4                  ; Check if end of matrix is reached
        bne loop                ; If not, continue looping
        rts

once:   .byte 0
twice:  .byte 0
