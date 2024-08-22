
    ; Program to calculate the area of a triangle given its three sides
    
    ORG $0200

    LDX #SIDE1
    LDY #SIDE2
    LDA #SIDE3

    ; Calculate the semi-perimeter of the triangle
    CLC
    LDA SIDE1
    ADC SIDE2
    ADC SIDE3
    STA SEMIPERIMETER

    ; Calculate the area of the triangle
    LDA SEMIPERIMETER
    SEC
    SBC SIDE1
    SBC SIDE2
    SBC SIDE3
    STA AREA

    ; End of program
    BRK

SIDE1   .BYTE $05    ; Side 1 of the triangle
SIDE2   .BYTE $06    ; Side 2 of the triangle
SIDE3   .BYTE $07    ; Side 3 of the triangle
SEMIPERIMETER .BYTE $00 ; Variable to store the semi-perimeter
AREA    .BYTE $00    ; Variable to store the area

    .END
