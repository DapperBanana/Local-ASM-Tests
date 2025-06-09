
    .org $0600

playerHP = $00
enemyHP = $01
playerATK = $02
enemyATK = $03
playerDEF = $04
enemyDEF = $05

start:
    LDA #100     ; Player starts with 100 HP
    STA playerHP
    LDA #100     ; Enemy starts with 100 HP
    STA enemyHP
    LDA #10      ; Player attack power
    STA playerATK
    LDA #10      ; Enemy attack power
    STA enemyATK
    LDA #5       ; Player defense
    STA playerDEF
    LDA #5       ; Enemy defense
    STA enemyDEF
    JSR displayStats

battleLoop:
    JSR playerTurn
    JSR enemyTurn
    JSR displayStats
    JMP battleLoop

playerTurn:
    LDA playerATK
    SEC
    SBC enemyDEF
    BPL playerDealsDamage
    RTS

playerDealsDamage:
    STA damage
    LDA enemyHP
    SEC
    SBC damage
    STA enemyHP
    RTS

enemyTurn:
    LDA enemyATK
    SEC
    SBC playerDEF
    BPL enemyDealsDamage
    RTS

enemyDealsDamage:
    STA damage
    LDA playerHP
    SEC
    SBC damage
    STA playerHP
    RTS

displayStats:
    LDA playerHP
    STA $8000
    LDA enemyHP
    STA $8001
    LDA playerATK
    STA $8002
    LDA enemyATK
    STA $8003
    LDA playerDEF
    STA $8004
    LDA enemyDEF
    STA $8005
    RTS

    .pad $0700, $7FFF
