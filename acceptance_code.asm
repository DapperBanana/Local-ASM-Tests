
; Tic-Tac-Toe Game in 6502 Assembly

; Constants
Player1 = '*'
Player2 = 'O'
Empty = ' '

; Memory Map
BoardStart = $0200
PlayerTurn = $020A
CurrentPlayer = $020B
Winner = $020C

; Main program
    .org $0600

start:
    lda #$20    ; clear screen
    jsr $FFD2

    lda #$00    ; initialize board
    ldx #$00
Loop:
    sta BoardStart, x
    inx
    cpx #$09
    bne Loop

    lda #Empty  ; set current player
    sta CurrentPlayer

    lda #Player1   ; set player turn
    sta PlayerTurn

gameLoop:
    lda PlayerTurn   ; display player turn
    jsr PrintChar
    lda #$0D
    jsr PrintChar

    lda BoardStart
    jsr PrintChar
    lda BoardStart+1
    jsr PrintChar
    lda BoardStart+2
    jsr PrintChar
    lda #$0D
    jsr PrintChar
    lda BoardStart+3
    jsr PrintChar
    lda BoardStart+4
    jsr PrintChar
    lda BoardStart+5
    jsr PrintChar
    lda #$0D
    jsr PrintChar
    lda BoardStart+6
    jsr PrintChar
    lda BoardStart+7
    jsr PrintChar
    lda BoardStart+8
    jsr PrintChar

playerMove:
    lda PlayerTurn
    cmp #Player1
    beq Player1Move
    cmp #Player2
    beq Player2Move

Player1Move:
    lda #$04    ; Player 1 input 'X'
    jsr $FFCF

    lda #$5E    ; get character from input buffer
    jsr $FFCF
    cmp #Empty  ; check if space is already taken
    bne playerMove
    sta BoardStart, x
    jmp checkWin

Player2Move:
    lda #$04    ; Player 2 input 'O'
    jsr $FFCF

    lda #$5E    ; get character from input buffer
    jsr $FFCF
    cmp #Empty  ; check if space is already taken
    bne playerMove
    sta BoardStart, x
    jmp checkWin

checkWin:
    ; check for win

    ; check horizontal
    ldx #0
    lda BoardStart, x
    cmp BoardStart+1
    beq CheckHorizontal
    lda BoardStart, x
    cmp BoardStart+2
    beq CheckHorizontal

CheckHorizontal:
    lda BoardStart, x
    cmp BoardStart+1
    beq CheckHorizontalWin
    lda BoardStart, x
    cmp BoardStart+2
    beq CheckHorizontalWin

CheckHorizontalWin:
    lda #Player1
    sta Winner
    jmp endGame

endGame:
    lda Winner
    cmp #Player1
    bne Player2Win

Player1Win:
    lda #Player1
    jsr PrintChar
    lda #$20
    jsr PrintChar
    lda #Player1
    jsr PrintChar
    lda #Player1
    jsr PrintChar
    lda #$20
    jsr PrintChar
    lda #Player1
    jsr PrintChar
    lda Player1
    jsr PrintChar
    lda #Player1
    jsr PrintChar
    lda #$0D
    jmp endGame

Player2Win:
    lda #Player2
    jsr PrintChar
    lda #$20
    jsr PrintChar
    lda #Player2
    jsr PrintChar
    lda #Player2
    jsr PrintChar
    lda #$20
    jsr PrintChar
    lda #Player2
    jsr PrintChar
    lda Player2
    jsr PrintChar
    lda #Player2
    jsr PrintChar
    lda #$0D
    jmp endGame

PrintChar:
    ; print character
    ldx #$00
    ldy #$02
    sta $0400, x
    sty $0401
    jsr $FFD2
    rts

    .end
