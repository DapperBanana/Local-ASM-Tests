
        .org $0200

matrix		.byte	1, 2, 3, 4	; 2x2 matrix [1 2]
					;            [3 4]

        lda matrix     ; Load the first element of the matrix
        clc             ; Clear carry flag
        adc matrix+3    ; Add the last element of the matrix
        lda matrix+1    ; Load the second element of the matrix
        adc matrix+2    ; Add the third element of the matrix
        bne not_invertible ; Branch if the sum is not zero

invertible
        ; Matrix is invertible
        jmp $FFFC      ; Infinite loop

not_invertible
        ; Matrix is not invertible
        jmp $FFFC      ; Infinite loop

        .end
