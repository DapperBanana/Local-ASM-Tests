
; Social Media Platform Simulation

        .org $0200

POSTS   .ds 10 ; Array to store posts
CURR_POST .db 0 ; Index of current post
INPUT_BUFFER .ds 20 ; Input buffer for user input

MAIN:   lda #0
        sta CURR_POST ; Set current post index to 0

LOOP:   lda #0
        jsr PRINT_MENU
        jsr GET_INPUT

        cmp #1
        beq POST
        cmp #2
        beq READ_POSTS
        cmp #3
        beq EXIT

        bra LOOP

POST:   lda CURR_POST
        clc
        adc #1
        sta CURR_POST

        lda INPUT_BUFFER
        sta POSTS, x
        inx

        lda #"Post successful!"
        jsr PRINT_MESSAGE

        bra LOOP

READ_POSTS:
        lda #0
        sta x

READ_LOOP:
        lda POSTS, x
        beq END_READ_LOOP

        jsr PRINT_POST
        inx
        bra READ_LOOP

END_READ_LOOP:
        bra LOOP

EXIT:
        rts

PRINT_MENU:
        lda #"\n\nSocial Media Platform\n"
        jsr PRINT_STRING

        lda #"\n1. Create Post\n"
        jsr PRINT_STRING

        lda #"\n2. Read Posts\n"
        jsr PRINT_STRING

        lda #"\n3. Exit\n"
        jsr PRINT_STRING

        rts

PRINT_POST:
        lda POSTS, x
        jsr PRINT_STRING

        lda #"\n"
        jsr PRINT_STRING

        rts

PRINT_MESSAGE:
        jsr PRINT_STRING
        lda #"\n"
        jsr PRINT_STRING

        rts

PRINT_STRING:
        sta $FE ; Load character into the AC
        ldx #$FF
        
PRINT_LOOP:
        inx

        ldy #$FE
        lda $FE, y
        beq PRINT_DONE
        
        jsr $FFD2 ;Output  a text character $FD, with screen code in x and colour code in color code register $FFFE

    
        bra PRINT_LOOP

PRINT_DONE:
        rts

GET_INPUT:
        lda #"GET /tmp/socket\n"
        jsr $FFD2 ; $FD, $FE, $FFFE
        lda INPUT_BUFFER
        sta $FE
        ldx #$FF
        
GET_LOOP:
        jsr $FFD2
        cmp #$0D
        beq GET_DONE

        sta INPUT_BUFFER, x
        dex
        bra GET_LOOP

GET_DONE:
        lda #0
        sta INPUT_BUFFER, x

        rts

        .end
