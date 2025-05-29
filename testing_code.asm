
; Hangman game program in 6502 Assembly

        .org $0200
start   lda #<hangmanText
        ldy #>hangmanText
        jsr $ffd2  ; Print string at address loaded in A and Y

main    lda #<guessText
        ldy #>guessText
        jsr $ffd2

        lda #<secretWord
        ldy #>secretWord
        jsr $ffd2

        ldx #0  ; Initialize index for the guessed word
        ldy #0  ; Initialize index for the secret word

inputLoop
        lda #$9b ; Get user input
        jsr $ffd2

        cmp #$8d ; Check if the user pressed 'Enter'
        beq checkGuess

        sta guessBuffer, x
        inx
        jmp inputLoop

checkGuess
        lda guessBuffer, 0 ; Get the first character of the guess
        tax

        lda secretWord, y
        cmp #0 ; Check if we reached the end of the secret word
        beq win

        cmp tax ; Check if the guess matches the character
        beq correctGuess

        jmp wrongGuess

correctGuess
        lda tax
        ldx #0
        jsr $ffd2

        lda secretWord, y
        jsr $ffd2

        jsr $ffd2
        iny
        jmp main

wrongGuess
        lda #<wrongText
        ldy #>wrongText
        jsr $ffd2
        ldx #0
        jsr $ffd2
        iny
        jmp main

win
        lda #<winText
        ldy #>winText
        jsr $ffd2
        jmp $ff48 ; End program

guessBuffer .ds 16

hangmanText .byte "Welcome to Hangman!", $0d, $0a, $00
guessText   .byte "Guess a letter: ", $00
secretWord  .byte "HELLO", $00
wrongText   .byte "Wrong guess.", $0d, $0a, $00
winText     .byte "Congratulations! You guessed the word.", $0d, $0a, $00

        .end
