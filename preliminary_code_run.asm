
        .org $0200

n       .byte 5      ; n is set to 5
sum     .word 0      ; sum variable to store the result

        lda #0       ; clear the accumulator
        sta sum      ; clear the sum variable

loop    ldx n        ; load n into X register
        dex          ; decrement X
        bpl add       ; branch if positive

done    brk          ; exit program

add     clc          ; clear carry
        lda sum      ; load current sum
        adc x        ; add X to sum
        sta sum      ; store new sum
        jmp loop     ; repeat loop

        .end
