
; 6502 Assembly program to calculate the area of a regular tetrahedron

        .org $0200

        ; Define constants
SIDE    = $05     ; Side length of the tetrahedron
HEIGHT  = $04     ; Height of the tetrahedron (from the center to the base)

        ; Initialize values
        LDA #SIDE   ; Load the side length of the tetrahedron
        STA $00     ; Store it in memory location $00

        LDA #HEIGHT ; Load the height of the tetrahedron
        STA $01     ; Store it in memory location $01

        ; Calculate the area of the tetrahedron
        LDA $00     ; Load the side length
        ASL         ; Multiply by 2
        STA $02     ; Store the result in memory location $02

        LDA $00     ; Load the side length
        CLC
        ADC $02     ; Add the result of the previous multiplication
        ADC $02     ; Add it again
        STA $03     ; Store the result in memory location $03

        LDA $03     ; Load the result
        ASL         ; Multiply by 2
        STA $04     ; Store the result in memory location $04

        LDA $02     ; Load the previous result
        ASL         ; Multiply by 2
        STA $05     ; Store the result in memory location $05

        LDA $03     ; Load the result
        ASL         ; Multiply by 2
        CLC
        ADC $04     ; Add the previous result
        ADC $05     ; Add the previous result
        JSR $FFD2   ; Print the result on the screen
        
        ; End of program
        BRK
