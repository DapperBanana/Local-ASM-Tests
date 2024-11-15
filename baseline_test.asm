
    .org $0200

start:
    ldx #0           ; Initialize index
    ldy #0           ; Initialize length counter
    ldi #0           ; Initialize result pointer

loop:
    lda str, x       ; Load character from string
    beq end          ; If end of string, exit loop

    jmp check_odd    ; Check for odd-length palindromes
    jmp check_even   ; Check for even-length palindromes

check_odd:
    ldy #1           ; Initialize length of palindrome
    lda str, x       ; Load first character in palindrome
    tax              ; Save start index
    jsr expand_odd   ; Expand palindrome
    jmp update_result

expand_odd:
    cmp str, x       ; Compare characters on both sides
    bne expand_end   ; If not equal, end expansion
    inx              ; Move to next character
    ldy ldy + #2     ; Increment length counter
    iny              ; Increment length counter
    bne expand_odd   ; Continue expanding

expand_end:
    rts              ; Return from subroutine

check_even:
    ldy #2           ; Initialize length of palindrome

update_result:
    cpx #0           ; If palindrome is longer than current result
    bcc next         ; Skip update
    sty result       ; Update result pointer
    lda ldy          ; Update result length
    sta result + #1

next:
    inx              ; Move to next character
    bne loop         ; Loop

end:
    rts              ; Return from program

str:
    .byte "abacabadaba", 0

result:
    .byte 0           ; Pointer to start of palindrome
    .byte 0           ; Length of palindrome
