
    ; 6502 Assembly program for a Rock-Paper-Scissors game against the computer
    
    .org $8000
    
    LDA #0          ; Initialize player's choice (0 for rock, 1 for paper, 2 for scissors)
    STA player_choice
    
    JSR get_random_choice  ; Get random choice for computer
    
    LDA player_choice
    CMP computer_choice
    BEQ draw          ; Check for draw
    CMP #0
    BEQ rock_win       ; Check for player wins with rock
    CMP #1
    BEQ paper_win      ; Check for player wins with paper
    BEQ scissors_win   ; Check for player wins with scissors
    
    rock_win:
    LDA #1
    STA winner        ; Player wins
    BRA end_game
    
    paper_win:
    LDA #2
    STA winner        ; Player wins
    BRA end_game
    
    scissors_win:
    LDA #3
    STA winner        ; Player wins
    BRA end_game
    
    draw:
    LDA #0
    STA winner        ; Draw
    BRA end_game
    
    end_game:
    RTS
    
    get_random_choice:
    LDA #3
    STA $D021        ; Set border color to a random value for randomness
    LDA $D012        ; Get current value of CIA timer
    AND #3          ; Mask lower 2 bits to get random value between 0-2
    STA computer_choice
    RTS
    
    player_choice:  .byte 0
    computer_choice:  .byte 0
    winner:       .byte 0
    
    .end
