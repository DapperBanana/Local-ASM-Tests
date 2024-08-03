
; Blackjack game in 6502 Assembly

START   LDX #0       ; Initialize player score
        LDY #0       ; Initialize dealer score
        
deal    JSR drawCard ; Player draw a card
        CLC          ; Clear carry flag
        ADC card     ; Add card value to player score
        TAX          ; Copy player score to X register
        CPX #21      ; Compare player score to 21
        BCC deal     ; If player score is less than 21, continue dealing
        
        JSR drawCard ; Dealer draw a card
        CLC          ; Clear carry flag
        ADC card     ; Add card value to dealer score
        CPY #17      ; Compare dealer score to 17
        BCC deal     ; If dealer score is less than 17, continue dealing
        
        CPX CPY      ; Compare player score with dealer score
        BPL playerWin ; If player score is higher than dealer, player wins
        JMP dealerWin ; If dealer score is higher than player, dealer wins
        
playerWin
        ; Player wins
        RTS
        
dealerWin
        ; Dealer wins
        RTS
        
drawCard
        LDA #10      ; 10 (10, J, Q, K)
        STA card
        RTS
        
card    .BYTE 0      ; Variable to store card value
