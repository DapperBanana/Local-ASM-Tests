
; Hangman game in 6502 Assembly

        .org $0200

start   LDX #0              ; initialize X to use as index for secret word
        LDY #0              ; initialize Y for incorrect guesses counter
        STY INCORRECT       ; store in memory
        JSR PRINTBLANKS     ; print blank spaces for secret word
        JSR PRINTGUESS      ; print message for guessing a letter
        LDA #0
        STA CORRECT         ; store correct guesses counter in memory
        JSR GETINPUT        ; get user input
        JSR CHECKGUESS      ; check if guess is correct
check   JSR CHECKWIN        ; check if the game is won
        BEQ check           ; if game is not won, keep playing
        JMP WIN             ; if game is won, go to win message


; subroutine to print blank spaces for secret word
PRINTBLANKS
        LDX #0
print   LDA BLANK
        STA DISPLAY,X
        INX
        CPX #WORD_SIZE
        BNE print
        RTS

; subroutine to print message for guessing a letter
PRINTGUESS
        LDX #0
print   LDA GUESS
        STA DISPLAY,X
        INX
        CPX #MESSAGE_SIZE
        BNE print
        RTS

; subroutine to get user input
GETINPUT
        JSR GETCHAR
        STA GUESSCHAR
        RTS

; subroutine to check if guess is correct
CHECKGUESS
        LDX #0
check   LDA SECRET_WORD,X
        CMP GUESSCHAR
        BEQ correct
        INX
        CPX #WORD_SIZE
        BNE check
incorrect
        LDY INCORRECT
        INY
        STY INCORRECT
        JMP wrong
correct LDA CORRECT
        INX
        STA CORRECT
        JSR UPDATEWORD
        RTS

; subroutine to check if game is won
CHECKWIN
        LDA CORRECT
        CMP #WORD_SIZE
        RTS

; subroutine for wrong guess
WRONG
        LDX INCORRECT
        CPX #MAX_GUESSES
        BCC continue
        JMP LOSE

continue
        JSR PRINTGUESS
        JSR GETINPUT
        JMP CHECKGUESS

; subroutine to update word display with correct guess
UPDATEWORD
        LDX #0
replace LDA SECRET_WORD,X
        CMP GUESSCHAR
        BEQ copy
        STA DISPLAY,X
copy    INX
        CPX #WORD_SIZE
        BNE replace
        RTS

; subroutines not shown for GETCHAR, WIN, LOSE

; Constants
BLANK       .BYTE ' '
GUESS       .BYTE "Guess a letter: "
SECRET_WORD .BYTE "HANGMAN"
WORD_SIZE   = * - SECRET_WORD
MESSAGE_SIZE = 14
GUESSCHAR   .BYTE 0
DISPLAY     .BLKB WORD_SIZE
CORRECT     .BYTE 0
INCORRECT   .BYTE 0
MAX_GUESSES = 6

        .org $FFFC
        .WORD start
