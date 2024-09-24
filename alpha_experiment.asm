
* = $6000

; Constants
PLAYLIST_SIZE = 8

; Variables
playlist .dsb PLAYLIST_SIZE
index = $80
input_buffer .dsb 20

; Entry point
start:
    lda #$0
    sta index

main_loop:
    jsr display_menu
    jsr get_input
    jsr process_input

    jmp main_loop

; Display menu options
display_menu:
    lda #13
    jsr print_char

    lda #"1"
    jsr print_char
    lda #"." 
    jsr print_char
    lda " Add song"
    jsr print_string

    lda #13
    jsr print_char

    lda #"2"
    jsr print_char
    lda ". Play"
    jsr print_string

    lda #13
    jsr print_char

    rts

; Get user input
get_input:
    ldx #0
    lda #11 ; CR
    sta input_buffer, x
    inx

read_next_char:
    jsr get_char
    sta input_buffer, x
    inx
    cmp #13 ; CR
    bne read_next_char

    lda #"0"
    sta input_buffer, x
    rts

; Process user input
process_input:
    lda input_buffer
    cmp #"1"
    beq add_song

    lda input_buffer
    cmp #"2"
    beq play_playlist

    rts

add_song:
    jsr input_song
    
    lda index
    cmp PLAYLIST_SIZE
    bcs playlist_full
    
    sta playlist, x
    inx
    inc index
    rts

input_song:
    lda #13
    jsr print_char
    lda "Enter song name: "
    jsr print_string

    ldx #0
    lda #11 ; CR
    sta input_buffer, x
    inx

read_next_song_char:
    jsr get_char
    sta input_buffer, x
    inx
    cmp #13 ; CR
    bne read_next_song_char

    lda #"0"
    sta input_buffer, x

    rts

playlist_full:
    lda #13
    jsr print_char

    lda "Playlist is full!"
    jsr print_string

    lda #13
    jsr print_char

    rts

play_playlist:
    lda #13
    jsr print_char
    lda "Playing playlist:"
    jsr print_string

    lda #13
    jsr print_char

loop_playlist:
    lda playlist, x
    jsr print_string

    lda #13
    jsr print_char

    inx
    lda index
    cmp x
    bne loop_playlist

    rts

; Helper functions

; Print a character
print_char:
    sta $2000
    rts

; Print a null-terminated string
print_string:
loop:
    lda (input_buffer), x
    beq end_string
    jsr print_char
    inx
    jmp loop

end_string:
    rts

; Get a character from input
get_char:
    lda $2001
    rts
