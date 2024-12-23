
        .org $8000

BUFFER  .rs 16       ; buffer to store input string
MSG     .asciiz "Enter credit card number: "
MSG_ERROR .asciiz "Invalid credit card number"
MSG_VALID .asciiz "Valid credit card number"

START   lda #<BUFFER   ; load buffer address to X register
        ldx #>BUFFER
        ldy #16        ; set counter to 16 characters
        jsr ENTER_STR  ; call subroutine to get input string
        
CHECK   lda BUFFER, Y  ; load next character from buffer
        cmp #'0'       ; check if character is a digit
        bcc INVALID    ; if not a digit, credit card number is invalid
        cmp #'9'
        bcs INVALID
        dey             ; decrement counter
        bne CHECK       ; continue checking characters
        
VALID   lda #<MSG_VALID ; load message for valid credit card number
        ldx #>MSG_VALID
        jsr PRINT_MSG

DONE    rts

INVALID lda #<MSG_ERROR ; load message for invalid credit card number
        ldx #>MSG_ERROR
        jsr PRINT_MSG
        jmp DONE

ENTER_STR
        lda #<MSG        ; load message prompt
        ldx #>MSG
        jsr PRINT_MSG
        
        ldy #16         ; set counter to 16 characters
READ    jsr READ_CHAR   ; call subroutine to read a character from input
        sta BUFFER, Y   ; store character in buffer
        iny             ; increment index
        bne READ        ; continue reading characters
        rts

PRINT_MSG
        ; print message pointed to by X register
        ; contents of message are at address (X<<8) + Y
        lda (X), Y
        beq DONE        ; end of message, return
        jsr $ffd2       ; COUT
        iny
        jmp PRINT_MSG  ; continue printing message

READ_CHAR
        jsr $ffd5       ; CIN
        cmp #13         ; check for return key
        beq DONE        ; end of input string
        rts

        .end
