
start:
    ldx #0           ; Initialize index to 0
    ldy #0           ; Initialize index to 0
    
check_palindrome:

    lda input_string, y  ; Load character from the beginning
    cmp #0               ; Check if it is null terminator
    beq palindrome_found ; If null terminator reached, string is a palindrome
    iny               ; Increment Y index
    
reverse_string:
    lda input_string, y  ; Load character from the end of string
    cmp #0               ; Check if it is null terminator
    beq palindrome_found ; If null terminator reached, string is a palindrome
    iny               ; Increment Y index
    dey               ; Decrement Y index
    lda input_string, y  ; Load character from the beginning
    
    cmp input_string, x  ; Compare characters
    bne not_palindrome    ; If characters are not equal, string is not a palindrome
    inx                  ; Increment X index
    iny                  ; Increment Y index
    jmp reverse_string    ; Repeat until end of string is reached

not_palindrome:
    jsr not_palindrome_message ; Print "Not a palindrome" message
    lda #0                   ; Exit program
    rts

palindrome_found:
    jsr palindrome_message   ; Print "Palindrome" message
    lda #0                   ; Exit program
    rts

input_string:
    .asciiz "racecar"  ; Change the string to be checked here

not_palindrome_message:
    .asciiz "Not a palindrome\n"

palindrome_message:
    .asciiz "Palindrome\n"

