
        .org $0200

        LDX #$0B        ; Set initial number of incorrect guesses to 11
        LDY #$00        ; Initialize index for correct guesses
        LDY #$0C        ; Initialize index for incorrect guesses

main    LDA word, Y     ; Load the correct letter from the word
        BEQ end_game    ; If end of word is reached, end the game
        STA display, Y  ; Store the correct letter in the display
        INY             ; Increment index for correct guesses

        LDA #$20        ; Load the space character
        STA display, Y  ; Store space in the display
        INY             ; Increment index for correct guesses

        JMP main        ; Repeat the process for the next letter

end_game
        LDA #$00        ; Load the null character
        STA display, Y  ; Store null to terminate the display

loop    LDA prompt      ; Display the prompt
        JSR $FFD2       ; Call Kernal routine for output
        LDA display     ; Load the display buffer
        JSR $FFD2       ; Call Kernal routine for output
        LDX #$01        ; Set initial index for player input
        LDA input, X    ; Load player input
        BEQ loop        ; If player input is zero, loop back to prompt

        CMP word, X     ; Compare player input with the word
        BNE decrement   ; If incorrect, decrement number of incorrect guesses

        LDA input, X    ; Load player input
        STA display, X  ; Display player input in the display
        INX             ; Move to next character in display

        LDA word, X     ; Load correct letter from the word
        BEQ victory     ; If end of word is reached, player has guessed the word
        JMP loop        ; Repeat the process for the next letter

decrement
        DEX             ; Decrement index for incorrect guesses
        BNE loop        ; Repeat the loop if incorrect guesses remain

defeat  LDA defeat_msg  ; Display defeat message
        JSR $FFD2       ; Call Kernal routine for output
        JMP $FFA0       ; End program

victory LDA victory_msg ; Display victory message
        JSR $FFD2       ; Call Kernal routine for output
        JMP $FFA0       ; End program

word    .byte "HANGMAN", $00
display .byte "-------", $00
input   .byte $00
prompt  .byte "Enter a letter: "
defeat_msg .byte "You've run out of guesses. Game over.", $00
victory_msg .byte "Congratulations, you've guessed the word!", $00

        .org $FFA0
        JMP $FFA0
