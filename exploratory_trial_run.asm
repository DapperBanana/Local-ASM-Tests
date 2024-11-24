
; Text-based Music Playlist Manager
; Description: This program allows the user to manage a playlist of music tracks by adding, deleting, and displaying tracks.

; Constants
FILENAME = $00 ; Start of the filename buffer
MAX_FILENAME_LENGTH = 20 ; Maximum filename length

; Variables
buffer = $0200 ; Memory buffer for input
playlist = $0300 ; Memory buffer for storing playlist
current_track = $0400 ; Pointer to the current track in the playlist

; Entry point
start:
    lda #$00
    sta current_track

; Main loop
main_loop:
    lda #<prompt
    ldx #>prompt
    jsr print_string

    lda #<menu
    ldx #>menu
    jsr print_string

    jsr get_input

    cmp #'1'
    beq add_track
    cmp #'2'
    beq delete_track
    cmp #'3'
    beq display_playlist
    cmp #'4'
    beq exit_program

    jmp main_loop

; Add a track to the playlist
add_track:
    lda #<add_prompt
    ldx #>add_prompt
    jsr print_string

    jsr get_input

    lda current_track
    sta playlist, x
    inx
    sta current_track

    jmp main_loop

; Delete a track from the playlist
delete_track:
    lda #<delete_prompt
    ldx #>delete_prompt
    jsr print_string

    jsr get_input

    lda current_track
    dex
    sta current_track
    lda playlist, x
    sta playlist, x

    jmp main_loop

; Display the playlist
display_playlist:
    lda #<playlist_prompt
    ldx #>playlist_prompt
    jsr print_string

    ldx current_track
    lda playlist, x
    jsr print_char

    dex
    cpx #$00
    bne display_playlist

    lda #<end_of_playlist
    ldx #>end_of_playlist
    jsr print_string

    jmp main_loop

; Exit the program
exit_program:
    rts

; Subroutines
print_char:
    sta buffer
    ldy #1
    lda (buffer), y
    beq end_print_char

    jsr $fdd1 ; KERNAL routine to print character
    inc buffer
    jmp print_char

end_print_char:
    rts

print_string:
    sta buffer
loop_print_string:
    lda (buffer), y
    beq end_print_string

    jsr $fdd5 ; KERNAL routine to print string
    inc buffer
    jmp loop_print_string

end_print_string:
    rts

get_input:
    ldx #0
get_char:
    jsr $ffd2 ; KERNAL routine to get input
    sta buffer, x
    jsr print_char

    cmp #$0d ; Check for Enter key
    beq end_get_input

    inx
    jmp get_char

end_get_input:
    rts

; Data section
prompt: .byte "Menu:", $00
menu: .byte "1. Add track", $0d, "2. Delete track", $0d, "3. Display playlist", $0d, "4. Exit", $00
add_prompt: .byte "Enter track:", $00
delete_prompt: .byte "Enter track to delete:", $00
playlist_prompt: .byte "Playlist:", $0d, $00
end_of_playlist: .byte "End of playlist", $00

; Initialize memory
    .org $0110
    .word start
    .org buffer
    .ds MAX_FILENAME_LENGTH
    .org playlist
    .ds 10
    .org current_track
    .byte $00
