
        .org $1000

START   lda #<INPUT          ; Load low byte of input string address into A
        ldx #>INPUT          ; Load high byte of input string address into X
        ldy #0               ; Initialize index counter to 0

LOOP    lda (X),Y            ; Load character into A
        cmp #0               ; Check for end of string
        beq END              ; Branch to end if end of string found

        cmp #32              ; Check for space character
        beq INVALID          ; Branch to invalid if space found

        cmp #65              ; Check if character is in range A-Z
        bcc INVALID          ; Branch to invalid if character is not in range A-Z

        cmp #122             ; Check if character is in range a-z
        bcs VALID_CHAR       ; Branch to valid_char if character is in range a-z

        cmp #48              ; Check if character is in range 0-9
        bcc INVALID          ; Branch to invalid if character is not in range 0-9

VALID_CHAR
        iny                  ; Increment index counter
        jmp LOOP             ; Continue checking next character

INVALID lda #<NOT_VALID     ; Load low byte of invalid message address into A
        ldx #>NOT_VALID     ; Load high byte of invalid message address into X
        jsr PRINT_MESSAGE    ; Print invalid message
        jmp END              ; End program

END     rts                  ; Return from program

PRINT_MESSAGE
        lda (X),Y            ; Load character from message into A
        beq DONE             ; Branch to done if end of message found
        jsr $FFD2            ; Call KERNAL routine to print character
        iny                  ; Increment index counter
        jmp PRINT_MESSAGE    ; Continue printing characters

DONE    rts                  ; Return from subroutine

INPUT   .byte "www.example.com",0  ; Input string
NOT_VALID .byte "Invalid URL",0    ; Invalid message

        .end
