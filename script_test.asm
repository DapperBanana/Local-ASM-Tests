
    ORG $0200

; Define memory locations for user input and output
input_buffer EQU $FB
output_buffer EQU $FC

; Define memory locations for storing user posts
post_1 EQU $100
post_2 EQU $120

START:
    LDA #$00           ; Initialize index for post storage
    STA $FE
    STA $FF

LOOP:
    ; Print menu options
    LDA #'1'
    JSR PRINT_CHAR
    LDA #'.' 
    JSR PRINT_CHAR
    LDA #' Post a message'
    JSR PRINT_STRING
    LDA #$0D        ; Carriage return
    JSR PRINT_CHAR
    LDA #'2'
    JSR PRINT_CHAR
    LDA #'.' 
    JSR PRINT_CHAR
    LDA #' View posts'
    JSR PRINT_STRING
    LDA #$0D        ; Carriage return
    JSR PRINT_CHAR
    LDA #'3'
    JSR PRINT_CHAR
    LDA #'.' 
    JSR PRINT_CHAR
    LDA #' Exit'
    JSR PRINT_STRING
    LDA #$0D        ; Carriage return
    JSR PRINT_CHAR

    ; Get user input
    LDA #'>' 
    JSR PRINT_CHAR
    JSR GET_USER_INPUT

    ; Check user input and perform corresponding action
    CMP #'1'
    BEQ POST_MESSAGE
    CMP #'2'
    BEQ VIEW_POSTS
    CMP #'3'
    BEQ EXIT

    JMP LOOP        ; Invalid input, go back to main menu

POST_MESSAGE:
    LDA #'>' 
    JSR PRINT_CHAR
    JSR GET_USER_INPUT

    ; Determine where to store the post
    LDA $FE
    CMP #$01
    BEQ STORE_POST_2

STORE_POST_1:
    STA post_1, X
    INX
    LDA $FE
    STA $FE
    JMP LOOP

STORE_POST_2:
    STA post_2, X
    INX
    LDA $FF
    STA $FF
    JMP LOOP

VIEW_POSTS:
    LDA #0
    STA $FE
    STA $FF

    LDA #'.' 
    JSR PRINT_CHAR
    LDA #' Post 1: '
    JSR PRINT_STRING
    JSR PRINT_POST_1

    LDA #'.' 
    JSR PRINT_CHAR
    LDA #' Post 2: '
    JSR PRINT_STRING
    JSR PRINT_POST_2

    JMP LOOP

EXIT:
    RTS

PRINT_POST_1:
    LDA post_1, X
    BEQ END_PRINT
    JSR PRINT_CHAR
    INX
    JMP PRINT_POST_1

END_PRINT:
    RTS

PRINT_POST_2:
    LDA post_2, X
    BEQ END_PRINT
    JSR PRINT_CHAR
    INX
    JMP PRINT_POST_2

PRINT_CHAR:
    STA output_buffer
    LDA #$FF
    JSR $FFD2
    RTS
    
PRINT_STRING:
    LDX #0
LOOP_PRINT_STRING:
    LDA output_buffer, X
    BEQ END_LOOP_PRINT_STRING
    JSR PRINT_CHAR
    INX
    JMP LOOP_PRINT_STRING

END_LOOP_PRINT_STRING:
    RTS

GET_USER_INPUT:
    LDX #0
LOOP_GET_USER_INPUT:
    JSR $FFD9
    CMP #$0D
    BEQ END_LOOP_GET_USER_INPUT
    STA input_buffer, X
    INX
    JMP LOOP_GET_USER_INPUT

END_LOOP_GET_USER_INPUT:
    RTS

    JMP START
