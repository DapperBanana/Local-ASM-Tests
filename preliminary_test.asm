
        .org $600
radius  .byte $05
height  .byte $0A
volume  .word $0000

        LDA radius       ; Load radius into accumulator
        STA $00          ; Store radius at memory location $00

        LDA height       ; Load height into accumulator
        STA $01          ; Store height at memory location $01

        LDX #$00         ; Initialize X register to 0
        LDY #$00         ; Initialize Y register to 0

loop    LDA $00          ; Load radius from memory
        CMP #$00         ; Compare radius to 0
        BEQ end          ; If radius is 0, exit loop

        INX              ; Increment X register
        DEC $00          ; Decrease radius by 1

        JMP loop         ; Repeat loop

end     LDX #$00         ; Reset X register to 0

calc    LDA $01          ; Load height from memory
        CMP #$00         ; Compare height to 0
        BEQ print        ; If height is 0, calculate volume

        INX              ; Increment X register
        DEC $01          ; Decrease height by 1

        JMP calc         ; Repeat calculation

print   LDA $00          ; Load radius from memory
        CLC              ; Clear carry flag
        ADC $00          ; Add radius to itself
        TAX              ; Transfer result to X register

        LDA $01          ; Load height from memory
        ASL              ; Shift left to multiply by 2
        ADC $01          ; Add height to result
        TAY              ; Transfer result to Y register

        LDA X            ; Load radius into accumulator
        SEC              ; Set carry flag
        SBC #$FF         ; Subtract 1 from radius
        TAY              ; Transfer result to Y register

        LDA #$03         ; Load constant value 3 into accumulator
        STA $02          ; Store constant value at memory location $02

        LDA $02          ; Load constant value from memory
        CLC              ; Clear carry flag
        ADC $01          ; Add height to constant value
        TAY              ; Transfer result to Y register

        LDA X            ; Load radius into accumulator
        TAX              ; Transfer radius to X register

        LDA $02          ; Load constant value from memory
        CLC              ; Clear carry flag
        ADC $01          ; Add height to constant value
        TAX              ; Transfer result to X register

        LDY #$00         ; Initialize Y register to 0

        LDA X            ; Load radius into accumulator
        ASL              ; Shift left to multiply by 2
        STA $03          ; Store result at memory location $03

        LDA X            ; Load radius into accumulator
        ASL              ; Shift left to multiply by 2
        ASL              ; Shift left to multiply by 4
        ADC $03          ; Add result to accumulator
        TAY              ; Transfer result to Y register

        LDA Y            ; Load volume calculation into accumulator
        STA volume       ; Store volume in memory

        BRK              ; Exit program
