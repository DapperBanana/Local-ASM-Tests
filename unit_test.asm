
; Program to calculate the surface area of a cube

    .org $0200  ; memory address where program starts

start:
    LDA #sideLength   ; load sideLength value into A register
    JSR calculateSurfaceArea  ; jump to subroutine
    STA surfaceArea   ; store the result in surfaceArea variable

    ; halt the program
    BRK

calculateSurfaceArea:
    ; calculate the surface area of a cube: 6 * sideLength^2
    CLC
    LDA #6   ; load constant 6 into A register
    ADC surfaceArea  ; add surfaceArea to A register
    LDA sideLength  ; load sideLength value into A register
    ASL  ; shift left to square the value
    ASL
    STA tempResult  ; store the temporary result

    LDA sideLength
    ASL
    ASL
    ADC tempResult  ; add the squared value to A register

    RTS  ; return from subroutine

    ; Variables
    .org $0300
sideLength: .byte $05  ; side length of the cube
surfaceArea: .byte $00  ; variable to store the surface area
tempResult: .byte $00  ; temporary result of calculations

    .end ; end of program
