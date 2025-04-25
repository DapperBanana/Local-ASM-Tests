
        .org $0200     ; start address of program

start   lda #10        ; base1 of trapezoid
        sta base1

        lda #20        ; base2 of trapezoid
        sta base2

        lda #15        ; height of trapezoid
        sta height

        lda #5         ; depth of prism
        sta depth

        ; Calculate area of trapezoid
        lda base1      ; load base1
        clc
        adc base2      ; add base2
        adc #2          ; add base1 + base2 + 2
        asl
        sta temp       ; store in temp

        lda temp       ; load temp
        clc
        adc height     ; add height
        lsr
        adc height     ; add height
        sta area       ; store in area

        ; Calculate volume of prism
        lda area       ; load area
        clc
        adc depth      ; add depth
        asl
        adc depth      ; add depth * 2
        sta volume     ; store in volume

loop    jmp loop        ; infinite loop

base1   .byte 0
base2   .byte 0
height  .byte 0
depth   .byte 0
temp    .byte 0
area    .byte 0
volume  .byte 0

        .end
