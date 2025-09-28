
; Define memory locations
PLAYER_HP = $00
ENEMY_HP = $01
PLAYER_ATTACK = $02
ENEMY_ATTACK = $03

; Start of main program
    LDA #$64      ; Set player HP to 100
    STA PLAYER_HP
    LDA #$64      ; Set enemy HP to 100
    STA ENEMY_HP
    LDA #$0A      ; Set player attack to 10
    STA PLAYER_ATTACK
    LDA #$0F      ; Set enemy attack to 15
    STA ENEMY_ATTACK

battle_loop:
    ; Player's turn
    LDA PLAYER_ATTACK
    CLC
    ADC ENEMY_HP
    STA ENEMY_HP
    JSR display_enemy_hp
    JSR check_enemy_hp
    JMP enemy_turn

enemy_turn:
    ; Enemy's turn
    LDA ENEMY_ATTACK
    CLC
    ADC PLAYER_HP
    STA PLAYER_HP
    JSR display_player_hp
    JSR check_player_hp
    JMP battle_loop

display_enemy_hp:
    LDA ENEMY_HP
    STA $0200     ; Display enemy HP
    RTS

display_player_hp:
    LDA PLAYER_HP
    STA $0201     ; Display player HP
    RTS

check_enemy_hp:
    LDA ENEMY_HP
    CMP #$00
    BEQ player_wins
    RTS

check_player_hp:
    LDA PLAYER_HP
    CMP #$00
    BEQ enemy_wins
    RTS

player_wins:
    LDA #$01      ; Player wins
    STA $0202
    RTS

enemy_wins:
    LDA #$02      ; Enemy wins
    STA $0202
    RTS
