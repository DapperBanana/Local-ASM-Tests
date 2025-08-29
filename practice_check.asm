
.START
    LDA #0      ; Initialize accumulator
    STA score    ; Initialize score variable
    
    LDA #0      ; Initialize accumulator
    STA teams    ; Initialize teams variable
    
    JSR printMenu   ; Print main menu
    
mainLoop:
    JSR getInput    ; Get user input
    
    CMP #'1'       ; Compare user input with option 1
    BEQ addTeam     ; If equal, add team
    CMP #'2'       ; Compare user input with option 2
    BEQ viewTeams   ; If equal, view teams
    CMP #'3'       ; Compare user input with option 3
    BEQ endProgram  ; If equal, end program

    JMP mainLoop    ; Repeat main loop

addTeam:
    INC teams      ; Increment number of teams
    JSR printAddTeam   ; Print add team message
    JSR getInput       ; Get team name input
    JSR printTeamAdded ; Print team added message
    JMP mainLoop       ; Return to main menu

viewTeams:
    JSR printTeamsHeader ; Print teams header
    LDX #0              ; Initialize index for team names
    
printTeamLoop:
    LDA teamsNames, X   ; Load team name
    JSR printString     ; Print team name
    INX                 ; Increment index
    CPX teams           ; Compare index with number of teams
    BNE printTeamLoop   ; If not equal, repeat loop
    
    JMP mainLoop        ; Return to main menu

endProgram:
    RTS          ; End program

printMenu:
    LDA #0xA     ; Load carriage return character
    JSR printChar    ; Print new line
    LDA #0xD     ; Load line feed character
    JSR printChar    ; Print new line
    LDA #"1"    ; Load option 1
    JSR printChar    ; Print option 1
    LDA printAddTeamMessage  ; Load add team message
    JSR printString  ; Print add team message
    
    LDA #"2"      ; Load option 2
    JSR printChar    ; Print option 2
    LDA printViewTeamsMessage  ; Load view teams message
    JSR printString  ; Print view teams message
    
    LDA #"3"      ; Load option 3
    JSR printChar    ; Print option 3
    LDA printEndProgramMessage  ; Load end program message
    JSR printString  ; Print end program message
    
    RTS          ; End subroutine

printChar:
    STA $400     ; Store accumulator in screen buffer
    INC $401     ; Increment screen buffer pointer
    RTS          ; End subroutine

printString:
    LDX #0       ; Initialize index
    
printStringLoop:
    LDA (text), X   ; Load character from text
    BEQ printStringEnd ; If end of string, exit loop
    
    JSR printChar    ; Print character
    INX             ; Increment index
    JMP printStringLoop ; Repeat loop
    
printStringEnd:
    RTS          ; End subroutine

getInput:
    LDX #0       ; Initialize index
    LDA #0       ; Initialize accumulator
    
getInputLoop:
    JSR readChar     ; Read user input
    CMP #0xD         ; Compare input with carriage return
    BEQ getInputEnd  ; If equal, exit loop
    
    STA input, X     ; Store input in buffer
    INX              ; Increment index
    JMP getInputLoop  ; Repeat loop
    
getInputEnd:
    RTS          ; End subroutine

readChar:
    LDA $401     ; Load cursor position
    BPL readChar  ; Wait for user input
    LDA $C000    ; Read user input
    RTS          ; End subroutine

score: .BYTE 0  ; Variable to store score
teams: .BYTE 0  ; Variable to store number of teams
input: .BLOCK 10  ; Buffer to store user input
teamsNames: .BLOCK 20  ; Buffer to store team names

text:
    .BYTE "1 - Add Team", 0
    .BYTE "2 - View Teams", 0
    .BYTE "3 - End Program", 0
    .BYTE 0
printAddTeamMessage: .BYTE "Enter team name: ", 0
printViewTeamsMessage: .BYTE "Team List: ", 0
printEndProgramMessage: .BYTE "Exiting program...", 0
