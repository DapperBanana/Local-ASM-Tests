
; Calculate the area of a trapezoidal prism

.area_trap_prism
    LDA #5      ; Load the length of the bottom base of the trapezoidal prism into the accumulator
    STA base_b   ; Store the length in the memory location base_b
    LDA #3      ; Load the length of the top base of the trapezoidal prism into the accumulator
    STA base_t   ; Store the length in the memory location base_t
    LDA #4      ; Load the height of the trapezoidal prism into the accumulator
    STA height   ; Store the height in the memory location height

    LDA base_b   ; Load the length of the bottom base
    LDX base_t   ; Load the length of the top base
    LDY height   ; Load the height

    CLC          ; Clear the carry flag
    ADC X        ; Add the length of the top base to the length of the bottom base
    STA a        ; Store the result in the memory location a

    LDA a
    ASL          ; Multiply the result by 2
    STA area     ; Store the result in the memory location area

    JMP $        ; End of program

.base_b
    .BYTE 0
.base_t
    .BYTE 0
.height
    .BYTE 0
.a
    .BYTE 0
.area
    .BYTE 0
