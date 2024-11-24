
; Program to calculate the area of a rectangle given its length and width
; Input:
; Memory locations:
; $00 - Length of the rectangle
; $01 - Width of the rectangle
; Output:
; Memory locations:
; $02 - Area of the rectangle

        .org $0200

start:  LDA $00       ; Load length into accumulator
        STA $02       ; Store length in memory location $02
        LDA $01       ; Load width into accumulator
        CLC            ; Clear the carry bit
        ADC $02       ; Add length to width
        STA $03       ; Store the result in memory location $03
        LDA $02       ; Load length back into accumulator
        ADC $03       ; Add the sum of length and width
        STA $02       ; Store the final result in memory location $02

end:    BRK            ; Terminate the program

        .org $FFFA
        .word start    ; Set reset vector to start of program
