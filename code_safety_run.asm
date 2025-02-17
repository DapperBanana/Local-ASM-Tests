
        .text
        .org $C000

start:  SEI               ; Disable interrupts
        LDA #$FF           ; Set stack pointer
        TAY
        TXS

        JSR init          ; Initialize game
        JSR drawHangman   ; Draw initial state of hangman
        JSR drawWord      ; Draw initial empty word
        JSR getInput      ; Prompt user for input

play:   JSR checkLetter   ; Check if input letter is in the word
        BEQ endGame       ; If not found, go to end game
        JSR drawWord      ; If found, draw updated word
        JSR checkVictory   ; Check if player has won
        BEQ victory       ; If player has won, go to victory
        JSR drawHangman    ; Draw hangman
        JSR getInput       ; Prompt user for input
        JMP play          ; Repeat until game is over

victory:JSR clearScreen
        LDX #0
        LDA message,X
        BEQ endGame
        JSR $FDED
        INX
        JMP victory

endGame:LDA #$FF           ; End game
        STX $D019          ; Clear screen
        STX $D018          ; Disable cursor
        JMP $FFD2          ; Return from program

init:   LDA #$00           ; Initialize variables
        STA tries
        LDA #$00
        STA guessed
        LDA #$0A
        STA hangmanPos

        LDA #<wordList
        STA wordListPtr
        LDA #>wordList
        STA wordListPtr+1

        LDA #$00
        STA randomSeed
        RTS

drawHangman:
        LDA #$1F           ; Load address of hangman graphics
        STA $0400
        LDA #$24
        STA $0401
        LDA #$00
        STA $0402
        LDA #$0F
        STA $0403
        LDA #$21
        STA $0404
        LDA #$0F
        STA $0405
        LDA #$20
        STA $0406
        RTS

drawWord:
        LDA #$20          ; Load blank space
        STA $0407

        LDX #$01          ; Draw word space by space
drawLoop:
        LDA (currentWord),X
        BEQ drawDone
        STA $0408,X
        INX
        JMP drawLoop

drawDone:
        RTS

getInput:
        JSR $FD00       ; Get input from user
        STA letter
        RTS

checkLetter:
        LDX #$00        ; Check if letter is in word
checkLoop:
        LDA (currentWord),X
        BEQ checkDone
        CMP letter
        BEQ letterFound
        INX
        JMP checkLoop

letterFound:
        BIT (wordPos),X
        BVS checkDone
        LDA letter
        STA (wordPos),X
        JMP letterAdded

checkDone:
        LDA hangmanPos
        STA Y
        LDA #$10
        STX X
        LDX $0407,X
        BIT #$20
        BEQ drawDone
        LDA #$10
        STX $0406
        ADC #$06
        STA $0406

letterAdded:
        RTS

checkVictory:
        LDX #$00       ; Check if word is solved
checkVictoryLoop:
        LDA (currentWord),X
        BEQ checkVictoryDone
        CMP (wordPos),X
        BNE notYet
        INX
        JMP checkVictoryLoop

notYet:
        LDA #$00
        RTS

checkVictoryDone:
        LDA #$01
        RTS

clearScreen:
        SEI
        LDX #$00
clearLoop:
        LDA #$00
        STA $0400,X
        INX
        BNE clearLoop
        PLP
        RTS

random:
        LDA randomSeed    ; Pseudo-random number generator
        ROR
        ROR
        ROR
        ROR
        ROR
        EOR randomSeed
        STA randomSeed
        RTS

wordList:
        .byte "HANGMAN", 0
        .byte "COMPUTER", 0
        .byte "PROGRAM", 0

currentWord:
        .byte 0

wordPos:
        .byte 0

tries:
        .byte 0

guessed:
        .byte 0

hangmanPos:
        .byte 0

randomSeed:
        .byte 0

message:
        .byte "Congratulations! You won!", 0
