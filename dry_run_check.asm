
; 6502 Assembly program to calculate the area of a parallelogram
; Inputs: Base - stored at memory location $00, Height - stored at memory location $01
; Output: Area - stored at memory location $02

        .org $0200   ; Start program at memory location $0200

Base    = $00       ; Define memory location for Base
Height  = $01       ; Define memory location for Height
Area    = $02       ; Define memory location for Area

        LDA Base    ; Load Base into A
        STA $10     ; Store Base in temporary location $10
        LDA Height  ; Load Height into A
        STA $11     ; Store Height in temporary location $11
        
        LDA $10     ; Load Base from temporary location $10 into A
        CLC         ; Clear carry bit
        ADC $11     ; Add Height from temporary location $11 to A
        ASL         ; Multiply result by 2
        STA Area    ; Store result in Area memory location

        BRK         ; End program

        .end        ; End of program
