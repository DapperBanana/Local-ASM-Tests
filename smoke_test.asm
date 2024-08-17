
        .org $0200
start   lda #0            ; Initialize variables
        sta counter
        lda #0
        sta index
        lda #0
        sta num
        lda #0
        sta temp

        ldx #5            ; Set counter to check 5 digits

loop    lda input, x      ; Load input number
        sta num           ; Store input number in num
        lda num           ; Load input number
        sta temp          ; Copy input number to temp
        inx               ; Increment index
        cpx #10           ; Check if all digits are checked
        bne loop

check   lda input, index  ; Load input number from index
        sta num           ; Store input number in num
        lda num           ; Load input number
        cmp temp          ; Compare input number with temp
        bne notPalindrome ; If not equal, not palindrome
        inx               ; Increment index
        dex               ; Decrement counter
        bne check         ; Continue checking

        lda #$FF          ; Set flag for palindrome
        jmp end

notPalindrome
        lda #0            ; Reset flag for not palindrome

end     sta $0201         ; Store result in memory

        rts

input   .byte $12, $34, $56, $34, $12  ; Input number to check
counter .byte 0
index   .byte 0
num     .byte 0
temp    .byte 0

        .end
