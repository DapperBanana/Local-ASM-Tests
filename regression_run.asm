
        .org $0200   ; Start program at memory location $0200
        
player_choice = $C0    ; Memory location to store player's choice
computer_choice = $C1  ; Memory location to store computer's choice
result = $C2           ; Memory location to store result

START:
        JSR GET_PLAYER_CHOICE   ; Get player's choice
        JSR GET_COMPUTER_CHOICE ; Get computer's choice
        JSR DETERMINE_RESULT    ; Determine the result
        JSR DISPLAY_RESULT      ; Display the result
        BRK

GET_PLAYER_CHOICE:
        LDA #$00            ; Prompt player for choice
        JSR $FFD2           ; Print character
        LDA #$50            ; Prompt player to press 'R' for rock
        JSR $FFD2           ; Print character
        LDA #$41            ; Prompt player to press 'P' for paper
        JSR $FFD2           ; Print character
        LDA #$53            ; Prompt player to press 'S' for scissors
        JSR $FFD2           ; Print character
        LDA #$3A            ; Prompt player to enter choice ':'
        JSR $FFD2           ; Print character
        LDA #$20            ; Read player's choice
        JSR $FFD6           ; Read input character
        STA player_choice   ; Store player's choice
        RTS

GET_COMPUTER_CHOICE:
        LDA #$00            ; Generate random number between 0 and 2
        CLC
        ADC #$20
        AND #$03
        STA computer_choice ; Store computer's choice
        RTS

DETERMINE_RESULT:
        LDA player_choice     ; Load player's choice
        CMP computer_choice   ; Compare with computer's choice
        BEQ DRAW              ; If equal, it's a draw
        CMP #$52              ; Compare player's choice with 'R' for rock
        BEQ ROCK              ; If player chose rock, go to ROCK
        CMP #$50              ; Compare player's choice with 'P' for paper
        BEQ PAPER             ; If player chose paper, go to PAPER
        CMP #$53              ; Compare player's choice with 'S' for scissors
        BEQ SCISSORS          ; If player chose scissors, go to SCISSORS
        RTS

DRAW:
        LDA #$44            ; Display draw message
        JSR $FFD2           ; Print character
        LDA #$52
        JSR $FFD2           ; Print character
        JSR $FFD6           ; Read input character
        RTS

ROCK:
        LDA computer_choice   ; Load computer's choice
        CMP #$53              ; Compare with 'S' for scissors
        BEQ WIN               ; If computer chose scissors, player wins
        JMP LOSE              ; Otherwise, player loses

PAPER:
        LDA computer_choice   ; Load computer's choice
        CMP #$52              ; Compare with 'R' for rock
        BEQ WIN               ; If computer chose rock, player wins
        JMP LOSE              ; Otherwise, player loses

SCISSORS:
        LDA computer_choice   ; Load computer's choice
        CMP #$50              ; Compare with 'P' for paper
        BEQ WIN               ; If computer chose paper, player wins
        JMP LOSE              ; Otherwise, player loses

WIN:
        LDA #$57            ; Display win message
        JSR $FFD2           ; Print character
        LDA #$49
        JSR $FFD2           ; Print character
        JSR $FFD6           ; Read input character
        RTS

LOSE:
        LDA #$4C            ; Display lose message
        JSR $FFD2           ; Print character
        LDA #$4F
        JSR $FFD2           ; Print character
        JSR $FFD6           ; Read input character
        RTS

DISPLAY_RESULT:
        LDA result          ; Load result
        CMP #$57            ; Compare with 'W' for win
        BEQ WIN_MESSAGE      ; If win, display win message
        CMP #$4C            ; Compare with 'L' for lose
        BEQ LOSE_MESSAGE     ; If lose, display lose message
        CMP #$44            ; Compare with 'D' for draw
        BEQ DRAW_MESSAGE     ; If draw, display draw message
        RTS

WIN_MESSAGE:
        LDA #$59            ; Display "You win!"
        JSR $FFD2           ; Print character
        LDA #$6F
        JSR $FFD2           ; Print character
        JMP PLAY_AGAIN

LOSE_MESSAGE:
        LDA #$59            ; Display "You lose!"
        JSR $FFD2           ; Print character
        LDA #$6F
        JSR $FFD2           ; Print character
        JMP PLAY_AGAIN

DRAW_MESSAGE:
        LDA #$44            ; Display "It's a draw!"
        JSR $FFD2           ; Print character
        LDA #$72
        JSR $FFD2           ; Print character
        JSR $FFD6           ; Read input character
        JMP PLAY_AGAIN

PLAY_AGAIN:
        LDA #$0A            ; Prompt to play again ":"
        JSR $FFD2           ; Print character
        LDA #$50            ; Prompt to enter choice 'P' for play again
        JSR $FFD2           ; Print character
        LDA #$3A
        JSR $FFD2           ; Print character
        LDA #$20            ; Read input choice
        JSR $FFD6           ; Read input character
        CMP #$50            ; Compare with 'P' for play again
        BEQ START           ; If play again, start over
        RTS

        .end            ; End of program
