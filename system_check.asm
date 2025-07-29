
; Program to calculate the area of a regular pentagonal prism
; Formula: Area = 5*(side length of the pentagon)*(height of the prism) + 2*(side length of the pentagon)^2*tan(54 degrees)

.INCLUDE "6502.h" ; Include file containing necessary macros

; Define constants
.equ SIDE_LENGTH, $05   ; Hex value for the side length of the pentagon
.equ HEIGHT, $0A        ; Hex value for the height of the prism

                .ORG $0200 ; Start of program

START:          LDA SIDE_LENGTH    ; Load side length of the pentagon
                STA $00            ; Store it in memory location $00
                LDA HEIGHT         ; Load height of the prism
                STA $01            ; Store it in memory location $01

                JSR CALC_PENTAGON_AREA ; Call subroutine to calculate pentagon area
                JSR CALC_PRISM_AREA    ; Call subroutine to calculate prism area

                ; Your program continues here

                BRK                 ; End of program

CALC_PENTAGON_AREA:
                LDX $00             ; Load side length of the pentagon into X register
                LDY $01             ; Load height of the prism into Y register

                ; Calculate area = 5*(side length)*(height)
                LDA #$00            ; Clear accumulator
                CLC                 ; Clear carry flag
                LDA $00             ; Load side length
                ADC $00             ; Add it 4 more times (total 5)
                ADC $00             
                ADC $00             
                ADC $00             
                ADC $00             
                STA $02             ; Store result in memory location $02

                RTS                 ; Return from subroutine

CALC_PRISM_AREA:
                ; Calculate area = 2*(side length)^2*tan(54 degrees)
                LDA $02             ; Load pentagon area
                STA $03             ; Store it in memory location $03

                ; Calculate (side length)^2
                LDX $00             ; Load side length
                TXA                 ; Copy side length
                STA $00             ; Store it in memory location $00
                TXA                 ; Copy side length again
                STA $01             ; Store it in memory location $01

                ; Calculate 2*(side length)^2
                LDA #$00            ; Clear accumulator
                CLC                 ; Clear carry flag
                LDA $00             ; Load side length
                ADC $00             ; Add it to itself
                LDA $01             ; Load side length
                ADC $01             ; Add it to itself
                STA $04             ; Store result in memory location $04

                ; Calculate tan(54 degrees)
                LDA #$3A            ; Hex value for tangent of 54 degrees
                STA $05             ; Store it in memory location $05

                ; Calculate 2*(side length)^2*tan(54 degrees)
                LDA $04             ; Load 2*(side length)^2
                ASL                 ; Multiply by 2
                STA $04             ; Store result
                STA $04             ; Store result in memory location $04
                LDA $05             ; Load tangent
                MUL $04             ; Multiply by 2*(side length)^2
                STA $06             ; Store result in memory location $06

                ; Calculate total area = pentagon area + prism area
                LDA $02             ; Load pentagon area
                CLC                 ; Clear carry flag
                ADC $06             ; Add prism area
                STA $07             ; Store total area in memory location $07

                RTS                 ; Return from subroutine
