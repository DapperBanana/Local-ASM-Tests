
    .org $0200    ; Start program at address $0200

player_hand   .block 2  ; Player's hand (bytes 0 and 1)
dealer_hand   .block 2  ; Dealer's hand (bytes 2 and 3)
deck          .block 52 ; Deck of cards (1 byte per card)

start:
    lda #$00
    sta player_hand
    sta dealer_hand
    sta deck
    jsr initialize_deck

deal:
    jsr shuffle_deck
    lda deck,x
    sta player_hand
    inx
    lda deck,x
    sta dealer_hand
    inx
    rts

initialize_deck:
    ldx #$00
loop:
    lda #1
    sta deck,x
    lda #2
    sta deck+1,x
    lda #3
    sta deck+2,x
    lda #4
    sta deck+3,x
    inx
    inx
    inx
    inx
    cpx #52
    bne loop
    rts

shuffle_deck:
    ldx #51
shuffle_loop:
    lda deck,x
    sta temp
    lda #0
    sta deck,x
    lda (random_seed),y
    sta deck,temp
    dex
    dey
    cpx #0
    bne shuffle_loop
    rts

random_seed:
    .byte $12, $67, $AB, $E1

temp: .byte $00

