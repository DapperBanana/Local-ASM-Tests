
; Program to calculate area of a regular octagon

.segment "CODE"

    .org $0200

start:
    LDA #8          ; Number of sides of the octagon
    STA sides
    
    LDA #12         ; Side length of the octagon
    STA sideLength

    JSR calculateArea  ; Call subroutine to calculate area

    BRK

calculateArea:
    LDX sides       ; Load number of sides
    LDA sideLength  ; Load side length
    STA base        ; Store side length as base for triangle

    ; Calculate the area of a triangle
    LDA base
    CLC
    ADC base
    TAX

    LDA base
    ADC #1
    TAX

    LDA #0
    ADC base
    TAX

    LDA #$0
    ADC #8
    STA height
    
    LDA base
    STA side1
    
    LDA height
    STA side2
    
    LDA side1
    CLC
    ADC side2
    TAX

    LDA side2
    ADC base
    TAX

    LDA #$0
    ADC #$8
    TAX

    LDA #4
    CLC
    ADC #$0
    TAX

    LDA #$0
    ADC #$20
    TAX

    LDA #$60 
    CLC
    ADC #$0
    TAX

    LDA #$0 
    ADC #$0
    TAX

    LDA #$24 
    STA area

    RTS

.area $0000
.base $0000
.side1 $0000
.side2 $0000
.height $0000
.sides $00
.sideLength $00

.segment "VECTORS"

    .org $FFFA
    .word NMI
    .word RESET
    .word IRQ

.segment "DATA"

    .org $FD00

RESET:
    JMP start

NMI:
    RTI

IRQ:
    RTI
