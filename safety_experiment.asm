
    .org $0200

    ; Constants
    start_address = $0200
    word_length = 8
    max_attempts = 6
    guess_prompt = "Enter a letter: "
    win_msg = "Congratulations, you've won!"
    lose_msg = "Sorry, you've lost!"
    
    ; Variables
    word:        .byte "HANGMAN",0
    current_word: .byte word_length, 0
    guessed_word: .byte word_length, 0
    attempts:    .byte 0
    correct_count: .byte 0
    input_char:    .byte 0
    
    reset:
        ldx #0
    copy_word:
        lda word, x
        sta current_word, x
        inx
        cpx #word_length
        bne copy_word
        
        lda #0
        sta attempts
        rts
    
    display_word:
        lda #$0A
        jsr $FFD2
        ldx #0
    print_word:
        lda current_word, x
        beq display_word_done
        jsr $FFD2
        inx
        bne print_word
    display_word_done:
        rts
    
    check_input:
        lda #<guess_prompt
        ldy #>guess_prompt
        jsr $FFA1
        
        lda #0
        ldy #0
        jsr $FFCC
        sta input_char
        
        lda #$0A
        jsr $FFD2
        rts
    
    check_guess:
        ldx #0
    check_guess_loop:
        lda current_word, x
        beq check_guess_done
        
        cmp input_char
        beq correct_guess
        
        inx
        bne check_guess_loop
        
    correct_guess:
        lda input_char
        sta guessed_word, x
        inc correct_count
        
        lda #1
        rts
    
    check_guess_done:
        lda #0
        rts
    
    check_win:
        lda correct_count
        cmp word_length
        beq win
        
        lda attempts
        cmp max_attempts
        bne play_game
        
        jmp lose
    
    win:
        lda #$0A
        jsr $FFD2
        lda #<win_msg
        ldy #>win_msg
        jsr $FFA1
        rts
    
    lose:
        lda #$0A
        jsr $FFD2
        lda #<lose_msg
        ldy #>lose_msg
        jsr $FFA1
        rts
    
    play_game:
        lda #0
        sta correct_count
        
        jsr reset
    
    game_loop:
        jsr display_word
        jsr check_input
        jsr check_guess
        
        lda #1
        clc
        adc attempts
        sta attempts
        
        jsr check_win
        jmp game_loop
