
; Hangman Game

        .org $0200               ; Start program at memory address $0200
        
start
        LDA #0                   ; Initialize variables
        STA gameState           ; Game state: 0 = playing, 1 = win, 2 = lose
        STA guessCount          ; Number of incorrect guesses
        LDA #$0D
        STA correctLetter        
        LDX #0
        LDA #27                  ; Set up word to be guessed
        STA wordIndex
        
initWord
        LDA wordData, X
        STA word, X              ; Copy word to memory
        INX
        CPX #27
        BNE initWord
        
        LDA #$20                 ; Set space character for hidden word
        LDX #0
        
        LDA word, X
        BEQ playGame            ; Check if end of string
        CMP #$20
        BEQ skipBlank
        
        STA hiddenWord, X        ; Initialize hidden word
        INC wordIndex            ; Move to next letter
        INX
        BNE initWord
        
skipBlank

        INC wordIndex            ; Move to next letter
        INX
        BNE initWord

        
playGame
        LDX #0
        LDA #0
        STA guessCount
        
printHiddenWord
        LDA hiddenWord, X
        BEQ getPlayerInput
        JSR $FFD2                ; Print character on screen
        INX
        JMP printHiddenWord
        
getPlayerInput
        LDA #'?'
        JSR $FFD2                ; Print question mark on screen
        
readInput
        LDA $FF00                ; Read user input
        CMP #$41
        BCC readInput
        CMP #$5A   
        BCS readInput
        STA playerGuess
        LDA playerGuess
        JSR checkGuess
        
checkGuess
        LDX #0
        
checkLoop
        LDA word, X
        CMP playerGuess
        BEQ correctGuess
        INX
        CPX #27
        BNE checkLoop
        JSR handleIncorrectGuess
        
correctGuess
        LDA playerGuess
        STA correctLetter
        LDX #0
        
replaceLetter
        LDA word, X
        CMP playerGuess
        BNE continueReplace
        STA hiddenWord, X
        
continueReplace
        INX
        CPX #27
        BNE replaceLetter
        
        LDX #0
        LDA #0
        CMP correctLetter
        BEQ printHiddenWord
        JMP playGame
        
handleIncorrectGuess
        INC guessCount
        CMP #6
        BEQ gameOver
        
        JMP playGame
        
gameOver
        LDA #2
        STA gameState
        JMP endGame
        
endGame
        LDA gameState
        CMP #1
        BEQ winGame
        
        LDA #27
        LDX #0
        
clearScreen
        LDA #$20
        JSR $FFD2
        
        INX
        CPX #27
        BNE clearScreen
        
        LDA #27
        LDX #0
        STA wordIndex
        
        JMP start
        
winGame
        LDA wordIndex
        CMP #27
        BEQ playAgain
        
        JMP clearScreen
        
playAgain
        LDA #0
        STA wordIndex
        JMP start

; Data Section

wordData
        .byte "HANGMANISFUN", $00

; Variables

hiddenWord
        .BLKW 27
word
        .BLKW 27
playerGuess .BYTE 0
gameState   .BYTE 0
guessCount  .BYTE 0
wordIndex   .BYTE 27
correctLetter  .BYTE 0

        .end
