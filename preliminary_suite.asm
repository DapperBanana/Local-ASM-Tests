
.org $0200

START:
    LDX #0          ; Initialize index for word selection
SELECT_WORD:
    LDA WORDS,X     ; Load word from words array
    STA CURRENT_WORD
    JSR RESET_GAME  ; Reset game state for new word
    JSR PRINT_DASHES ; Print dashes for each letter in word
WAIT_FOR_INPUT:
    JSR GET_INPUT   ; Get user input
    JSR CHECK_GUESS  ; Check if guess is correct
    JSR CHECK_GAME_STATUS ; Check if game is over
    BEQ SELECT_WORD      ; If game is over, start over with new word
    BRA WAIT_FOR_INPUT

; Subroutine to reset the game state for a new word
RESET_GAME:
    LDX #0
    STX GUESSES_LEFT
    STX CORRECT_GUESSES
    STX INCORRECT_GUESSES
    RTS

; Subroutine to print dashes for each letter in the word
PRINT_DASHES:
    LDX #0
PRINT_NEXT_DASH:
    LDA CURRENT_WORD,X
    BEQ DONE_PRINTING_DASHES
    CMP #' '
    BEQ SKIP_SPACE
    STA OUTPUT
    JSR PRINT_CHAR
    INX
    BRA PRINT_NEXT_DASH
SKIP_SPACE:
    INX
    BRA PRINT_NEXT_DASH
DONE_PRINTING_DASHES:
    RTS

; Subroutine to get user input
GET_INPUT:
    LDA #'?'
    JSR PRINT_CHAR
    LDA #0
    STA INPUT
GET_NEXT_KEY:
    JSR GET_KEY
    CMP #'A'
    BCC GET_NEXT_KEY
    CMP #'Z'
    BCS GET_NEXT_KEY
    STA INPUT
    RTS

; Subroutine to check if user guess is correct
CHECK_GUESS:
    LDX #0
CHECK_NEXT_LETTER:
    LDA CURRENT_WORD,X
    BEQ INCORRECT_GUESS
    CMP INPUT
    BNE CHECK_NEXT_LETTER
    INC CORRECT_GUESSES
    RTS
INCORRECT_GUESS:
    INC INCORRECT_GUESSES
    DEC GUESSES_LEFT
    RTS

; Subroutine to check game status
CHECK_GAME_STATUS:
    LDA GUESSES_LEFT
    BEQ GAME_OVER
    LDX #0
CHECK_WORD_COMPLETE:
    LDA CURRENT_WORD,X
    BEQ INCREMENT_X
    CMP #' '
    BEQ INCREMENT_X
    LDX CORRECT_GUESSES
    CMP X
    BNE RESET_GAME
    INX
    BRA CHECK_WORD_COMPLETE
INCREMENT_X:
    INC X
    BRA CHECK_WORD_COMPLETE

GAME_OVER:
    LDA #'Y'
    JSR PRINT_CHAR
    RTS

; Subroutine to print a character
PRINT_CHAR:
    JSR $FFD2
    RTS

; Get key routine
GET_KEY:
    LDA $C000
    CMP $C000
    BEQ GET_KEY
    RTS

WORDS:
    .byte "HELLO",0
    .byte "WORLD",0

OUTPUT: .byte 0
CURRENT_WORD: .byte 0
INPUT: .byte 0
GUESSES_LEFT: .byte 0
CORRECT_GUESSES: .byte 0
INCORRECT_GUESSES: .byte 0

