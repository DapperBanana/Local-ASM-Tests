
; Program to check if a string is a valid JSON Web Token (JWT)
; The string is stored in the .text section

.segment .text
    lda #0 ; Set index to 0
    sta index

read_next_char:
    ; Load the current character into the accumulator
    lda str, x
    ; Check if end of string
    beq token_valid

    ; Check if character is alphanumeric or one of the JWT special characters
    cmp #32 ; Check for space character
    beq read_next_char

    cmp #46 ; Check for period character
    beq read_next_char

    cmp #95 ; Check for underscore character
    beq read_next_char

    cmp #45 ; Check for hyphen character
    beq read_next_char

    cmp #48 ; Check for 0 character
    bcc token_invalid

    cmp #57 ; Check for 9 character
    bcs check_uppercase

check_lowercase:
    cmp #97 ; Check for lowercase a character
    bcc token_invalid
    
    cmp #122 ; Check for lowercase z character
    bcs token_invalid

    jmp read_next_char ; Continue reading next character

check_uppercase:
    cmp #65 ; Check for uppercase A character
    bcc token_invalid

    cmp #90 ; Check for uppercase Z character
    bcs token_invalid

    jmp read_next_char ; Continue reading next character

token_invalid:
    lda #0 ; Set result to 0 for invalid token
    jmp end

token_valid:
    lda #1 ; Set result to 1 for valid token

end:
    ; Store the result in the variable isValid
    sta isValid

.segment .data
    .org 0x200
str: .asciiz "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkNoYWctSG9yaXpvbiIsInBpY1"
isValid: .byte 0 ; Variable to store the result of token validation
index: .byte 0 ; Variable to store the index of the current character in the string
