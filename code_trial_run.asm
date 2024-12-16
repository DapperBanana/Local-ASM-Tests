
; check if the given string is a valid URL

       .org $0200    ; Start address

STRING .byte 'h','t','t','p',':','/','/','w','w','w','.','e','x','a','m','p','l','e','.','c','o','m','$'
LENGTH = * - STRING
RESULT .byte 0

       ldx #0       ; Initialize index register
LOOP   lda STRING, x ; Load character from string
       beq VALID_URL ; Check if end of string
       cmp #'a'     ; Check if character is lowercase letter
       bcc NOT_VALID ; If less than 'a', not a valid URL
       cmp #'z'     ; Check if character is lowercase letter
       bcc VALID_CHAR ; If less than 'z', it's a valid character
       cmp #'A'     ; Check if character is uppercase letter
       bcc NOT_VALID ; If less than 'A', not a valid URL
       cmp #'Z'     ; Check if character is uppercase letter
       bcc VALID_CHAR ; If less than 'Z', it's a valid character
       cmp #'0'     ; Check if character is a number
       bcc NOT_VALID ; If less than '0', not a valid URL
       cmp #'9'     ; Check if character is a number
       bcc VALID_CHAR ; If less than '9', it's a valid character
       cmp #'.'     ; Check if character is a period
       beq VALID_CHAR ; If period, it's a valid character
       cmp #':'     ; Check if character is a colon
       beq VALID_CHAR ; If colon, it's a valid character
       cmp #'/'     ; Check if character is a forward slash
       beq VALID_CHAR ; If forward slash, it's a valid character
       jmp NOT_VALID ; Otherwise, not a valid URL

VALID_CHAR 
       inx          ; Increment index register
       jmp LOOP     ; Continue checking characters

VALID_URL
       lda #1
       sta RESULT

NOT_VALID
       sta RESULT   ; Store result as not valid URL

       lda RESULT   ; Load result
       jsr $ffd2    ; Output result

       rts          ; Done

       .end
