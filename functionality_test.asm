
        .org $0200

start   lda input_year     ; Load the input year
        sta year_upper     ; Store the upper nibble of the year
        lsr               ; Shift right to get the lower nibble
        sta year_lower     ; Store the lower nibble of the year
        
check_palindrome
        lda year_upper     ; Load the upper nibble
        cmp year_lower     ; Compare with the lower nibble
        bne not_palindrome  ; Branch if not equal
        
        lda temp           ; Load the temp value
        cmp #$0A           ; Compare with 10 (end of year)
        beq is_palindrome  ; Branch if equal
        
        inc year_lower     ; Increment the lower nibble
        dec year_upper     ; Decrement the upper nibble
        bne check_palindrome ; Branch to check again
        
is_palindrome
        lda #$01           ; Set the flag to 1 (palindrome)
        sta is_palindrome_
        rts
        
not_palindrome
        lda #$00           ; Set the flag to 0 (not palindrome)
        sta is_palindrome_
        rts
        
input_year .byte $20      ; Input year
year_upper .byte $00      ; Upper nibble of the year
year_lower .byte $00      ; Lower nibble of the year
temp      .byte $00       ; Temporary value
is_palindrome_ .byte $00  ; Flag to store the result

        .end
