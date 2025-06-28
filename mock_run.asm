
; Text-based RPG Battle System

START:
    LDX #10   ; Player HP
    LDY #5    ; Enemy HP
    
BATTLE_LOOP:
    ; Player attacks
    LDA #2    ; Player attack damage
    CLC
    ADC Y     ; Subtract damage from enemy HP
    STA Y
    
    ; Check if enemy is defeated
    CPY #0
    BEQ PLAYER_WINS
    
    ; Enemy attacks
    LDA #1    ; Enemy attack damage
    CLC
    ADC X     ; Subtract damage from player HP
    STA X
    
    ; Check if player is defeated
    CPX #0
    BEQ ENEMY_WINS
    
    JMP BATTLE_LOOP

PLAYER_WINS:
    LDA #"Player wins!"
    JSR PRINT_STRING
    JMP END

ENEMY_WINS:
    LDA #"Enemy wins!"
    JSR PRINT_STRING
    JMP END

PRINT_STRING:
    STA $6000   ; Store character in memory
    LDA $6000   ; Load character from memory
    JSR $FFD2   ; Output character to screen
    RTS

END:
    RTS
