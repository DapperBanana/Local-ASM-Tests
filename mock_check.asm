
.org $0200

loop:
    lda str,x
    beq end     ; If end of string reached, exit loop

    jsr find_palindrome       ; Find palindromic substring starting at current position

    inx         ; Move to next character
    jmp loop

find_palindrome:
    ldx #0      ; Initialize index for checking palindrome
    lda str,x
    beq end_palindrome       ; If end of string reached, exit palindrome check

loop_palindrome:
    cmp str,x    
    beq next_char       ; If characters match, continue checking palindromic substring
    inc x               ; Move to next character in substring
    lda str,x
    cmp str,x
    beq next_char
    rts                 ; If characters don't match, return from subroutine

next_char:
    inc x               ; Move to next character in substring
    lda str,x
    bne loop_palindrome      ; Continue checking palindrome if not end of string
    lda x
    rts                 ; Return from subroutine

end_palindrome:
    lda x
    rts

end:
    rts

str: .asciiz "abacddc"
