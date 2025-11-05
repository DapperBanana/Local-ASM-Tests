
    .org $1000
    
str     .asciiz "Hello, World!"
str_end .byte 0
result  .byte 0

start:
    ldx #0                  ; Initialize index X to 0
    ldy #0                  ; Initialize index Y to 0
    
reverse_loop:
    lda str, y              ; Load a character from the original string
    beq end_reverse         ; If the character is 0, we are done
    
    iny                     ; Move to the next character in the original string
    jsr length_check        ; Check if we've reached the end of the string
    
    dey                     ; Move back to the last character in the original string
    sta result, x           ; Store the character in the result string
    
    inx                     ; Move to the next position in the result string
    bne reverse_loop        ; Repeat until the whole string is reversed
    
    bra end_reverse
    
length_check:
    lda str_end, y          ; Check if we've reached the end of the original string
    beq end_reverse         ; If the current character is 0, we are done
    rts
    
end_reverse:
    rts
    
    .end start
