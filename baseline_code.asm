
; Rock-Paper-Scissors game in 6502 Assembly
; Player selects their move (Rock - 0, Paper - 1, Scissors - 2)
; Computer randomly generates its move
; Winner is determined based on the moves (Rock > Scissors, Scissors > Paper, Paper > Rock)

CIA1    = $dc00
PORTB   = $0002

START   LDX   #0
        STX   $00     ; Set Player's move to 0
        
        LDA   #$FF
        STA   CIA1+4   ; Disable interrupt
        
        JSR   GET_RANDOM ; Get random number
        AND   #$03      ; Mask the lower two bits to get a number between 0 and 2
        STA   $01       ; Store computer's move in memory location $01
        
        LDX   $00
        CPX   $01
        BEQ   DRAW      ; If player's move equals computer's move, it's a draw
        BEQ   COMPUTER_WIN ; Computer wins if Rock > Scissors, Scissors > Paper, Paper > Rock
        
PLAYER_WIN
        LDA   #0       ; Player wins message
        JSR   PRINT_TEXT
        
        JMP   ENDGAME   ; End the game
        
COMPUTER_WIN
        LDA   #1       ; Computer wins message
        JSR   PRINT_TEXT
        
        JMP   ENDGAME   ; End the game
        
DRAW
        LDA   #2       ; Draw message
        JSR   PRINT_TEXT
        
ENDGAME
        LDA   #$03
        STA   CIA1+4   ; Enable interrupt
        RTS

PRINT_TEXT
        STA   CIA1
        LDA   #<MESSAGE
        STA   CIA1+1
        LDA   #>MESSAGE
        STA   CIA1+2
        LDA   #12
        STA   CIA1+3
        RTS

GET_RANDOM
        LDA   #$24
        STA   $14
        LDA   #8
        STA   $15
        LDA   #2
        STA   $16
.Loop
        LDA   #$01
        STA   $19
        DEC   $19
        BNE   .Loop
        LDA   $12
        ROL   $12
        DEC   $15
        BNE   .Loop
        DEC   $14
        BNE   .Loop
        LDA   $12
        RTS

MESSAGE
        .BYTE "Player Wins!", 0
        .BYTE "Computer Wins!", 0
        .BYTE "It's a Draw!", 0
