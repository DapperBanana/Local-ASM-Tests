
; 6502 Assembly RPG Battle System

; Constants
PLAYER_HP = $C0
ENEMY_HP = $C1

; Main program
        LDX #10     ; Initialize player HP
        STX PLAYER_HP

        LDX #10     ; Initialize enemy HP
        STX ENEMY_HP

battle_loop:
        ; Player's turn
        JSR player_attack

        ; Check if enemy is defeated
        LDA ENEMY_HP
        BEQ enemy_defeated

        ; Enemy's turn
        JSR enemy_attack

        ; Check if player is defeated
        LDA PLAYER_HP
        BEQ player_defeated

        JMP battle_loop

enemy_defeated:
        LDA #<enemy_defeated_msg
        LDY #>enemy_defeated_msg
        JMP print_message

player_defeated:
        LDA #<player_defeated_msg
        LDY #>player_defeated_msg
        JMP print_message

player_attack:
        LDA #3      ; Player attack damage
        CLC
        LDX #0
        ADC ENEMY_HP
        STX ENEMY_HP
        RTS

enemy_attack:
        LDA #2      ; Enemy attack damage
        CLC
        LDX #0
        ADC PLAYER_HP
        STX PLAYER_HP
        RTS

print_message:
        LDA (LDA),Y   ; Load message from memory
        JSR $FFD2     ; Print message to screen
        RTS

enemy_defeated_msg:
        .asciiz "Enemy defeated!\n"
player_defeated_msg:
        .asciiz "Player defeated!\n"

        .org $FFFA
        .word battle_loop
