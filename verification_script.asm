
        .org $0200

Fibonacci:
        LDX n              ; Load n into X register
        CPX #$02           ; Compare n to 2
        BCC BaseCase       ; Branch if n < 2
        
        TXA                ; Transfer n to A register
        SEC                ; Set carry flag
        SBC #$02           ; Subtract 2 from n
        STA nMinus2        ; Store n-2
        LDA #$00           ; Load 0 into A register
        STA nMinus1        ; Store 0 as F(1)
        
Loop:
        LDA nMinus2        ; Load n-2
        CLC                ; Clear carry flag
        ADC nMinus1        ; Add n-1
        STA fibPrev        ; Store previous Fibonacci number
        
        LDA nMinus1        ; Load n-1
        STA nMinus2        ; Update n-2
        
        LDA fibPrev        ; Load previous Fibonacci number
        STA nMinus1        ; Update n-1
        
        DEX                ; Decrement X register
        CPX #$02           ; Compare X to 2
        BCC BaseCase       ; Branch if n < 2
        
        JMP Loop           ; Jump back to Loop
        
BaseCase:
        LDA n              ; Load n
        CMP #$00           ; Compare n to 0
        BEQ End            ; Branch if n == 0
        CMP #$01           ; Compare n to 1
        BEQ End            ; Branch if n == 1
        
        LDA nMinus1        ; Load previous Fibonacci number
        RTS                ; Return
        
End:
        LDA fibPrev        ; Load Fibonacci number
        RTS                ; Return

n:      .byte $05         ; Input n
nMinus1: .byte $00         ; F(1)
nMinus2: .byte $00         ; F(0)
fibPrev: .byte $00         ; Fibonacci number holder

        .end
