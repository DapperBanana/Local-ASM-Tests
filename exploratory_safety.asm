
    .org $0200
start
    ; Initialize variables
    lda #0
    sta player_total
    sta dealer_total
    
    ; Deal the cards
    jsr deal_card_to_player
    jsr deal_card_to_player
    jsr deal_card_to_dealer
    jsr deal_card_to_dealer
    
    ; Player's turn
player_turn
    jsr display_player_hand
    jsr ask_for_hit
    cmp #1
    beq player_hit
    jmp dealer_turn
    
player_hit
    jsr deal_card_to_player
    jsr display_player_hand
    lda player_total
    cmp #21
    bcc player_turn
    
    ; Dealer's turn
dealer_turn
    jsr display_dealer_hand
    
    ; Dealer hits until total is 17 or higher
dealer_hit_loop
    lda dealer_total
    cmp #17
    bge end_game
    
    jsr deal_card_to_dealer
    jsr display_dealer_hand
    jmp dealer_hit_loop

end_game
    ; Determine winner and display message 
    lda player_total
    cmp #21
    bgt player_wins
    lda dealer_total
    cmp #21
    bgt dealer_wins
    lda player_total
    cmp dealer_total
    bgt player_wins
    jmp dealer_wins

player_wins
    lda #0
    sta $D0200
    rts

dealer_wins
    lda #1
    sta $D0200
    rts

deal_card_to_player
    ; Add random card value to player's hand
    rts

deal_card_to_dealer
    ; Add random card value to dealer's hand
    rts

display_player_hand
    ; Display player's hand
    rts

display_dealer_hand
    ; Display dealer's hand
    rts

ask_for_hit
    ; Ask player if they want to hit
    ; Return result in the accumulator
    rts
