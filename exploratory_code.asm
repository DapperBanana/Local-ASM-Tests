
; 6502 Assembly RPG Battle System

; Define memory locations for variables
player_health = $00
monster_health = $01

; Initialize player and monster health
        LDA #10         ; Set player health to 10
        STA player_health
        
        LDA #10         ; Set monster health to 10
        STA monster_health

; Main game loop
game_loop:
        ; Player attacks
        LDA #1          ; Player attack damage
        SEC
        SBC monster_health    ; Subtract damage from monster health
        STA monster_health
        
        ; Check if monster health is zero
        LDA monster_health
        BEQ game_over
        
        ; Monster attacks
        LDA #2          ; Monster attack damage
        SEC
        SBC player_health     ; Subtract damage from player health
        STA player_health
        
        ; Check if player health is zero
        LDA player_health
        BEQ game_over
        
        ; Loop back to game loop
        JMP game_loop

; Game over routine
game_over:
        LDA player_health
        BEQ player_lose
        BEQ player_win
        
player_lose:
        LDX #0
        STX $0200
        JMP $

player_win:
        LDX #1
        STX $0200
        JMP $
