
; Program to calculate the area of a rectangle
        .org $0200
START:
        LDX #LENGTH   ; Load length value into X register
        LDY #WIDTH    ; Load width value into Y register
        JSR MULTIPLY  ; Call subroutine to multiply length and width
        STX RESULT    ; Store result in memory location RESULT
        LDA RESULT    ; Load result into accumulator
        STA AREA      ; Store result in memory location AREA
        BRK           ; End program

MULTIPLY:
        CLC           ; Clear carry flag
        LDA #$00      ; Clear accumulator
LOOP:
        ADC #1        ; Add 1 to accumulator
        DEY           ; Decrement Y register
        BNE LOOP      ; Branch if Y is not equal to zero
        STC           ; Set carry flag
        RTS

LENGTH: .BYTE $05    ; Length of the rectangle
WIDTH:  .BYTE $03    ; Width of the rectangle
RESULT: .BYTE $00    ; Result of multiplication
AREA:   .BYTE $00    ; Area of the rectangle

        .end
