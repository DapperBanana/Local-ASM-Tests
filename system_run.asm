
; 6502 Assembly program to calculate the area of a regular pentagonal prism

.org $1000   ; Start address of program

; Define memory locations
radius   .byte $05   ; Radius of the prism
height   .byte $0A   ; Height of the prism
result   .word $0000 ; Area of the pentagonal prism

; Main program
start
    LDA radius    ; Load radius into A
    STA $00       ; Store radius in memory location $00
        
    LDA height    ; Load height into A
    STA $01       ; Store height in memory location $01

    LDA $00       ; Load radius from memory location $00
    STA $02       ; Store radius in memory location $02

    LDA $00       ; Load radius from memory location $00
    CLC           ; Clear carry bit
    ADC $01       ; Add height to radius
    TAX           ; Transfer result to X
    
    JSR calc_pentagon_area  ; Calculate the area of pentagonal prism

    LDA result    ; Load result into A
    STA $03       ; Store result in memory location $03

end
    BRK           ; End of program

calc_pentagon_area
    LDX #$05      ; Load number of sides (pentagon) into X
    LDA $00       ; Load radius from memory location $00
    STA $04       ; Store radius in memory location $04

loop
    LDA $04       ; Load radius from memory location $04
    ADC $03       ; Add result to radius
    STA $03       ; Store result in memory location $03

    DEX           ; Decrement X
    BNE loop      ; Loop until X becomes zero

    RTS           ; Return from subroutine
