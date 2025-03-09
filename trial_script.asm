
; Simulated Social Media Platform

        .org    $0800        ; Start address of the program

        LDX     #$FF         ; Initialize message count
        STX     messageCount

main:
        JSR     displayMenu   ; Display menu options
        JSR     getUserInput  ; Get user input
        CMP     #'1'          ; Check user input
        BEQ     postMessage   ; Branch if user wants to post a message
        CMP     #'2'          ; Check user input
        BEQ     viewPosts     ; Branch if user wants to view posts
        CMP     #'3'          ; Check user input
        BEQ     likePost      ; Branch if user wants to like a post
        CMP     #'4'          ; Check user input
        BEQ     commentPost   ; Branch if user wants to comment on a post
        JMP     main          ; Return to main if invalid input

postMessage:
        JSR     clearScreen   ; Clear screen
        LDX     messageCount
        INX                   ; Increment message count
        STX     messageCount
        LDA     #'@'          ; Print user name
        JSR     printChar
        LDA     #':'          ; Print message prompt
        JSR     printChar
        JSR     getUserInput  ; Get user message
        LDX     messageCount  ; Load message count
        TXA                   ; Copy message count to X register
        LDA     messageBuffer,X ; Load character from message buffer
        JSR     printChar     ; Print character
        DEX                   ; Decrement X register
        BNE     $FD           ; Repeat until X equals 0
        JMP     main          ; Return to main menu

viewPosts:
        JSR     clearScreen   ; Clear screen
        LDX     messageCount
        CPX     #$FF          ; Check if there are messages to display
        BEQ     main          ; Return to main menu if no messages
        LDX     #$00          ; Initialize message index
loop:
        LDA     messageBuffer,X ; Load character from message buffer
        JSR     printChar     ; Print character
        INX                   ; Increment message index
        CPX     messageCount  ; Compare message index to message count
        BNE     loop          ; Repeat until all messages are displayed
        JMP     main          ; Return to main menu

likePost:
        JSR     clearScreen   ; Clear screen
        LDA     #':'
        JSR     printChar     ; Print like prompt
        JMP     main          ; Return to main menu

commentPost:
        JSR     clearScreen   ; Clear screen
        LDA     #':'
        JSR     printChar     ; Print comment prompt
        JMP     main          ; Return to main menu

clearScreen:
        LDA     #$0C          ; Clear screen code
        STA     $D020         ; Store in screen memory
        RTS                   ; Return from subroutine

displayMenu:
        LDA     #':'
        JSR     printChar     ; Print menu prompt
        LDA     #'1'
        JSR     printChar     ; Print post message option
        LDA     #'2'
        JSR     printChar     ; Print view posts option
        LDA     #'3'
        JSR     printChar     ; Print like post option
        LDA     #'4'
        JSR     printChar     ; Print comment post option
        RTS                   ; Return from subroutine

getUserInput:
        JSR     getInput      ; Get user input
        RTS                   ; Return from subroutine

printChar:
        STA     $D020         ; Store character in screen memory
        RTS                   ; Return from subroutine

getInput:
        JSR     $FFFE         ; System subroutine to get input
        RTS                   ; Return from subroutine

messageBuffer:
        .ds     256           ; Message buffer
messageCount:
        .byte   0             ; Message count

        .end                  ; End of program
