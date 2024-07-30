
; Music Playlist Manager

.music_start:
    LDX #0          ; Initialize index to 0
.loop:
    LDA music_list,X    ; Load the address of the song into the accumulator
    BEQ .end            ; If end of the list is found, exit the loop
    JSR print_song      ; Print the song name
    INX                 ; Increment index to point to the next song
    JMP .loop           ; Continue looping

.end:
    RTS

print_song:
    LDA #<song_name     ; Load Low byte of song_name address into accumulator
    STA song_ptr        ; Store it in song_ptr
    LDA #>song_name     ; Load High byte of song_name address into accumulator
    STA song_ptr+1      ; Store it in song_ptr+1
    JSR print_string    ; Print the song name
    RTS

print_string:
    LDY #0
.loop:
    LDA (song_ptr),Y    ; Load the character at song_ptr+Y into accumulator
    BEQ .end_string     ; If end of string is reached, exit the loop
    JSR print_char      ; Print the character
    INY                 ; Move to the next character
    JMP .loop           ; Continue looping

.end_string:
    RTS

print_char:
    ; Print the character in the accumulator
    ; This can be implemented based on the specific output device (e.g. screen, printer) and its corresponding routines

; Define the music list (addresses of song names)
.music_list:
    .byte song_1
    .byte song_2
    .byte 0              ; End of list marker

; Define the song names
.song_1:
    .text "Song 1"
    .byte 0

.song_2:
    .text "Song 2"
    .byte 0

.song_ptr:
    .word 0              ; Pointer to current song name

; Initialize program
    JMP .music_start
