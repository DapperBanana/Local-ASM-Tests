
       .org $0200

songs    .db "Bohemian Rhapsody",0
         .db "Stairway to Heaven",0
         .db "Hotel California",0
         .db "Imagine",0
         .db "Sweet Child o' Mine",0
         .db "Hey Jude",0
         .db "Smells Like Teen Spirit",0
         .db "Purple Haze",0
         .db "Born to Run",0
         .db "Thriller",0
         .db 0

playlist .ds 10

main:    
         lda #0
         sta $C000
         
         ldx #0
         
print_menu:
         lda #"1. Play next song"
         jsr print_string
         lda #"2. Add song to playlist"
         jsr print_string
         lda #"3. Display playlist"
         jsr print_string
         lda #"4. Exit"
         jsr print_string
         
get_choice:
         lda #"Enter your choice: "
         jsr print_string
         
         jsr read_input
         
         cmp #"1"
         beq play_next_song
         cmp #"2"
         beq add_to_playlist
         cmp #"3"
         beq display_playlist
         cmp #"4"
         beq exit_program
         jmp get_choice
         
play_next_song:
         lda playlist,x
         jsr print_string
         
         inx
         cpx #10
         bne print_menu
         rts
         
add_to_playlist:
         lda #"Enter song number to add: "
         jsr print_string
         
         jsr read_input
         clc
         adc #songs
         sta playlist,x
         
         inx
         cpx #10
         bne print_menu
         rts
         
display_playlist:
         ldx #0
         
display_song:
         lda playlist,x
         jsr print_string
         
         inx
         cpx #10
         bne display_song
         rts
         
exit_program:
         rts

print_string:
         ldx #0
print_char:
         lda (pointer),x
         beq end_print
         jsr $FFD2
         inx
         jmp print_char
         
end_print:
         rts

read_input:
         ldx #0
read_char:
         jsr $FFD7
         sta $C000,x
         inx
         cpx #10
         bne read_char
         rts

pointer:
         .dw 0

         .end
