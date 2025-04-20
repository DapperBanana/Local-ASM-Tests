
START    LDX #0          ; Initialize index to 0

PRINT_MENU:
    LDA MENU, X      ; Load character from menu string
    BEQ END          ; If end of string, exit
    
    JSR $FFD2        ; Call KERNAL routine to print character
    INX              ; Increment index
    JMP PRINT_MENU   ; Continue printing menu

END     RTS

MENU     .ASC "Welcome to Movie Recommender!\n"
         .ASC "1. Action\n"
         .ASC "2. Comedy\n"
         .ASC "3. Drama\n"
         .ASC "4. Exit\n"
         .BYTE 0         ; Null terminator

; Main program loop
MAIN     JSR PRINT_MENU

         JSR $FFBD       ; Call KERNAL routine to read character
         CMP #'1'        ; Check user input
         BEQ ACTION
         CMP #'2'
         BEQ COMEDY
         CMP #'3'
         BEQ DRAMA
         CMP #'4'
         BNE MAIN

ACTION   LDA #"You should watch a thrilling action movie!\n"
         JSR $FFD2       ; Print recommendation
         JMP MAIN

COMEDY   LDA #"You should watch a hilarious comedy movie!\n"
         JSR $FFD2       ; Print recommendation
         JMP MAIN

DRAMA    LDA #"You should watch an emotional drama movie!\n"
         JSR $FFD2       ; Print recommendation
         JMP MAIN
