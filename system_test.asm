
; Simple music playlist manager program in 6502 Assembly
; The program allows the user to add songs to a playlist, view the playlist, and play the songs

    .org $0200

start:
    LDA #0         ; Initialize index as 0
    STA index

menu:
    JSR displayMenu    ; Display menu options
    JSR getInput        ; Get user input
    CMP #$31           ; Check if user input is '1' (add song)
    BEQ addSong
    CMP #$32           ; Check if user input is '2' (view playlist)
    BEQ viewPlaylist
    CMP #$33           ; Check if user input is '3' (play songs)
    BEQ playSongs
    JMP menu

addSong:
    JSR clearScreen
    LDA index
    CLC
    ADC #$01          ; Increment index
    STA index
    LDX index        ; Load index into X
    LDA inputBuf,X   ; Load user input into A
    STA playlist,X   ; Add song to playlist
    JMP menu

viewPlaylist:
    JSR clearScreen
    LDA #0            ; Initialize index as 0
    STA index
    LDX index
printSongs:
    LDA playlist,X
    JSR printChar     ; Print song to screen
    INX
    CPX index
    BEQ menu         ; Return to main menu when done
    JMP printSongs

playSongs:
    JSR clearScreen
    LDA #0         ; Initialize index as 0
    STA index

    LDX index
playNext:
    LDA playlist,X
    JSR printChar     ; Print song to screen
    INX
    STA index
    LDY #10
    JSR delay         ; Delay before playing next song
    CPX index
    BEQ menu         ; Return to main menu when done
    JMP playNext

delay:
    DEX
    BNE delay
    RTS

printChar:
    STA $FE        ; Set I/O to current character
    RTS

displayMenu:
    LDX #0
    LDA #<menuText
    LDY #>menuText
    JSR displayString
    RTS

getInput:
    LDA #$FF      ; Load blank input buffer
    STA inputBuf,X
    TXA
    STA index

inputLoop:
    LDX index
    LDA $FE
    STA inputBuf,X
    CMP #$0D     ; Check for 'Enter' key press
    BEQ doneInput
    INX
    TXA
    STA index
    BNE inputLoop

doneInput:
    RTS

clearScreen:
    LDA #12         ; Clear screen
    JSR printChar
    LDA #13
    JSR printChar
    RTS

menuText:
    .text "Music Playlist Manager\n"
    .text "1. Add Song\n"
    .text "2. View Playlist\n"
    .text "3. Play Songs\n"
    .text "Select an option: "

playlist:
    .byte 0,0,0,0,0,0,0,0,0,0

index:
    .byte 0

inputBuf:
    .byte 0,0,0,0,0,0,0,0

    .end start
