
; Anagram check program in 6502 Assembly

; Define constants
BUFFER_SIZE = 32

; Define memory locations
org $1000
str1: .byte "LISTEN",0
str2: .byte "SILENT",0
buffer: .byte BUFFER_SIZE,0

; Main program
start:
    lda #0             ; Initialize index
    sta $00
    
check_next_char:
    lda str1, x        ; Load character from first string
    sta buffer, x      ; Store character in buffer
    lda str2, x        ; Load character from second string
    sta buffer+BUFFER_SIZE, x  ; Store character in buffer
    
    inx                ; Increment index
    cpx BUFFER_SIZE    ; Check if end of strings
    bne check_next_char
    
    ; Sort characters in buffer
    jsr bubble_sort
    
    ; Compare sorted strings
    lda #0
compare_chars:
    lda buffer, x
    cmp buffer+BUFFER_SIZE, x
    bne not_anagrams
    
    inx
    cpx BUFFER_SIZE
    bne compare_chars
    
    ; Strings are anagrams
    jsr print_anagrams
    jmp end

not_anagrams:
    jsr print_not_anagrams
    jmp end

bubble_sort:
    lda #0
outer_loop:
    lda #0
inner_loop:
    lda buffer, x
    cmp buffer+1, x
    bcc swap
    
    inx
    cpx BUFFER_SIZE-1
    bne inner_loop
    
    iny
    cpy BUFFER_SIZE-1
    bne outer_loop
    
swap:
    lda buffer, x
    sta buffer+1, x
    lda buffer+1, x
    sta buffer, x
    rts

print_anagrams:
    lda #<anagram_msg
    ldy #>anagram_msg
    jsr print_message
    rts

print_not_anagrams:
    lda #<not_anagram_msg
    ldy #>not_anagram_msg
    jsr print_message
    rts

print_message:
    sta $04
    sty $05
    ldy #0
print_loop:
    lda ($04), y
    beq end_print
    jsr $ffd2
    iny
    jmp print_loop

end_print:
    rts

anagram_msg: .byte "Strings are anagrams.", 0
not_anagram_msg: .byte "Strings are not anagrams.", 0

end:
    rts
