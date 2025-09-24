
        .org $0600  ; start program at memory location $0600

start   LDA #5      ; load the number of sides of the pentagon (5)
        STA sides

        LDA #10     ; load the length of a side of the pentagon (10)
        STA side_length

        LDA side_length
        JSR multiply ; multiply the side length by itself
        JSR multiply ; since it is a prism, multiply by 2

        LDA #1       ; load the number 1
        STA base_area_calc

loop    LDA base_area_calc
        CLC
        ADC area_calc ; add the calculated area of a side
        STA area_calc

        DEC sides    ; decrement the number of sides
        BNE loop     ; if there are more sides, repeat the loop

        LDA area_calc
        JSR multiply ; multiply by the number of sides

        STA total_area ; store the total area in the memory location total_area

end     JMP end      ; end the program

multiply
        TAX          ; transfer the accumulator to the X register
        LDY #0       ; load the number 0 to the Y register
        LDA #0       ; load the number 0 to the accumulator

mulloop ASL          ; shift the X register to the left
        BCC noshift ; if the carry flag is not set, skip next instruction
        CLC          ; clear the carry flag
        ADC side_length ; add the side length to the accumulator

noshift DEY          ; decrement the Y register
        BNE mulloop ; if Y is not zero, repeat the loop

        TAX          ; transfer the result back to the accumulator
        RTS          ; end the subroutine

        .org $0700     ; reserve memory location for variables
sides       .byte 0
side_length .byte 0
base_area_calc .byte 0
area_calc   .byte 0
total_area  .byte 0
