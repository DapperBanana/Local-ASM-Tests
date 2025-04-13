
        .org $0200

start   lda intro
        jsr print_string
        
        lda player_hp
        clc
        adc #100
        sta player_hp

battle_loop
        lda enemy_hp
        beq enemy_defeated
        
        lda player_hp
        beq player_defeated
        
        lda player_attack
        sta attack_damage
        
        lda player_defense
        sta defense_amount
        
        lda enemy_attack
        sta enemy_attack_damage
        
        lda enemy_defense
        sta enemy_defense_amount
        
        jsr player_attack_enemy
        jsr enemy_attack_player
        
        lda player_hp
        beq player_defeated
        
        jsr print_player_hp
        
        lda enemy_hp
        beq enemy_defeated
        
        jsr print_enemy_hp
        
        lda #20
        jsr delay
        
        jmp battle_loop

player_attack_enemy
        lda attack_damage
        sta damage_dealt_to_enemy
        
        lda enemy_defense_amount
        sta defense_amount
        
        clc
        lda enemy_hp
        adc damage_dealt_to_enemy
        sbc defense_amount
        bpl enemy_still_alive
        
        lda #0
        sta enemy_hp
        
        rts
        
enemy_still_alive
        sta enemy_hp
        rts

enemy_attack_player
        lda enemy_attack_damage
        sta damage_dealt_to_player
        
        lda defense_amount
        sta player_defense_amount
        
        clc
        lda player_hp
        adc damage_dealt_to_player
        sbc player_defense_amount
        bpl player_still_alive
        
        lda #0
        sta player_hp
        
        rts
        
player_still_alive
        sta player_hp
        rts

print_player_hp
        lda player_hp
        jsr print_num
        lda player_hp_msg
        jsr print_string
        
        rts

print_enemy_hp
        lda enemy_hp
        jsr print_num
        lda enemy_hp_msg
        jsr print_string
        
        rts

enemy_defeated
        lda enemy_defeated_msg
        jsr print_string
        
        rts

player_defeated
        lda player_defeated_msg
        jsr print_string
        
        rts

print_string
        sta temp_char
print_loop
        lda temp_char, x
        beq print_end
        jsr print_char
        inx
        jmp print_loop
print_end
        rts

print_char
        lda #$02
        jsr $ffd2
        rts

print_num
        ; convert the number to ASCII
        lda #$00
        sta ascii_num + 2
        lda #10
        
convert_loop 
        clc
        div ascii_num + 2
        sta ascii_num + 2
        lda #$30
        adc #$00
        sta ascii_num, x
        
        dex 
        bne convert_loop 
        
        lda #$00
        rts

delay
        ; delay loop
        lda #30
delay_loop
        dey
        bne delay_loop
        
        rts

intro   .text "You encounter a fierce enemy! Get ready for battle!"
player_hp .byte 100
player_attack .byte 20
player_defense .byte 10
enemy_hp .byte 50
enemy_attack .byte 15
enemy_defense .byte 5

attack_damage .byte 0
defense_amount .byte 0
damage_dealt_to_enemy .byte 0
enemy_attack_damage .byte 0
enemy_defense_amount .byte 0
damage_dealt_to_player .byte 0
player_defense_amount .byte 0

temp_char .byte 0
ascii_num .byte 0,0,0

player_hp_msg .text "Player HP: "
enemy_hp_msg .text "Enemy HP: "
enemy_defeated_msg .text "You have defeated the enemy!"
player_defeated_msg .text "The enemy has defeated you!"

        .end
