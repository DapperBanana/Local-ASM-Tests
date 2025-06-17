
CARD1 .byte $01
CARD2 .byte $02
CARD3 .byte $03
PLAYER1SCORE .byte $00
PLAYER2SCORE .byte $00

RESET:
    LDA #CARD1     ; Load card 1 into accumulator
    STA CARD1
    LDA #CARD2     ; Load card 2 into accumulator
    STA CARD2
    LDA #CARD3     ; Load card 3 into accumulator
    STA CARD3
    LDA #00        ; Load 0 into accumulator
    STA PLAYER1SCORE    ; Initialize player 1 score
    STA PLAYER2SCORE    ; Initialize player 2 score

START:
    LDA CARD1       ; Load card 1 into accumulator
    JSR PLAYERTURN  ; Execute player's turn
    CMP #FF
    BEQ GAMEOVER    ; Check for end of game
    LDA CARD2       ; Load card 2 into accumulator
    JSR PLAYERTURN  ; Execute player's turn
    CMP #FF
    BEQ GAMEOVER    ; Check for end of game
    LDA CARD3       ; Load card 3 into accumulator
    JSR PLAYERTURN  ; Execute player's turn
    CMP #FF
    BEQ GAMEOVER    ; Check for end of game
    BRA START       ; Continue game

PLAYERTURN:
    CLC
    ADC #01         ; Increment card value by 1
    CMP #04         ; Check if card value exceeds 3
    BCC ADDSCORE    ; Branch if card value is less than 4
    LDA #00         ; Reset card value to 0
    RTS

ADDSCORE:
    STA              ; Store card value
    CMP #01          ; Check for player 1
    BEQ INCREMENTPLAYER1SCORE
    BNE INCREMENTPLAYER2SCORE

INCREMENTPLAYER1SCORE:
    LDA PLAYER1SCORE
    ADC #01
    STA PLAYER1SCORE
    RTS

INCREMENTPLAYER2SCORE:
    LDA PLAYER2SCORE
    ADC #01
    STA PLAYER2SCORE
    RTS

GAMEOVER:
    BRK
