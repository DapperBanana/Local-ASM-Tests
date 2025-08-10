
    .org $0200
start:
    jsr init_game

main_loop:
    jsr display_room
    jsr input
    jmp main_loop

init_game:
    lda #$ff      ; initialize player health
    sta player_health
    lda #$00      ; initialize player position
    sta player_position
    rts

display_room:
    lda player_position
    cmp #$00
    beq room1
    cmp #$01
    beq room2

room1:
    lda #"You are in a dark room. Go north to room 2."
    jmp print_str

room2:
    lda #"You are in a bright room. Go south to room 1."
    jmp print_str

input:
    lda #$01
    jsr $ffd2    ; Kernal routine to read input from keyboard
    cmp #"n"     ; check for input 'n' for north
    beq move_north
    cmp #"s"     ; check for input 's' for south
    beq move_south
    jmp input

move_north:
    lda player_position
    clc
    adc #$01
    sta player_position
    rts

move_south:
    lda player_position
    sec
    sbc #$01
    sta player_position
    rts

print_str:
    ldx #$00
print_loop:
    lda [message,x]
    beq print_end
    jsr $ffd2    ; Kernal routine to print character to screen
    inx
    jmp print_loop
print_end:
    rts

message:
    .text "You are in a dark room. Go north to room 2."
    .byte 0

player_health:
    .byte $ff

player_position:
    .byte $00

    .end
