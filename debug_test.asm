
        .org $0200

start   lda #<playlist
        sta $fb
        lda #>playlist
        sta $fc

        jsr printMenu

mainloop lda #<menu
        sta $fb
        lda #>menu
        sta $fc

        jsr printMenu

        jsr getInput

        cmp #'1'
        beq playSong

        cmp #'2'
        beq addSong

        cmp #'3'
        beq deleteSong

        jmp mainloop

playSong
        jsr clearScreen

        lda #<playlist
        sta $fb
        lda #>playlist
        sta $fc

        jsr printPlaylist

        jsr getInput

        tax
        lda playlist, x
        jsr printString

        rts

addSong
        lda #<playlist
        sta $fb
        lda #>playlist
        sta $fc

        jsr printPlaylist

        jsr getInput

        lda $fe
        tax

        lda #<playlist
        sta $fb
        lda #>playlist
        sta $fc

        jsr printInputPrompt
        jsr getInput

        sta playlist, x

        jsr clearScreen

        lda #<successMsg
        sta $fb
        lda #>successMsg
        sta $fc

        jsr printString

        rts

deleteSong
        lda #<playlist
        sta $fb
        lda #>playlist
        sta $fc

        jsr printPlaylist

        jsr getInput

        tax
        inx
        txa
        sta playlist, x

        jsr clearScreen

        lda #<successMsg
        sta $fb
        lda #>successMsg
        sta $fc

        jsr printString

        rts

printMenu
        lda #<menuMsg
        sta $fb
        lda #>menuMsg
        sta $fc

        jsr printString

        rts

printPlaylist
        lda #<playlistMsg
        sta $fb
        lda #>playlistMsg
        sta $fc

printLoop
        lda playlist, x
        jsr printString
        inx
        bne printLoop

        rts

printString
        lda (fb), y
        beq endPrintString
        jsr $ffd2
        iny
        jmp printString

endPrintString
        rts

printInputPrompt
        lda #<inputPromptMsg
        sta $fb
        lda #>inputPromptMsg
        sta $fc

        jsr printString

        rts

getInput
        ldy #0

getInputLoop
        jsr $ffce
        cmp #13
        beq endGetInput
        sta $fe, y
        iny
        jmp getInputLoop

endGetInput
        rts

.successMsg .text "Success!"
.menuMsg    .text "1. Play song\n2. Add song\n3. Delete song\nChoose an option: \0"
.playlistMsg .text "Playlist:\n"
.inputPromptMsg .text "Enter song title: \0"
playlist    .ds 256

        .end
