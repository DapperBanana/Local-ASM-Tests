
        .org $0200
        
start   LDX #3      ; Set initial spaceship health to 3
        STX health
        
        LDA #0      ; Set initial score to 0
        STA score
        
        JSR printIntro
        
gameLoop
        JSR printOptions
        
        JSR getInput
        CMP #'1'
        BEQ level1
        CMP #'2'
        BEQ level2
        CMP #'3'
        BEQ level3
        
        JMP gameLoop
        
level1
        JSR printLevel1
        DEC health     ; Decrease health by 1 for level 1
        
        JMP checkGameOver
        
level2
        JSR printLevel2
        INC score      ; Increase score by 1 for level 2
        
        JMP gameLoop
        
level3
        JSR printLevel3
        DEC health     ; Decrease health by 1 for level 3
        
        JMP checkGameOver
        
checkGameOver
        LDA health
        BEQ gameover   ; If health is 0, go to gameover
        
        JMP gameLoop
        
gameover
        JSR printGameOver
        
        RTS
        
printIntro
        LDA #'W'
        JSR $FFD2     ; Print character 'W'
        
        LDA #'e'
        JSR $FFD2     ; Print character 'e'
        
        LDA #'l'
        JSR $FFD2     ; Print character 'l'
        
        LDA #'c'
        JSR $FFD2     ; Print character 'c'
        
        LDA #'o'
        JSR $FFD2     ; Print character 'o'
        
        LDA #'m'
        JSR $FFD2     ; Print character 'm'
        
        LDA #'e'
        JSR $FFD2     ; Print character 'e'
        
        LDA #' '
        JSR $FFD2     ; Print space character
        
        LDA #'t'
        JSR $FFD2     ; Print character 't'
        
        LDA #'o'
        JSR $FFD2     ; Print character 'o'
        
        LDA #' '
        JSR $FFD2     ; Print space character
        
        LDA #'t'
        JSR $FFD2     ; Print character 't'
        
        LDA #'h'
        JSR $FFD2     ; Print character 'h'
        
        LDA #'e'
        JSR $FFD2     ; Print character 'e'
        
        LDA #' '
        JSR $FFD2     ; Print space character
        
        LDA #'s'
        JSR $FFD2     ; Print character 's'
        
        LDA #'p'
        JSR $FFD2     ; Print character 'p'
        
        LDA #'a'
        JSR $FFD2     ; Print character 'a'
        
        LDA #'c'
        JSR $FFD2     ; Print character 'c'
        
        LDA #'e'
        JSR $FFD2     ; Print character 'e'
        
        LDA #' '
        JSR $FFD2     ; Print space character
        
        LDA #'g'
        JSR $FFD2     ; Print character 'g'
        
        LDA #'a'
        JSR $FFD2     ; Print character 'a'
        
        LDA #'m'
        JSR $FFD2     ; Print character 'm'
        
        LDA #'e'
        JSR $FFD2     ; Print character 'e'
        
        LDA #'!'
        JSR $FFD2     ; Print character '!'
        
        RTS
        
printOptions
        LDA #'1'
        JSR $FFD2     ; Print character '1'
        
        LDA #'.'
        JSR $FFD2     ; Print character '.'
        
        LDA #' '
        JSR $FFD2     ; Print space character
        
        LDA #'F'
        JSR $FFD2     ; Print character 'F'
        
        LDA #'i'
        JSR $FFD2     ; Print character 'i'
        
        LDA #'g'
        JSR $FFD2     ; Print character 'g'
        
        LDA #'h'
        JSR $FFD2     ; Print character 'h'
        
        LDA #'t'
        JSR $FFD2     ; Print character 't'
        
        LDA #'!'
        JSR $FFD2     ; Print character '!'
        
        LDA #' '
        JSR $FFD2     ; Print space character
        
        LDA #'2'
        JSR $FFD2     ; Print character '2'
        
        LDA #'.'
        JSR $FFD2     ; Print character '.'
        
        LDA #' '
        JSR $FFD2     ; Print space character
        
        LDA #'D'
        JSR $FFD2     ; Print character 'D'
        
        LDA #'o'
        JSR $FFD2     ; Print character 'o'
        
        LDA #'d'
        JSR $FFD2     ; Print character 'd'
        
        LDA #'g'
        JSR $FFD2     ; Print character 'g'
        
        LDA #'e'
        JSR $FFD2     ; Print character 'e'
        
        LDA #'!'
        JSR $FFD2     ; Print character '!'
        
        LDA #' '
        JSR $FFD2     ; Print space character
        
        LDA #'3'
        JSR $FFD2     ; Print character '3'
        
        LDA #'.'
        JSR $FFD2     ; Print character '.'
        
        LDA #' '
        JSR $FFD2     ; Print space character
        
        LDA #'H'
        JSR $FFD2     ; Print character 'H'
        
        LDA #'i'
        JSR $FFD2     ; Print character 'i'
        
        LDA #'t'
        JSR $FFD2     ; Print character 't'
        
        LDA #'!'
        JSR $FFD2     ; Print character '!'
        
        RTS
        
printLevel1
        LDA #'L'
        JSR $FFD2     ; Print character 'L'
        
        LDA #'e'
        JSR $FFD2     ; Print character 'e'
        
        LDA #'v'
        JSR $FFD2     ; Print character 'v'
        
        LDA #'e'
        JSR $FFD2     ; Print character 'e'
        
        LDA #'l'
        JSR $FFD2     ; Print character 'l'
        
        LDA #' '
        JSR $FFD2     ; Print space character
        
        LDA #'1'
        JSR $FFD2     ; Print character '1'
        
        RTS
        
printLevel2
        LDA #'L'
        JSR $FFD2     ; Print character 'L'
        
        LDA #'e'
        JSR $FFD2     ; Print character 'e'
        
        LDA #'v'
        JSR $FFD2     ; Print character 'v'
        
        LDA #'e'
        JSR $FFD2     ; Print character 'e'
        
        LDA #'l'
        JSR $FFD2     ; Print character 'l'
        
        LDA #' '
        JSR $FFD2     ; Print space character
        
        LDA #'2'
        JSR $FFD2     ; Print character '2'
        
        RTS
        
printLevel3
        LDA #'L'
        JSR $FFD2     ; Print character 'L'
        
        LDA #'e'
        JSR $FFD2     ; Print character 'e'
        
        LDA #'v'
        JSR $FFD2     ; Print character 'v'
        
        LDA #'e'
        JSR $FFD2     ; Print character 'e'
        
        LDA #'l'
        JSR $FFD2     ; Print character 'l'
        
        LDA #' '
        JSR $FFD2     ; Print space character
        
        LDA #'3'
        JSR $FFD2     ; Print character '3'
        
        RTS
        
printGameOver
        LDA #'G'
        JSR $FFD2     ; Print character 'G'
        
        LDA #'a'
        JSR $FFD2     ; Print character 'a'
        
        LDA #'m'
        JSR $FFD2     ; Print character 'm'
        
        LDA #'e'
        JSR $FFD2     ; Print character 'e'
        
        LDA #' '
        JSR $FFD2     ; Print space character
        
        LDA #'O'
        JSR $FFD2     ; Print character 'O'
        
        LDA #'v'
        JSR $FFD2     ; Print character 'v'
        
        LDA #'e'
        JSR $FFD2     ; Print character 'e'
        
        LDA #'r'
        JSR $FFD2     ; Print character 'r'
        
        RTS
        
getInput
        JSR $FFCF     ; Read input from keyboard
        RTS
        
health  .BYTE 0
score   .BYTE 0
        
        .end
