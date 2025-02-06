
; 6502 Assembly program to calculate the area of a regular pentagonal prism

        .text

start:
        ; Initialize variables
        LDA #5                      ; Number of sides of the pentagon
        STA sides

        LDA #10                     ; Length of each side
        STA side_length

        LDA #8                      ; Height of the prism
        STA height

        ; Calculate the area of a regular pentagonal prism
        LDA sides
        STA temp
        LDA temp
        CLC
        ADC #1                      ; Add 1 to the number of sides
        STA temp
        ASL temp                    ; Multiply by 2
        TAX

        LDA temp
        CLC
        ADC sides                   ; Add the original number of sides
        TAY

        LDA side_length
        STA temp
        ASL temp                    ; Multiply by 2
        TAX

        LDA temp
        CLC
        ADC side_length            ; Add the original side length
        TAY

        LDA height
        CLC
        ADC side_length            ; Add the height to the side length
        STA temp

        LDA temp
        TAX

        ; Multiply the two values in X and Y registers
        LDA #0                      ; Clear the accumulator
        LDX #0                      ; Clear the X register
        LDY #0                      ; Clear the Y register

multiply_loop:
        CLC
        ADC temp
        DEX
        BNE multiply_loop
        DEY

        STA area                    ; Save the calculated area

        ; End of the program
        BRK

area:   .byte 0
sides:  .byte 0
side_length: .byte 0
height: .byte 0
temp:   .byte 0

        .end
