
        .text
        .org $0600

start:
        LDX #base_area     ; base area of the pyramid (in square units)
        LDY #height         ; height of the pyramid (in units)
        
        JSR calculate_area ; call the calculate_area subroutine
        
        JMP $FFD2          ; jump to BASIC's warm start

calculate_area:
        ; calculate the area of the pyramid using the formula (1/3) * base_area * height
        
        LDA #0             ; clear the accumulator
        STA result         ; clear the result
        
        LDA base_area       ; load the base area value
        ADC base_area       ; multiply by 2
        ADC base_area       ; multiply by 3
        ASL A               ; divide by 2 (1/3 = 2/6)
        STA temp           ; store the (1/3) * base area value
        
        LDA temp            ; load the (1/3) * base_area value
        ADC height          ; add the height value
        ADC height          ; multiply by 2
        ASL A               ; divide by 2
        STA result         ; store the final result
        
        RTS                ; return from subroutine
        
base_area:  .byte 10         ; base area of the pyramid
height:     .byte 5          ; height of the pyramid
temp:       .byte 0          ; temporary variable
result:     .byte 0          ; final result

        .end
