
; Random Image Generator in 6502 Assembly

; Define screen RAM address
SCREEN = $0400

; Load random seed
LDX #42 ; For example

; Loop through each pixel and set a random color
LDY #0 ; Y register will hold the pixel offset
loop:
    ; Generate a random color value
    LDA X
    AND #15 ; Mask out upper bits
    STA (SCREEN),Y ; Set pixel color
    INY ; Move to next pixel
    ; Increase seed for next random value
    CLC
    ADC #7
    DEX
    BNE loop

; End of program, infinite loop
end:
    JMP end
