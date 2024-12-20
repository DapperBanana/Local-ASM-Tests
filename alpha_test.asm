
; Assuming input string is stored in memory starting at address $6000
; Output will be stored in memory starting at address $7000

    .org $6000
input_string:   .byte "babad", 0 ; Input string
length:         .byte 5          ; Length of input string

    .org $7000
output_string:  .byte 0           ; Start of longest palindromic substring
output_length:  .byte 0           ; Length of longest palindromic substring

start:
    lda length     ; Load length of input string
    cmp #0         ; Compare with 0
    beq end        ; If length is 0, exit

    ldx #0         ; Initialize index for start of palindrome
    ldy #0         ; Initialize index for end of palindrome

next_palindrome:
    lda input_string, x   ; Load current character
    cmp #0                ; Check for end of string
    beq end_check         ; If end of string, check for end of program

    jsr expand_palindrome ; Check for even length palindrome
    jsr expand_palindrome ; Check for odd length palindrome

    inx                   ; Move to next character
    bne next_palindrome    ; Continue loop

end_check:
    lda output_length     ; Load length of longest palindrome
    cmp #0                ; Check if palindrome was found
    beq end               ; If not, exit program

    lda #0                ; Null-terminate output string
    sta output_string, y

end:
    rts

; Function to expand palindrome at a given index
expand_palindrome:
    ldx #0                   ; Initialize length of palindrome
next_char:
    lda input_string, x     ; Load character from input string
    cmp #0                  ; Check for end of string
    beq end_expand          ; If end of string, return

    cmp input_string, y     ; Compare with end of possible palindrome
    beq expand              ; If characters match, expand palindrome

    rts                     ; If characters don't match, return

expand:
    dey                     ; Move to previous character
    inx                     ; Move to next character
    bne next_char           ; Continue loop

end_expand:
    lda length              ; Load length of palindrome
    cmp output_length       ; Compare with current longest palindrome
    bcc update_output       ; If longer, update output

    rts

update_output:
    sta output_length       ; Update length of longest palindrome
    ldx #0                  ; Initialize index for longest palindrome
update_char:
    lda input_string, x     ; Load character from input string
    sta output_string, x    ; Store character in output string
    inx                     ; Move to next character
    lda input_string, x     ; Load next character
    cmp #0                  ; Check for end of string
    bne update_char         ; Continue loop

    rts
