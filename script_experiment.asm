
.org $1000

START:  JSR INIT          ; Initialize the social media platform

MAIN:   LDA #MENU_PROMPT  ; Display menu prompt
        JSR PRINT_STRING
        
        LDA #0
        JSR GET_INPUT      ; Get user input
        
        CMP #1
        BEQ POST_MESSAGE    ; If user input is 1, go to post message
        CMP #2
        BEQ VIEW_FEED       ; If user input is 2, go to view feed
        CMP #3
        BEQ EXIT           ; If user input is 3, exit program
        JMP MAIN            ; If user input is invalid, go back to main menu

POST_MESSAGE:
        LDA #MESSAGE_PROMPT  ; Display message prompt
        JSR PRINT_STRING
        
        JSR GET_INPUT         ; Get user input for message
        
        JSR ADD_MESSAGE       ; Add message to feed
        JMP MAIN             ; Go back to main menu

VIEW_FEED:
        JSR DISPLAY_FEED      ; Display all messages in feed
        JMP MAIN              ; Go back to main menu

EXIT:
        BRK                  ; Exit program

INIT:
        LDX #0               ; Initialize feed pointer to 0
        
        LDA #0               ; Clear memory for feed
CLEAR_FEED:
        STA FEED,X
        INX
        CPX #FEED_SIZE
        BNE CLEAR_FEED
        
        RTS

GET_INPUT:
        JSR READ_INPUT        ; Read user input
        STA INPUT_BUFFER
        RTS

PRINT_STRING:
        LDX #0
PRINT_LOOP:
        LDA MESSAGE,X
        BEQ PRINT_DONE
        JSR PRINT_CHAR
        INX
        JMP PRINT_LOOP
        
PRINT_DONE:
        RTS

PRINT_CHAR:
        JSR $FFD2  ; Print character to screen
        RTS

READ_INPUT:
        JSR $FFCF  ; Read single character from keyboard
        RTS

ADD_MESSAGE:
        LDX #0
ADD_LOOP:
        LDA INPUT_BUFFER,X
        STA FEED,X
        INX
        CPX #FEED_SIZE
        BNE ADD_LOOP
        RTS

DISPLAY_FEED:
        LDX #0
DISPLAY_LOOP:
        LDA FEED,X
        BEQ DISPLAY_DONE
        JSR PRINT_CHAR
        INX
        JMP DISPLAY_LOOP
        
DISPLAY_DONE:
        RTS

; Constants
MENU_PROMPT: .text "1. Post a message\n2. View feed\n3. Exit\n\0"
MESSAGE_PROMPT: .text "Enter your message: \0"
FEED_SIZE: .equ 20

; Variables
INPUT_BUFFER: .ds 40
FEED: .ds FEED_SIZE

MESSAGE: .text "Hello, welcome to our social media platform!\0"
