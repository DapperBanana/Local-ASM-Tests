
    .org $0600

player_hp .byte 100
enemy_hp .byte 50
player_attack .byte 10
enemy_attack .byte 5

start:
    ; Print battle start message
    lda #<battle_start_message
    ldx #>battle_start_message
    jsr print_message
    
battle_loop:
    ; Player attack
    lda player_attack
    sta damage
    lda enemy_hp
    sec
    sbc damage
    sta enemy_hp
    jsr print_player_attack_message
    
    ; Check if enemy health is below 0
    lda enemy_hp
    beq player_win
    
    ; Enemy attack
    lda enemy_attack
    sta damage
    lda player_hp
    sec
    sbc damage
    sta player_hp
    jsr print_enemy_attack_message
    
    ; Check if player health is below 0
    lda player_hp
    beq enemy_win
    
    ; Repeat battle loop
    jmp battle_loop
    
player_win:
    ; Print player win message
    lda #<player_win_message
    ldx #>player_win_message
    jsr print_message
    rts
    
enemy_win:
    ; Print enemy win message
    lda #<enemy_win_message
    ldx #>enemy_win_message
    jsr print_message
    rts
    
print_message:
    jsr $ffd2
    lda #$0a
    jsr $ffd2
    lda #$0d
    jsr $ffd2
    ldy #0
loop:
    lda (lda),y
    beq end_loop
    jsr $ffd2
    iny
    jmp loop
end_loop:
    lda #" "
    jsr $ffd2
    rts

battle_start_message:
    .text "Battle Start!"
    .byte 0
    
player_win_message:
    .text "Player wins!"
    .byte 0
    
enemy_win_message:
    .text "Enemy wins!"
    .byte 0
    
print_player_attack_message:
    .text "Player attacks for " 
    .byte 0
    
print_enemy_attack_message:
    .text "Enemy attacks for " 
    .byte 0
    
damage:
    .byte 0

    .end
