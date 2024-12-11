
; Music Playlist Manager

.org $0200

; Define constants
CR = $0D
LF = $0A
MAX_SONGS = 5
MAX_TITLE_LENGTH = 20

; Define variables
song_count = $00
song_index = $01
buffer = $02
title_buffer = $20
songs:
    .block MAX_SONGS
    .text ""
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .endblock

display_menu:
    lda #'='
    jsr put_char
    lda #'='
    jsr put_char
    lda #'='
    jsr put_char
    lda #' Music Playlist Manager '
    jsr put_string
    lda #'='
    jsr put_char
    lda #'='
    jsr put_char
    lda #'='
    jsr put_char
    lda #CR
    jsr put_char
    lda #'1' ; Add song
    ldx #0
    jsr put_option
    lda #'2' ; Delete song
    ldx #1
    jsr put_option
    lda #'3' ; Display playlist
    ldx #2
    jsr put_option
    lda #'4' ; Exit
    ldx #3
    jsr put_option
    lda #'='
    jsr put_char
    lda #'='
    jsr put_char
    lda #'='
    jsr put_char
    lda #CR
    jsr put_char
    rts

put_option:
    sta buffer
    lda buffer
    jsr put_char
    lda #'.'
    jsr put_char
    lda #CR
    jsr put_char
    lda buffer
    lda #LF
    jsr put_char
    rts

put_char:
    sta $600
    .byte $8D
    lda $FF01
    .byte $60
    rts

put_string:
    stx buffer
put_string_loop:
    lda buffer,x
    beq put_string_done
    jsr put_char
    inx
    bne put_string_loop
put_string_done:
    rts

load_title:
    ldx #0
load_title_loop:
    lda $600,x
    beq load_title_done
    sta title_buffer,x
    inx
    bne load_title_loop
load_title_done:
    rts

add_song:
    lda song_count
    cmp #MAX_SONGS
    beq add_song_full
    lda #'*'
    jsr put_char
    lda #' Enter song title: '
    jsr put_string
    jsr load_title
    lda song_count
    asl
    tax
    lda buffer
    sta songs,x
    lda #$00
    sta songs+1,x
    lda #CR
    jsr put_char
    clc
    lda song_count
    adc #1
    sta song_count
add_song_done:
    lda #CR
    jsr put_char
    rts

add_song_full:
    lda #'*'
    jsr put_char
    lda #' Playlist is full. Delete a song to add a new one.'
    jsr put_string
    lda #CR
    jsr put_char
    rts

delete_song:
    lda #'*'
    jsr put_char
    lda #' Enter song index to delete: '
    jsr put_string
    lda buffer
    clc
    asl
    tax
    lda songs+1,x
    beq delete_song_error
    lda #'-'
    jsr put_char
    lda songs,x
    ldy #0
delete_song_shift:
    lda songs,x
    sta songs,y
    lda songs+1,x
    sta songs+1,y
    inx
    iny
    lda songs,y
    bne delete_song_shift
    lda #$00
    sta songs,y
    lda #CR
    jsr put_char
    lda song_count
    sec
    sbc #1
    sta song_count
    rts

delete_song_error:
    lda #'*'
    jsr put_char
    lda #' Invalid song index.'
    jsr put_string
    lda #CR
    jsr put_char
    rts

display_playlist:
    lda #'*'
    jsr put_char
    lda #' Playlist:'
    jsr put_string
    lda #CR
    jsr put_char
    lda #LF
    jsr put_char
    ldx #0
display_playlist_loop:
    lda songs,x
    beq display_playlist_done
    jsr put_string
    jsr put_char
    inx
    jmp display_playlist_loop
display_playlist_done:
    lda #CR
    jsr put_char
    rts

main:
    jsr display_menu
    lda buffer
    cmp #'1'
    beq add_song
    lda buffer
    cmp #'2'
    beq delete_song
    lda buffer
    cmp #'3'
    beq display_playlist
    lda buffer
    cmp #'4'
    beq exit_program
    rts

exit_program:
    rts

.end
