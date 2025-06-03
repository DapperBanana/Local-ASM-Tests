
; Program to calculate the area of a trapezoid
; Formula: Area = ((base1 + base2) / 2) * height

        .org $0200      ; Start program at memory address $0200

base1   .byte $05       ; Base 1 value (example: 5)
base2   .byte $8        ; Base 2 value (example: 8)
height  .byte $04       ; Height value (example: 4)

        lda base1      ; Load base1 value into A
        clc            ; Clear carry flag
        adc base2      ; Add base2 value to A
        lsr            ; Divide by 2 (shift right)
        sta $10        ; Store result in memory address $10

        lda $10        ; Load the result back into A
        ldx height     ; Load height value into X
        clc            ; Clear carry flag
        adc $10        ; Add the result to A
        tay            ; Transfer A to Y
        lda $10        ; Load the result back into A
        adc $10        ; Add the result to A
        tay            ; Transfer A to Y

        lda $10        ; Load the result back into A
        sta $11        ; Store the result in memory address $11

        lda $10        ; Load the result back into A
        adc $11        ; Add to the result
        tay            ; Transfer A to Y

        hlt            ; Halt the program
