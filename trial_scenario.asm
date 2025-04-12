
        .org $0200

        LDX #RADIUS    ; load radius into X register
        LDY #ANGLE      ; load angle into Y register
        JSR CALC_AREA   ; call subroutine to calculate area
        
        ; output result
        LDX #RESULT
        LDA RESULT+1
        STA $D0200,X
    
END     JMP END        ; endless loop

CALC_AREA:
        LDY #$00       ; clear Y register
        LDA #0         ; clear A register
    
LOOP    ADC X,RADIUS  ; add radius to accumulator
        BCC NO_OVERFLOW ; branch if no overflow
        INC A          ; increment A register
NO_OVERFLOW
        DEY           ; decrement Y (angle)
        BNE LOOP      ; continue loop if angle > 0
    
        STA RESULT         ; store result in RESULT
        RTS                ; return from subroutine

RADIUS  .byte $05        ; radius of the sector
ANGLE   .byte $30        ; angle of the sector
RESULT  .word 0x0000     ; store area result
