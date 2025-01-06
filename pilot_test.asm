
        .org $0200

word    .byte "HELLO",0
        .byte $05

guess   .byte "_____"
        .byte $05

incorrect_guesses .byte $00

        .org $FC
        .word game_start

game_start:
        ldx #0
        jsr print_guess
        jsr get_input
        jsr check_input
        jsr check_win
        bne game_start
        
        lda #$0D
        jsr print_char
        rts

print_guess:
        ldx #0
print_loop:
        lda guess,x
        jsr print_char
        inx
        cpx #$05
        bne print_loop
        lda #$0D
        jsr print_char
        rts

get_input:
        ldx #0
input_loop:
        lda #$00
        jsr read_char
        sta $FD
        jsr check_input
        beq input_loop
        rts

check_input:
        lda $FD
        cmp #$61
        bcc invalid_input
        cmp #$7A
        bcs invalid_input
        sta $FE
        lda incorrect_guesses
        cmp #$08
        beq invalid_input
        lda word,y
        sec
        ldx #0
compare_loop:
        lda $FD
        cmp $FE
        beq update_guess
        lda word,y,x
        cmp $FD
        bne next_char
update_guess:
        sta guess,y
        lda $FE
        sta guess+1,y
        rts
next_char:
        inx
        cpx word+1,y
        bne compare_loop
        inc incorrect_guesses
        rts
invalid_input:
        jsr print_invalid_input_message
        lda $FE
        inc $FE
        rts

print_invalid_input_message:
        lda #"Invalid input! Please enter a letter between A-Z\n"
        jsr print_string
        rts

check_win:
        ldx #0
        ldy #0
check_win_loop:
        lda word,y,x
        cmp guess,y
        bne end_check_win
        inx
        cpx word+1,y
        beq player_wins
        jmp check_win_loop
player_wins:
        lda #"Congratulations! You win!\n"
        jsr print_string
        lda #$00
        rts
end_check_win:
        lda incorrect_guesses
        cmp #$08
        bne continue_game
        lda #"Sorry, you lose. The word was: "
        jsr print_string
        jsr print_word
        lda $FD
        lda #$0D
        jsr print_char
        rts
continue_game:
        lda #"Incorrect Guesses: "
        jsr print_string
        lda incorrect_guesses
        jsr print_char
        lda #$0D
        jsr print_char
        rts

print_word:
        lda y
        jsr print_char
        iny
        lda word,x
        jmp print_word

print_char:
        sta $C000
        lda #$01
        sta $C002
        lda $C001
        and #$1F
        beq *-3
        rts

print_string:
        ldy #0
print_string_loop:
        lda player_message,y
        beq print_string_end
        jsr print_char
        iny
        jmp print_string_loop
print_string_end:
        rts

player_message: .byte "Hello\n",0

read_char:
        lda $C000
        and #$7F
        bne read_char
        lda $C000
        and #$7F
        rts
