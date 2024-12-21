
    .org $0200          ; Set starting address
    .byte $78,$A2,$00   ; Initialize X register to zero
    .byte $9A,$D8       ; Initialize Y register to FF

PlayNextSong:
    LDA Playlist,X      ; Load the next song ID from the playlist into the A register
    BEQ EndOfPlaylist   ; If the song ID is zero, end of playlist
    JMP PlaySong        ; Jump to PlaySong subroutine

EndOfPlaylist:
    RTS                 ; Return from subroutine

PlaySong:
    STA CurrentSong     ; Store the current song ID in CurrentSong variable
    JSR GetSongLength   ; Jump to GetSongLength subroutine
    LDA SongLength      ; Load the song length into A register
    JSR PlaySongLength  ; Jump to PlaySongLength subroutine
    INX                 ; Increment X register to play the next song
    JMP PlayNextSong    ; Jump back to PlayNextSong subroutine

GetSongLength:
    LDA SongTable,Y     ; Load the song length from SongTable into A register
    STA SongLength      ; Store the song length in SongLength variable
    RTS                 ; Return from subroutine

PlaySongLength:
    LDA SongLength      ; Load the song length into A register
    SEC
    SBC #$01            ; Subtract 1 from the song length
    STA SongLength      ; Update the song length variable
    BEQ EndOfSong       ; If song length is zero, end of song
    JMP PlaySongLength  ; Jump back to PlaySongLength subroutine

EndOfSong:
    RTS                 ; Return from subroutine

Playlist:
    .byte $01,$02,$03,$00  ; Playlist with song IDs, 00 marks end of playlist

SongTable:
    .byte $10,$15,$20       ; Song lengths in seconds
CurrentSong:
    .byte $00               ; Current song ID
SongLength:
    .byte $00               ; Song length

    .end
