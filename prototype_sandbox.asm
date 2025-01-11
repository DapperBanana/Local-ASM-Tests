
.org $2000

; Fantasy Sports Manager
START:
    LDX #0          ; Initialize player score to 0
    STX PLAYER_SCORE
    JSR PRINT_INTRO
    JSR MAIN_MENU
    
    BRA END         ; End program

PRINT_INTRO:
    LDA #<INTRO_MSG
    STA MSG_PTR
    LDA #>INTRO_MSG
    STA MSG_PTR+1
    JSR PRINT_MSG
    RTS

MAIN_MENU:
    LDA #<MENU_MSG
    STA MSG_PTR
    LDA #>MENU_MSG
    STA MSG_PTR+1
    JSR PRINT_MSG
    
    LDA #0
    JSR READ_INPUT
    
    CMP #1       ; Check user input
    BEQ PLAY_GAME
    CMP #2
    BEQ SHOW_SCORE
    CMP #3
    BEQ EXIT
    
    JSR INVALID_INPUT
    JMP MAIN_MENU
    
PLAY_GAME:
    JSR GENERATE_SCORE
    JSR ADD_SCORE
    JMP MAIN_MENU
    
SHOW_SCORE:
    JSR PRINT_SCORE
    JMP MAIN_MENU
    
EXIT:
    RTS

READ_INPUT:
    JSR $FFCF          ; Input a character
    CMP #13            ; Check for new line
    BEQ END_READ_INPUT
    STA TEMP
    JSR $FFE4          ; Output the character
    INX
    STA BUFFER,X
    JMP READ_INPUT

END_READ_INPUT:
    LDX #0
    LDA BUFFER,X
    RTS

INVALID_INPUT:
    LDA #<INVALID_MSG
    STA MSG_PTR
    LDA #>INVALID_MSG
    STA MSG_PTR+1
    JSR PRINT_MSG
    RTS

PRINT_MSG:
    LDY #0
PRINT_CHAR:
    LDA (MSG_PTR),Y
    BEQ END_PRINT_MSG
    JSR $FFD2
    INY
    JMP PRINT_CHAR
    
END_PRINT_MSG:
    RTS

GENERATE_SCORE:
    LDX #0
    LDA RANDOM_DATA,X   ; Get random value from data table
    STA SCORE
    RTS

ADD_SCORE:
    CLC
    LDA PLAYER_SCORE
    ADC SCORE
    STA PLAYER_SCORE
    RTS

PRINT_SCORE:
    LDA #<SCORE_MSG
    STA MSG_PTR
    LDA #>SCORE_MSG
    STA MSG_PTR+1
    JSR PRINT_MSG
    
    LDA PLAYER_SCORE
    JSR PRINT_INT
    RTS

; Data Section
INTRO_MSG:
    .ASC "Welcome to Fantasy Sports Manager!\n"
    .BYTE 0
    
MENU_MSG:
    .ASC "\n1. Play Game\n2. Show Score\n3. Exit\n"
    .BYTE 0
    
INVALID_MSG:
    .ASC "Invalid input. Please try again.\n"
    .BYTE 0

SCORE_MSG:
    .ASC "\nYour current score is: "
    .BYTE 0
    
BUFFER:
    .BLKW 20
    
MSG_PTR:
    .WORD 0
PLAYER_SCORE:
    .BYTE 0
SCORE:
    .BYTE 0
    
RANDOM_DATA:
    .BYTE $01, $02, $03, $04, $05, $06, $07

    .END
