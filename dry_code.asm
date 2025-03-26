
        LDA #0          ; Clear X register
        STA $00         ; Clear carry
        STA $01         ; Clear numerator
        STA $02         ; Clear denominator
        
loop    CMP #10         ; Check if decimal number is less than 10
        BCC divide      ; If yes, skip division
        
        SEC             ; Increment denominator
        ADC #$01
        STA $02
        
        ASL A           ; Shift decimal number left
        DEC $00         ; Increment numerator
        BNE loop
        
        LSR $00         ; Shift numerator right
        LSR $00
        LSR $00
        
divide  LDA $00         ; Divide numerator by denominator
        CMP $02
        BCC loop
        
        SBC $02         ; Subtract denominator from numerator
        STA $00         ; Store remainder in numerator
        
        INC $01         ; Increment fraction numerator
        
        JMP divide      ; Repeat division
        
        RTS
