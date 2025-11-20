
; 6502 Assembly program to calculate the area of a trapezoid

                .org    $1000        ; Start address of program

start:
                lda     #8           ; Load base1 (b1) value into accumulator
                sta     base1        ; Store base1 value in memory
                lda     #12          ; Load base2 (b2) value into accumulator
                sta     base2        ; Store base2 value in memory
                lda     #6           ; Load height (h) value into accumulator
                sta     height       ; Store height value in memory

                lda     base1        ; Load base1 value from memory
                clc                   ; Clear carry flag
                adc     base2        ; Add base2 value
                sta     sum          ; Store sum of base1 and base2 in memory

                lda     sum          ; Load sum value
                lsr                   ; Divide by 2 (right shift)
                sta     avg_base     ; Store average of base1 and base2

                lda     avg_base     ; Load average base value
                lda     height       ; Load height value
                mul     a            ; Multiply height by average base
                sta     result       ; Store result in memory

loop:
                jmp     loop         ; Infinite loop

base1:
                .byte   $00          ; Reserve 1 byte for base1 value

base2:
                .byte   $00          ; Reserve 1 byte for base2 value

height:
                .byte   $00          ; Reserve 1 byte for height value

sum:
                .byte   $00          ; Reserve 1 byte for sum of base1 and base2

avg_base:
                .byte   $00          ; Reserve 1 byte for average base value

result:
                .byte   $00          ; Reserve 1 byte for result value
