
; Program to calculate the area of a frustum of a cone
;

ORG $0200 ; Start address of program

FRUSTUM_BASE equ $80 ; Base radius of frustum
FRUSTUM_TOP equ $81 ; Top radius of frustum
FRUSTUM_HEIGHT equ $82 ; Height of frustum

LDX #FRUSTUM_BASE ; Load base radius of frustum into X register
LDA #6 ; Load 6 into accumulator
JSR MULTIPLY ; Call subroutine to square the base radius

LDX #FRUSTUM_TOP ; Load top radius of frustum into X register
LDA #6 ; Load 6 into accumulator
JSR MULTIPLY ; Call subroutine to square the top radius

STX FRUSTUM_BASE ; Store the result of square base radius
STX FRUSTUM_TOP ; Store the result of square top radius

LDA FRUSTUM_BASE ; Load square base radius
CLC ; Clear carry flag
ADC FRUSTUM_TOP ; Add square top radius to accumulator
TAX ; Transfer result to X register

LDA #2 ; Load 2 into accumulator
JSR MULTIPLY ; Call subroutine to multiply by height

TAX ; Transfer result to X register

HLT ; Halt the program

; Subroutine to multiply two numbers in accumulator and X register
MULTIPLY: 
    PHA ; Push accumulator onto stack
    TXA ; Transfer X register to accumulator
    ASL ; Multiply by shifting left
    TAX ; Transfer result back to X register
    PLA ; Pop accumulator from stack
    RTS ; Return from subroutine

.END
