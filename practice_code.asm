
    .org $0600

    PLAYER_HP = $FB
    ENEMY_HP = $FC

start:
    lda #$FF
    sta PLAYER_HP
    lda #$0A
    sta ENEMY_HP

game_loop:
    lda PLAYER_HP
    beq player_dead

    lda ENEMY_HP
    beq enemy_dead

    jsr display_status

    jsr player_turn

    jsr enemy_turn

    jmp game_loop

player_turn:
    lda #$01
    sta $00 ; input flag

    lda PLAYER_HP
    cmp #$05
    bcc not_use_potion

    jsr use_potion

not_use_potion:
    lda #$0A
    sta $01 ; enemy hp
    jmp end_turn

enemy_turn:
    lda ENEMY_HP
    cmp #$05
    bcc not_use_enemy_potion

    jsr use_enemy_potion

not_use_enemy_potion:
    lda #$05
    sta PLAYER_HP

end_turn:
    rts

use_potion:
    lda PLAYER_HP
    clc
    adc #$05
    cmp #$0A
    bcs max_hp
    sta PLAYER_HP
    rts

max_hp:
    lda #$0A
    sta PLAYER_HP
    rts

use_enemy_potion:
    lda ENEMY_HP
    clc
    adc #$05
    cmp #$0A
    bcs enemy_max_hp
    sta ENEMY_HP
    rts

enemy_max_hp:
    lda #$0A
    sta ENEMY_HP
    rts

player_dead:
    lda #$00
    jsr display_status
    rts

enemy_dead:
    lda #$01
    jsr display_status
    rts

display_status:
    lda PLAYER_HP
    sta $FD
    
    lda ENEMY_HP
    sta $FE

    lda #$9B
    jsr $ff80

    lda $FD
    jsr $ff80

    lda #$2C
    jsr $ff80

    lda $FE
    jsr $ff80

    lda #$40
    jsr $ff80
    
    rts

    .end start
