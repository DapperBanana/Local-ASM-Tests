
    .org $0200

start:
    jsr init
loop:
    jsr drawHand
    jsr getAction
    
    cmp #0      ; check if player action is 'Hit'
    beq hit
    cmp #1      ; check if player action is 'Stand'
    beq stand
    
    jmp loop

hit:
    jsr dealCard          ; deal a new card to player
    jsr drawHand
    jsr playerScore
    
    cmp #21              ; check if player busts
    bcc loop
    
    ; player wins if not bust
    jsr drawWin
    rts

stand:
    jsr dealerPlay
    jsr drawHand
    jsr dealerScore
    
    ; check for winner
    cmp #2
    beq draw    ; check for a draw
    bcs dealerWin
    bcs playerWin
    
playerWin:              ; player wins
    jsr drawWin
    rts
    
dealerWin:              ; dealer wins
    jsr drawLoss
    rts
    
draw:                   ; game is draw
    jsr drawDraw
    rts

init:
    ; initialize random number generator
    lda $02
    clc
    adc #1
    sta $02
    
    lda $02
    adc #42
    sta $03
    
    lda $02
    adc #69
    sta $04
    
    lda $02
    adc #100
    sta $05
    
    rts

dealCard:
    ; generate random card value
    lda $02
    and #15        ; mask out lower 4 bits
    clc
    adc #1
    sta $08
    
    ; generate random suit
    lda $03
    and #3         ; mask out lower 2 bits
    sta $09
    
    rts

getAction:
    lda $0D       ; read input from player
    cmp #'h'
    beq hit
    cmp #'s'
    beq stand
    
    rts

playerScore:
    ; calculate player score
    lda $08
    clc
    adc $06
    sta $06
    
    rts

dealerPlay:
    ; dealer always hits if score is less than 17
    lda $07
    cmp #16
    bcc hit
    jmp stand
    
    rts

dealerScore:
    ; calculate dealer score
    lda $08
    clc
    adc $07
    sta $07
    
    rts

drawHand:
    ; display player and dealer hand
    lda $08
    jsr drawCard
    
    lda $08
    jsr drawCard
    
    jsr drawScore
    rts

drawCard:
    ; convert card value to ASCII and display
    cmp #10
    bcc toASCII
    adc #7
toASCII:
    adc #48
    jsr drawChar
    
    lda $09
    jsr drawSuit
    
    rts

drawChar:
    ; display character to screen
    sta $D020
    jsr incScreen
    
    rts

drawSuit:
    ; convert suit value to suit symbol and display
    cmp #0
    beq spades
    cmp #1
    beq hearts
    cmp #2
    beq diamonds
    cmp #3
    beq clubs
    
spades:
    lda #'S'
    jsr drawChar
    rts
    
hearts:
    lda #'H'
    jsr drawChar
    rts
    
diamonds:
    lda #'D'
    jsr drawChar
    rts
    
clubs:
    lda #'C'
    jsr drawChar
    rts

drawScore:
    ; display player and dealer scores
    lda $06
    jsr drawChar
    
    lda #':'
    jsr drawChar
    
    lda $07
    jsr drawChar
    
    rts

drawWin:
    ; display 'Player wins' message
    lda #'P'
    jsr drawChar
    
    lda #'L'
    jsr drawChar
    
    lda #'R'
    jsr drawChar
    
    lda $0A
    jsr drawChar
    
    lda #'w'
    jsr drawChar
    
    lda #'i'
    jsr drawChar
    
    lda #'n'
    jsr drawChar
    
    lda #'s'
    jsr drawChar
    
    rts

drawLoss:
    ; display 'Dealer wins' message
    lda #'D'
    jsr drawChar
    
    lda #'E'
    jsr drawChar
    
    lda #'A'
    jsr drawChar
    
    lda $0A
    jsr drawChar
    
    lda #'w'
    jsr drawChar
    
    lda #'i'
    jsr drawChar
    
    lda #'n'
    jsr drawChar
    
    lda #'s'
    jsr drawChar
    
    rts

drawDraw:
    ; display 'No winner' message
    lda #'N'
    jsr drawChar
    
    lda #'o'
    jsr drawChar
    
    lda $0A
    jsr drawChar
    
    lda #'w'
    jsr drawChar
    
    lda #'i'
    jsr drawChar
    
    lda #'n'
    jsr drawChar
    
    lda #'n'
    jsr drawChar
    
    lda #'e'
    jsr drawChar
    
    lda #'r'
    jsr drawChar
    
    rts

incScreen:
    lda $D021
    sec
    sbc #40
    sta $D021
    
    rts

    .org $FCFF
    .byte $00
