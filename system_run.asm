
    .org $0200

start:
    LDX #$00        ; player health
    LDY #$00        ; enemy health
    
    ; Game Start
    JSR intro
    
    ; Battle phase
loop:
    JSR player_turn
    BEQ end_game
    
    JSR enemy_turn
    BEQ end_game
    
    JMP loop
    
end_game:
    JSR game_over
    
intro:
    LDA #<intro_text
    STA $0200
    
    LDA #>intro_text
    STA $0201
    
    JSR display_text
    
    RTS
    
player_turn:
    ; Player attacks
    LDA #$0A
    CLC
    ADC Y
    STA Y
    BCS player_win
    
    ; Enemy attacks
    LDA #$05
    CLC
    ADC X
    STA X
    BCS enemy_win
    
    RTS
    
enemy_turn:
    ; Enemy attacks
    LDA #$0A
    CLC
    ADC X
    STA X
    BCS enemy_win
    
    ; Player attacks
    LDA #$05
    CLC
    ADC Y
    STA Y
    BCS player_win
    
    RTS
    
player_win:
    LDA #<player_win_text
    STA $0200
    
    LDA #>player_win_text
    STA $0201
    
    JSR display_text
    
    RTS
    
enemy_win:
    LDA #<enemy_win_text
    STA $0200
    
    LDA #>enemy_win_text
    STA $0201
    
    JSR display_text
    
    RTS
    
game_over:
    LDA #<game_over_text
    STA $0200
    
    LDA #>game_over_text
    STA $0201
    
    JSR display_text
    
    RTS
    
display_text:
    LDY #$00
    
loop_display:
    LDA ($0200),Y
    BEQ end_display
    
    JSR $FFD2   ; KERNAL routine to output a character to screen
    
    INY
    JMP loop_display
    
end_display:
    RTS

intro_text:
    .text "Welcome to the RPG game! You'll fight against an enemy and see if you can win."
    .byte 0
    
player_win_text:
    .text "You won the battle! Congratulations!"
    .byte 0
    
enemy_win_text:
    .text "You were defeated by the enemy!"
    .byte 0
    
game_over_text:
    .text "Game over! Try again."
    .byte 0
