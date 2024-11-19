
.START
    .org $0200   ; Starting address

    LDA SIDE1    ; Load first side of triangle into accumulator
    STA SIDE1    ; Store first side of triangle in memory

    LDA SIDE2    ; Load second side of triangle into accumulator
    STA SIDE2    ; Store second side of triangle in memory

    LDA SIDE3    ; Load third side of triangle into accumulator
    STA SIDE3    ; Store third side of triangle in memory

    ; Calculate the semi-perimeter of the triangle
    LDA SIDE1
    CLC
    ADC SIDE2
    ADC SIDE3
    STA SEMI_PERIMETER

    ; Calculate the area of the triangle using Heron's formula
    LDA SEMI_PERIMETER
    SEC
    SBC SIDE1
    SBC SIDE2
    SBC SIDE3
    ASL
    ASL
    STA AREA

    ; Output the area of the triangle
    LDA #MSG     ; Load message prompt into accumulator
    JSR PRINT    ; Print the message
    LDA AREA     ; Load area of the triangle into accumulator
    JSR PRINT    ; Print the area

    JMP $FFFE    ; Jump to end of program

MSG:
    .byte "The area of the triangle is: $"

PRINT:
    LDX #$00     ; Initialize index X to 0

PRINT_LOOP:
    LDA MSG, X   ; Load character at index X from MSG into accumulator
    BEQ PRINT_DONE ; Branch to PRINT_DONE if character is null terminator
    JSR $FFD2    ; Call the KERNAL routine to output character
    INX          ; Increment index X
    JMP PRINT_LOOP ; Loop back to PRINT_LOOP

PRINT_DONE:
    RTS          ; Return from subroutine

SIDE1:
    .byte $05    ; First side of triangle
SIDE2:
    .byte $08    ; Second side of triangle
SIDE3:
    .byte $10    ; Third side of triangle
SEMI_PERIMETER:
    .byte $00    ; Semi-perimeter of triangle
AREA:
    .byte $00    ; Area of triangle

    .end
