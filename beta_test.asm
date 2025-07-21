
START:  LDX #0        ; Initialize index register X
        LDY #0        ; Initialize index register Y
        LDA TITLE_PTR ; Load address of movie titles
        STA TITLE     ; Store address of movie titles in TITLE
SELECT: LDX #0        ; Reset index register X
PROMPT: LDA PROMPT,X  ; Load prompt message
        STA MESSAGE,X ; Store prompt message in MESSAGE buffer
        INX            ; Increment index register X
        CPX #5         ; Check if all prompts displayed
        BEQ RECOMMEND  ; If all prompts displayed, go to recommend
        JMP PROMPT     ; Otherwise, display next prompt
RECOMMEND:
        LDA RECOMMENDATION,Y ; Load movie recommendation
        STA MESSAGE,X         ; Store movie recommendation in MESSAGE buffer
        LDA TITLE,Y            ; Load movie title
        STA MOVIE_TITLE        ; Store movie title in MOVIE_TITLE buffer
        INX                    ; Increment index register X
        INY                    ; Increment index register Y
        CPY #3                 ; Check if all recommendations displayed
        BEQ END                ; If all recommendations displayed, end program
        JMP RECOMMEND          ; Otherwise, display next recommendation
END:    BRK                    ; End program

PROMPT: .ASC "What genre do you prefer? (1. Action, 2. Comedy, 3. Drama, 4. Science Fiction, 5. Horror) " 
RECOMMENDATION: .ASC "You may enjoy watching " 
TITLE_PTR: .WORD TITLE       ; Address of movie titles
TITLE: .BYTE "Die Hard", "Superbad", "The Shawshank Redemption", "Blade Runner", "The Shining"
MESSAGE: .BLKW 100           ; Buffer for storing messages
MOVIE_TITLE: .BLKW 20        ; Buffer for storing movie title
