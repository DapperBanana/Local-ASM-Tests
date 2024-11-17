
        .text
        .globl main
        
main:
        LDX #7                   ; Number of sides of a regular heptagon
        LDA #10                  ; Side length of the heptagon
        STA $00                  ; Store side length in memory location $00

calculate_area:
        LDA $00                  ; Load side length
        CLC
        ASL                      ; Double the side length
        ASL
        STA $01                  ; Store the doubled side length in memory location $01
        
        LDA $01                  ; Load the doubled side length
        LDX $00                  ; Load the original side length
        JSR multiply             ; Call multiply subroutine
        
        LDX $00                  ; Load the original side length
        LDY $00                  ; Load the original side length
        JSR multiply             ; Call multiply subroutine
        
        LDA $01                  ; Load the area (side length * doubled side length)
        STA $02
        
        LDX $00                  ; Load the original side length
        JSR multiply             ; Call multiply subroutine
        
        LDA $00 
        TAY
        LDA $02
        CLC
        ADC $00                  ; Calculate the area of the heptagon
        LSR                      ; Divide by 2
        STA $03                  ; Store the area in memory location $03
        
        ; End of calculation, result is in memory location $03
        
        ; Halt the program
        BRK
        
multiply:
        PHA                      ; Store A on stack
        TXA
        PHA                      ; Store X on stack
        
        LDA $01
        TAX
        LDY #0
        
multiply_loop:
        CLC
        ADC $00
        DEY
        BNE multiply_loop
        
        PLA                      ; Restore X from stack
        TAX
        PLA                      ; Restore A from stack
        RTS

