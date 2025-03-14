
        .org $0600

        lda matrix       ; Load the first element of the matrix into the accumulator
        clc
        adc matrix+3     ; Add the last element of the matrix to the accumulator
        lda matrix+1     ; Load the second element of the matrix into the accumulator
        adc matrix+2     ; Add the third element of the matrix to the accumulator
        beq invertible   ; Branch if the sum is zero

not_invertible:
        lda #$00         ; Load 0 into the accumulator to indicate the matrix is not invertible
        jmp end_program

invertible:
        lda #$01         ; Load 1 into the accumulator to indicate the matrix is invertible

end_program:
        sta result       ; Store the result in the 'result' variable
        rts              ; Return from subroutine

matrix: .byte 1, 2, 3, 4     ; Define the 2x2 matrix
result: .byte 0               ; Define a variable to store the result

        .end
