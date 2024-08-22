
        .org $0200          ; Start address

input_string .text "example@mail.com",0  ; Input string
at_symbol    .byte 64  ; ASCII code for "@"
dot_symbol   .byte 46  ; ASCII code for "."
valid_email  .byte 0   ; Flag to indicate if email is valid

        lda #<input_string  ; Load lower byte of input string address
        ldx #>input_string  ; Load higher byte of input string address
        jsr check_at_symbol  ; Check if "@" symbol is present
        bne invalid_email    ; Branch to invalid_email if not found

        lda #<input_string  ; Load lower byte of input string address
        ldx #>input_string  ; Load higher byte of input string address
        jsr check_dot_symbol  ; Check if "." symbol is present
        bne invalid_email    ; Branch to invalid_email if not found

        lda #<input_string  ; Load lower byte of input string address
        ldx #>input_string  ; Load higher byte of input string address
        jsr check_domain_name  ; Check if domain name is valid
        bne invalid_email    ; Branch to invalid_email if not valid

valid_email:
        lda #1             ; Set flag to indicate valid email
        jmp end_program    ; Jump to end_program

invalid_email:
        lda #0             ; Set flag to indicate invalid email

end_program:
        rts                ; Return from subroutine

check_at_symbol:
        ldy #0             ; Initialize index
check_at_symbol_loop:
        lda (x),y          ; Load character from input string
        beq check_at_symbol_invalid  ; Branch if end of string
        cmp #at_symbol     ; Compare character with "@"
        beq check_at_symbol_found      ; Branch if matches
        iny                ; Increment index
        bne check_at_symbol_loop      ; Loop back

check_at_symbol_invalid:
        rts

check_at_symbol_found:
        rts

check_dot_symbol:
        lda #0             ; Initialize dot symbol found flag
check_dot_symbol_loop:
        lda (x),y          ; Load character from input string
        beq check_dot_symbol_invalid  ; Branch if end of string
        cmp #dot_symbol    ; Compare character with "."
        beq check_dot_symbol_found     ; Branch if matches
        iny                ; Increment index
        bne check_dot_symbol_loop     ; Loop back

check_dot_symbol_invalid:
        rts

check_dot_symbol_found:
        iny  ; Skip dot symbol
        lda (x),y  ; Load next character after dot
        cmp #0  ; Check for end of string
        beq check_dot_symbol_invalid  ; Branch if end of string
        rts

check_domain_name:
        ldy #0  ; Initialize index
check_domain_name_loop:
        lda (x),y  ; Load character from input string
        beq check_domain_name_valid  ; Branch if end of string
        cmp #46  ; Check if character is not alphanumeric
        bcc check_domain_name_invalid  ; Branch if less than dot symbol
        cmp #48  ; Check if character is alphanumeric
        bcc check_domain_name_invalid  ; Branch if less than "0"
        cmp #57  ; Check if character is alphanumeric
        bcs check_domain_name_loop  ; Loop back

check_domain_name_invalid:
        rts

check_domain_name_valid:
        rts

        .end
