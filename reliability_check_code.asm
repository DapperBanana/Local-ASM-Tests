
; Program to calculate the area of a parallelogram

        .segment "CODE"
start:  
        LDX #base          ; Load base into X register
        LDY #height        ; Load height into Y register
        
        JSR calculateArea  ; Call subroutine to calculate area
        
        ; Exit program
end:    
        BRK               ; Exit program
        
; Subroutine to calculate the area of a parallelogram
calculateArea:
        CLC               ; Clear carry flag
        LDA X             ; Load base into accumulator
        ADC Y             ; Add height to accumulator
        STA result        ; Store result in memory location
        
        LDA X             ; Load base into accumulator
        STA multiplier    ; Store base in multiplier
        
        LDA #2            ; Load 2 into accumulator
        STA counter       ; Initialize counter
        
loop:   
        LDA result        ; Load result into accumulator
        ADC multiplier    ; Add base to result
        STA result        ; Store result back in memory
        
        DEC counter       ; Decrement counter
        BNE loop          ; Branch if counter is not zero
        
        RTS               ; Return from subroutine

        .segment "DATA"
base:     .byte $0A
height:   .byte $05
result:   .byte $00
multiplier: .byte $00
counter:  .byte $02
