
; Social Media Platform Simulator

        .org $1000

; Constants
CR = $0D
LF = $0A
BUFFER_SIZE = 80
MAX_POSTS = 10

; Variables
bufferBuffer: .ds BUFFER_SIZE
messageBuffer: .ds BUFFER_SIZE
postsBuffer: .ds MAX_POSTS * BUFFER_SIZE
postPtr = $FB
postsCount = $FC
cursor = $FD
temp = $FE

start:
        lda #0
        sta postPtr       ; Initialize post pointer
        lda #0
        sta postsCount    ; Initialize number of posts
        lda #0
        sta cursor        ; Initialize cursor position

mainLoop:
        jsr clearScreen
        jsr printMenu
        jsr getInput

        lda bufferBuffer
        cmp #1
        beq createPost
        lda bufferBuffer
        cmp #2
        beq viewPosts
        lda bufferBuffer
        cmp #3
        beq exit

        jmp mainLoop

createPost:
        jsr clearScreen
        lda #CR
        jsr printChar
        lda #LF
        jsr printChar

        lda #0
editLoop:
        lda #CR
        jsr printChar
        lda #LF
        jsr printChar
        jsr printString, "Enter your message: "
        lda messageBuffer
        ldx #messageBuffer
editLoop2:
        jsr getInput
        cmp #CR
        beq savePost
        lda temp
        sta (x)
        inx
        jmp editLoop2

savePost:
        lda messageBuffer
        lda (postPtr),y

        inc postPtr
        inc postsCount
        jmp mainLoop

viewPosts:
        lda #0
        sta temp
        lda #0

displayPosts:
        lda postsCount
        cmp temp
        beq mainLoop

        lda postsBuffer, y
        jsr printString
        iny
        lda postsBuffer, y
        jsr printString
        lda #CR
        jsr printChar
        lda #LF
        jsr printChar

        lda temp
        inc temp
        jmp displayPosts

exit:
        rts

clearScreen:
        lda #12
        jsr $FFD2 ; CLRSCR
        lda #0
        ldx #0
        lda #0
clearLoop:
        jsr $FFD2 ; CHROUT
        lda #0
        inx
        cpx #40
        bne clearLoop
        lda #CR
        jsr printChar
        lda #LF
        jsr printChar
        rts

printChar:
        sta $FFD2 ; CHROUT
        rts

printString:
        ldx #0
        lda (x)
printStringLoop:
        jsr printChar
        inx
        lda (x)
        cmp #0
        bne printStringLoop
        rts

printMenu:
        lda #CR
        jsr printChar
        lda #LF
        jsr printChar
        jsr printString, "1. Create a new post"
        jsr printString, "2. View posts"
        jsr printString, "3. Exit"
        lda #CR
        jsr printChar
        lda #LF
        jsr printChar
        rts

getInput:
        ldx #0
inputLoop:
        lda $FF00
        cmp #CR
        beq endInput
        cmp #32
        beq inputLoop
        sta temp
        sta bufferBuffer, x
        inx
        jmp inputLoop
endInput:
        lda #0
        sta temp
        sta bufferBuffer, x
        rts

        .end
