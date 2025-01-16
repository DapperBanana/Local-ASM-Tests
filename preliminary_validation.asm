
.org $0200

; Constants
MAX_POSTS = 10
MAX_CHAR  = 50

; Variables
posts      .block MAX_POSTS*MAX_CHAR
numPosts   .byte 0

; Main program
start:
    lda #0
    sta numPosts

    jsr displayMenu

repeat:
    jsr getSelection

    cmp #1
    beq showPosts
    cmp #2
    beq addPost
    cmp #3
    beq exit

    jmp repeat

displayMenu:
    lda #2
    jsr clearScreen

    lda #"1"
    jsr printChar
    lda #" - Show Posts"
    jsr printString

    lda #"2"
    jsr printChar
    lda #" - Add Post"
    jsr printString

    lda #"3"
    jsr printChar
    lda #" - Exit"
    jsr printString

    rts

getSelection:
    lda #0
    jsr readChar

    rts

showPosts:
    lda numPosts
    beq noPosts

    lda #1
    jsr clearScreen

    ldx #0

showPostLoop:
    lda posts,x
    jsr printString

    inx
    cpx numPosts
    bne showPostLoop

    rts

noPosts:
    lda #2
    jsr clearScreen

    lda #"No posts available."
    jsr printString

    rts

addPost:
    lda numPosts
    beq addNewPost

    lda numPosts
    asl
    asl
    asl
    clc
    adc posts
    sta posts

    lda #0
    sta posts+2,x

addNewPost:
    lda #3
    jsr clearScreen

    lda #"Enter your post (max 50 chars): "
    jsr printString

    jsr readString

    inx
    lda numPosts
    sta numPosts

    rts

exit:
    rts

; Subroutines

clearScreen:
    lda #1
    jsr printChar
    lda #12
    jsr printChar

    rts

printChar:
    sta $300
    lda #$FF
    sta $FFFC
    lda $300
    rts

printString:
    lda $300
    pha
    ldx #0

printStringLoop:
    lda $301,x
    beq printStringEnd

    jsr printChar

    inx
    cpx #MAX_CHAR
    beq printStringEnd

    jmp printStringLoop

printStringEnd:
    pla
    rts

readChar:
    lda #$60
    sta $FFF8

readCharLoop:
    lda $FFF8
    cmp #$60
    beq readCharLoop

    rts

readString:
    lda #$60
    sta $FFF8

readStringLoop:
    jsr readChar
    sta posts+2,x

    inx
    cpx #MAX_CHAR
    beq readStringEnd

    bne readStringLoop

readStringEnd:
    lda #$00
    sta posts+2,x

    rts

.end start
