
; Tic-Tac-Toe game in 6502 Assembly

; Define some constants for player symbols
PLAYER_1 equ 'X'
PLAYER_2 equ 'O'
EMPTY equ ' '

; Define some constants for game state
WIN equ 1
TIE equ 2
ONGOING equ 0

; Define memory locations for the game board and current player
BOARD equ $0200
CURRENT_PLAYER equ $0209

*=$600

start:  lda #PLAYER_1
        sta CURRENT_PLAYER

        jsr print_board
        jsr play_game

        ; Game over, print result
        lda CURRENT_PLAYER
        cmp #PLAYER_1
        beq player_2_wins
        lda #WIN
        jsr print_status
        jmp end_game

player_2_wins: lda #WIN
               jsr print_status

end_game: rts

play_game:  lda #0
            sta BOARD

game_loop:
        lda BOARD
        cmp #0
        bne check_win
        
        jsr switch_player
        jsr print_prompt
        jsr get_move

        lda BOARD, x
        cmp #EMPTY
        bne invalid_move
        sta BOARD, x
        
        jsr print_board
        jsr check_win
        
        jmp game_loop

invalid_move:
        lda #2
        jsr print_status

        jmp game_loop

check_win:  jsr check_row
            bcs player_wins
            jsr check_column
            bcs player_wins
            jsr check_diagonal
            bcs player_wins

            lda BOARD
            cmp #$9
            beq tie_game

            rts

player_wins: lda #WIN
             rts

tie_game:   lda #TIE
            rts

switch_player: 
        lda CURRENT_PLAYER
        cmp #PLAYER_1
        beq switch_to_player_2

        lda #PLAYER_1
        sta CURRENT_PLAYER
        rts

switch_to_player_2:
        lda #PLAYER_2
        sta CURRENT_PLAYER
        rts

print_prompt: 
        ldx #13
        lda #32
        jsr $ffd2
        ldx #14
        lda CURRENT_PLAYER
        jsr $ffd2
        lda #"\'s"
        jsr $ffd2
        lda #" move: "
        jsr $ffd2
        rts

get_move: lda #0
        sta $fb
        lda $fb
        cmp #13
        beq get_move
        lda $fb
        and #$0f
        clc
        adc #$20
        sta $fb
        rts

print_board: 
        ldx #0
row_loop: 
        lda BOARD, x
        jsr $ffd2
        inx
        cpx #3
        bne row_loop

        lda #13
        jsr $ffd2
        lda #10
        jsr $ffd2

        rts

print_status:
        sta $fb
        lda #13
        jsr $ffd2
        lda #10
        jsr $ffd2
        rts

; Functions to check win conditions

check_row: 
        ldx #0
row_loop: 
        lda BOARD, x
        cmp BOARD, x+1
        beq row_check_next
        inx
        lda BOARD, x
        cmp BOARD, x+1
        beq row_check_next
        bcc row_win
        rts

row_check_next: 
        inx
        cpx #2
        bne row_loop

        clc
        rts

row_win: 
        lda #1
        rts

check_column: 
row_loop: 
        lda BOARD, x
        cmp BOARD, x+3
        beq col_check_next
        inx
        lda BOARD, x
        cmp BOARD, x+3
        beq col_check_next
        bcc col_win
        rts

col_check_next: 
        inx
        cpx #6
        bne row_loop

        clc
        rts

col_win: 
        lda #1
        rts

check_diagonal: 
        lda BOARD
        cmp BOARD, 4
        beq diag_check_next
        lda BOARD, 2
        cmp BOARD, 4
        beq diag_win
        lda BOARD
        cmp BOARD, 6
        beq diag_win
        rts

diag_check_next: 
        lda BOARD, 2
        cmp BOARD, 6
        beq diag_win

        clc
        rts

diag_win: 
        lda #1
        rts
