
        .org $0200

start   lda $0200    ; Load the base1 of the trapezoid into the accumulator
        sta base1
        lda $0201    ; Load the base2 of the trapezoid into the accumulator
        sta base2
        lda $0202    ; Load the height of the trapezoid into the accumulator
        sta height
        lda $0203    ; Load the depth of the prism into the accumulator
        sta depth

        lda base1
        clc
        adc base2     ; Add base1 and base2
        tay           ; Store the result in the Y register

        lda y          ; Multiply the sum by the height
        mul height
        sta result

        lda depth      ; Multiply the result by the depth
        mul result
        sta result

        ; Output the result to memory address $0204
        lda result
        sta $0204

        rts

base1   .byte 0      ; Define base1 variable
base2   .byte 0      ; Define base2 variable
height  .byte 0      ; Define height variable
depth   .byte 0      ; Define depth variable
result  .word 0      ; Define result variable
