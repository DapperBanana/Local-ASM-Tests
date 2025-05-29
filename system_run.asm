
; Program to calculate the area of a sector given its radius and angle in 6502 Assembly

        .org $0200
        
radius  .byte 10            ; radius of the sector
angle   .byte 60            ; angle of the sector in degrees

        .org $0220

        LDA radius          ; Load radius into the accumulator
        STA $00             ; Store radius in memory location $00
        
        LDA angle           ; Load angle into the accumulator
        STA $01             ; Store angle in memory location $01
        
        LDX $00             ; Load radius into X register
        LDY $01             ; Load angle into Y register
        
        JSR calculate_area
        
        ; Area = (angle / 360) * PI * radius^2
        
        LDA $03             ; Load high byte of result (area)
        STA $02             ; Store high byte of result in memory location $02
        
        LDA $02             ; Load low byte of result (area)
        STA $03             ; Store low byte of result in memory location $03
        
        BRK                 ; End of program
        
calculate_area:        
        TXA                 ; Transfer X register to accumulator
        TAX                 ; Transfer accumulator to X register
        TYA                 ; Transfer Y register to accumulator
        TAY                 ; Transfer accumulator to Y register
        
        LDA $01             ; Load angle into the accumulator
        CLC
        ADC #$00            ; Add carry to 0 to clear it
        STA $01             ; Store resulting angle in memory location $01
        
        LDA $01             ; Load angle into the accumulator
        LSR                 ; Divide angle by 2
        LSR
        TAY                 ; Transfer resulting angle / 2 to Y register
        
        LDA $00             ; Load radius into the accumulator
        JSR square          ; Square the radius and store result in memory locations $02 and $03
        
        LDA #$03            ; Load 3 into the accumulator
        SEC
        SBC $01             ; Subtract (angle / 2) from 3
        STA $01             ; Store result in memory location $01
        
        LDA #$90            ; Load $90 (PI approximated as 3.14) into the accumulator
        SEC
        SBC $01             ; Subtract (angle / 2) from PI
        TAX                 ; Transfer PI - (angle / 2) to X register
        
        LDA #$00            ; Clear accumulator
        LDX $02             ; Load high byte of radius squared into X register
        ADC $03             ; Add low byte of radius squared to accumulator
        TAX                 ; Transfer result to X register
        
        SEC
        SBC $02             ; Subtract low byte of radius squared from PI - (angle / 2)
        STA $02             ; Store high byte of final result (area)
        
        LDA #$00            ; Clear accumulator
        ADC $03             ; Add low byte of radius squared to accumulator
        STA $03             ; Store low byte of final result (area)
        
        RTS
        
square: STA $02, X         ; Store high byte of square result
        LDA $00             ; Load radius into the accumulator
        LSR                 ; Divide radius by 2
        STA $01             ; Store half of radius in memory location $01
        
        LDA $01             ; Load half of radius into the accumulator
        CLC
        ADC $00             ; Add half of radius to radius
        TAX                 ; Transfer resulting radius * 1.5 to X register
        
        LDA $00             ; Load radius into the accumulator
        ADC $01             ; Add half of radius to radius
        TAX                 ; Transfer resulting radius * 1.5 to X register
        
        CLC
        ADC $00             ; Add radius to radius * 1.5
        RTS
