
    .org $0200

letters    .byte "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
word       .byte "HANGMAN"
blankword  .byte "_______"

    ldx #0
    lda blankword,x
printloop
    beq end
    jsr $ffd2
    inx
    lda blankword,x
    jmp printloop

end lda #" "
    jsr $ffd2

game    ldy #0
again   lda word,y
    beq endgame
    sta $fb
    lda #" "
    jsr $ffd2
    ldx #0
checknext
    lda letters,x
    cmp $fb
    beq found
    inx
    cmp #" "
    bne checknext
    jmp getinput

found   lda word,y
    sta blankword,y
    iny
searchnext
    lda word,y
    beq win
    jsr $fded
    iny
    cmp $fb
    bne searchnext
    jmp found

win lda #"W"
    jsr $ffd2
    lda #"I"
    jsr $ffd2
    lda #"N"
    jsr $ffd2
    lda #"!"
    jsr $ffd2
    rts

getinput
    jsr $ffd2
    lda $fb
    rts

endgame rts

    .org $fffa
    .word game
    .word $0000
    .word game
