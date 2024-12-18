
.org $1000

start:
    lda #0
    sta player_selection
    lda #0
    sta points
    lda #0
    sta wins
    lda #0
    sta losses

mainloop:
    lda #0
    jsr print_menu
    lda player_selection
    cmp #1
    beq select_player
    cmp #2
    beq simulate_match
    cmp #3
    beq display_stats
    cmp #4
    beq end_program
    jmp mainloop

select_player:
    jsr clear_screen
    lda #$80
    sta $d020
    jsr print_select_player_menu
    lda $ff00
    lsr
    sta player_selection
    jmp mainloop

simulate_match:
    jsr clear_screen
    lda #$80
    sta $d020
    jsr print_simulation
    lda #$01
    clc
    adc points
    sta points
    lda wins
    inx
    lda losses
    adc #1
    sta losses
    lda #$1
    sta $ff00
    jmp mainloop

display_stats:
    jsr clear_screen
    lda #$80
    sta $d020
    jsr print_stats
    jmp mainloop

end_program:
    rts

print_menu:
    lda #$80
    sta $d020
    lda #0
    sta $ff00
    jsr print_string
    lda #4
    rts

print_select_player_menu:
    lda #1
    sta $ff00
    lda #$80
    sta $d020
    lda #0
    jsr print_string
    lda #1
    sta $ff00
    lda #0
    jsr print_string
    lda #2
    jmp print_string

print_simulation:
    lda #$80
    sta $d020
    lda #0
    jsr print_string
    lda #1
    jsr print_string
    lda #2
    jsr print_string
    lda #3
    jsr print_string
    lda #4
    rts

print_stats:
    lda #$80
    sta $d020
    lda #0
    jsr print_string
    lda points
    jsr print_string
    lda wins
    jsr print_string
    lda losses
    jsr print_string
    lda #4
    rts

print_string:
    ldy #0
loop:
    lda message, y
    beq end_string
    jsr $ffd2
    iny
    jmp loop
end_string:
    rts

clear_screen:
    lda #$93
    jsr $ffd2
    lda #$00
    sta $d020
    rts

message:
    .byte "Welcome to Fantasy Sports Manager!"
    .byte "1. Select Player"
    .byte "2. Simulate Match"
    .byte "3. Display Stats"
    .byte "4. Quit"
    .byte 0

player_selection:
    .byte 0

points:
    .byte 0

wins:
    .byte 0

losses:
    .byte 0

.end
