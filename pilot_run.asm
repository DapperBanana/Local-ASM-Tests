
ORG $0200
LDA #$00  ; set up player stats
STA player_hp
LDA #$0A
STA player_attack
LDA #$05
STA player_defense

LDA #$00  ; set up enemy stats
STA enemy_hp
LDA #$08
STA enemy_attack
LDA #$03
STA enemy_defense

LDA #$00  ; initialize battle turn
STA turn

main:
    JSR player_turn
    JSR enemy_turn
    JMP main

player_turn:
    LDA player_hp
    BEQ player_defeated
    LDA enemy_hp
    BEQ enemy_defeated

    LDA player_attack
    STA damage
    LDA enemy_defense
    SEC
    SBC damage
    BPL damage_done
    LDA #$00
    STA damage

damage_done:
    LDA enemy_hp
    SEC
    SBC damage
    STA enemy_hp
    LDA enemy_hp
    BEQ enemy_defeated
    RTS

player_defeated:
    LDA #$00
    STA enemy_hp
    RTS

enemy_turn:
    LDA enemy_hp
    BEQ enemy_defeated
    LDA player_hp
    BEQ player_defeated

    LDA enemy_attack
    STA damage
    LDA player_defense
    SEC
    SBC damage
    BPL damage_done_enemy
    LDA #$00
    STA damage

damage_done_enemy:
    LDA player_hp
    SEC
    SBC damage
    STA player_hp
    LDA player_hp
    BEQ player_defeated
    RTS

enemy_defeated:
    LDA #$00
    STA player_hp
    RTS

player_hp: .BYTE $00
player_attack: .BYTE $00
player_defense: .BYTE $00

enemy_hp: .BYTE $00
enemy_attack: .BYTE $00
enemy_defense: .BYTE $00

damage: .BYTE $00

turn: .BYTE $00

.END
