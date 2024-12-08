
    .org $0200
    LDA sides1    ; Load side1 into Accumulator
    STA side1

    LDA sides2    ; Load side2 into Accumulator
    STA side2

    LDA sides3    ; Load side3 into Accumulator
    STA side3

    ; Calculate the semi-perimeter of the triangle
    LDA side1
    CLC
    ADC side2
    ADC side3
    STA semiperimeter

    ; Calculate the area of the triangle using Heron's formula
    LDA semiperimeter
    SEC
    SBC side1
    SBC side2
    SBC side3
    STA temp
    LDA semiperimeter
    SEC
    ADC temp
    SBC side1
    SBC side2
    SBC side3
    STA area

    ; Store the calculated area in memory
    STA result

    BRK

side1 .byte $00
side2 .byte $00
side3 .byte $00
semiperimeter .byte $00
temp .byte $00
area .byte $00
result .byte $00

    .end
