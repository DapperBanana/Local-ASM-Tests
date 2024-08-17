
; 6502 Assembly program to calculate the distance between two points in 3D space

    .org $8000

start:
    LDA #<point1x   ; Load the low byte of the address of point1x into the accumulator
    STA PTR1L        ; Store it in PTR1L
    LDA #>point1x   ; Load the high byte of the address of point1x into the accumulator
    STA PTR1H        ; Store it in PTR1H
    
    LDA #<point2x   ; Load the low byte of the address of point2x into the accumulator
    STA PTR2L        ; Store it in PTR2L
    LDA #>point2x   ; Load the high byte of the address of point2x into the accumulator
    STA PTR2H        ; Store it in PTR2H
    
    JSR calculateDistance  ; Call the subroutine to calculate the distance between two points
    
    ; Result is now stored in the accumulator
    ; You can now use the result to perform further operations
    
end:
    JMP end  ; End of program

calculateDistance:
    LDA #0          ; Clear the accumulator
    STA DISTANCE    ; Initialize DISTANCE to 0
    
    LDA #3          ; Load 3 into the accumulator (number of dimensions)
    STA DIMENSIONS  ; Store it in DIMENSIONS
    
    JSR calculateSquaredDifference ; Call subroutine to calculate the squared differences of each dimension
    
    LDA DISTANCE   ; Load the sum of squared differences into the accumulator
    
    JSR calculateSquareRoot  ; Call subroutine to calculate the square root of the sum of squared differences
    
    RTS  ; Return from subroutine

calculateSquaredDifference:
    LDA PTR1L   ; Load the low byte of the address of point1x into the accumulator
    STA TEMP    ; Store it in TEMP
    
    LDA PTR1H   ; Load the high byte of the address of point1x into the accumulator
    STA TEMP+1  ; Store it in TEMP+1
    
    LDY #0      ; Initialize Y as the offset for the dimensions
    
calculateNextDimension:
    LDA (TEMP),Y   ; Load the value of point1x into the accumulator
    SEC            ; Set carry flag
    
    LDA PTR2L      ; Load the low byte of the address of point2x into the accumulator
    SBC (Y)        ; Subtract the value of point2x
    STA TEMP       ; Store the result in TEMP
    
    LDA PTR2H      ; Load the high byte of the address of point2x into the accumulator
    SBC (Y)        ; Subtract the value of point2y
    STA TEMP+1     ; Store the result in TEMP+1
    
    CLC            ; Clear carry flag
    
    CLC            ; Clear carry flag
    LDA TEMP       ; Load the result into the accumulator
    ADC DISTANCE   ; Add it to the current value of DISTANCE
    STA DISTANCE   ; Store the result in DISTANCE
    
    INY            ; Increment Y
    CPY DIMENSIONS ; Compare Y to DIMENSIONS
    BNE calculateNextDimension  ; Branch if not equal
    
    RTS  ; Return from subroutine

calculateSquareRoot:
    LDA #0        ; Clear the accumulator
    STA SQRT_TEMP ; Initialize SQRT_TEMP to 0
    
    LDA DISTANCE  ; Load the sum of squared differences into the accumulator
    STA TEMP      ; Store it in TEMP
    
    LDX #8        ; Load the exponent into X
    
calculateNextBit:
    ASL TEMP      ; Shift the result left by 1
    ROL SQRT_TEMP ; Rotate the carry flag into SQRT_TEMP
    
    DEX           ; Decrement X
    BPL calculateNextBit ; Branch if positive
    
    LDA SQRT_TEMP ; Load the square root into the accumulator
    STA DISTANCE  ; Store it in DISTANCE
    
    RTS  ; Return from subroutine

point1x:  .byte 1
point1y:  .byte 2
point1z:  .byte 3

point2x:  .byte 4
point2y:  .byte 5
point2z:  .byte 6

PTR1L:    .byte $00
PTR1H:    .byte $00

PTR2L:    .byte $00
PTR2H:    .byte $00

TEMP:     .byte $00, $00
DISTANCE: .byte $00, $00

DIMENSIONS:  .byte 0
SQRT_TEMP:   .byte 0
