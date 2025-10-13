
    .org $0200          ; Start address of program
    
string_start:
    .byte "abccba",0   ; Input string, ending with null terminator
    .byte 0
    
start:
    ldx #0              ; Initialize index to 0
    ldy #1              ; Initialize length to 1
    lda string_start,x  ; Load character at index x
    
check_palindrome:
    cmp #0              ; Check for null terminator
    beq end            ; If end of string, exit
    
    ldx #1              ; Initialize inner index
    lda string_start,x  ; Load next character
    
    cmp #0              ; Check for end of string
    beq end            ; If end of string, exit
    
    jsr expand_palindrome ; Check for palindrome
    
    jmp check_palindrome ; Continue checking remaining string
    
expand_palindrome:
    ldy #1              ; Initialize length to 1
    
expand_loop:
    lda string_start,x  ; Load character at index x
    
    cmp #0              ; Check for end of string
    beq end            ; If end of string, exit
    
    cmp string_start,y  ; Compare current character to previous character
    
    bne check_longest   ; If not equal, check if current palindrome is longest
    
    inx                ; Increment index
    iny                ; Increment length
    
    jmp expand_loop      ; Continue expanding palindrome
    
check_longest:
    cpy longest_length  ; Compare current length to longest length
    
    bcc end            ; If current length is less than longest length, exit
    
    sty longest_length  ; Update longest length
    sty longest_index   ; Update longest index
    
    rts                 ; Return from subroutine
    
end:
    rts                 ; End of program
    
longest_length:
    .byte 0              ; Global variable to store length of longest palindrome
    
longest_index:
    .byte 0              ; Global variable to store index of longest palindrome
