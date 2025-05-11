
; Input: Side length of the tetrahedron in A register
; Output: Area of the tetrahedron in A register

    ORG $1000   ; Start address of the program

START:
    LDA SIDE    ; Load side length of the tetrahedron
    ASL         ; Square the side length
    TAX         ; Store the result in X register
    LDX SIDE    ; Load side length again
    JSR MULTIPLY ; Calculate the area of the tetrahedron
    STA AREA    ; Store the result in AREA variable

    ; Halt the program
    BRK

MULTIPLY:
    LDY #2      ; Number of dimensions in our formula

MULTIPLY_LOOP:
    CLC
    ADC X       ; Add the current value of X to the accumulator
    DEY         ; Decrement our counter
    BNE MULTIPLY_LOOP ; Repeat until we've multiplied by all dimensions

    RTS         ; Return from subroutine

SIDE    .BYTE 5   ; Side length of the tetrahedron
AREA    .BYTE 0   ; Area of the tetrahedron

    .ORG $FFFC  ; Reset vector
    .WORD START ; Set the reset vector to the start of our program
