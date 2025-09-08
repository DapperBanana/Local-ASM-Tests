
; Anagram Checker Program

        .org $0200
start
        ; Load address of string1 into X
        lda #<string1
        ldx #$00

loop1   ; Load character from string1 into A
        lda (X),y

        ; If end of string1, branch to check if both strings have equal length
        beq check_lengths

        ; Compare character with each character in string2
        lda #<string2
        ldx #$00

loop2   ; Load character from string2 into B
        lda (X),y

        ; Check if end of string2, branch to mismatch
        beq mismatch

        ; Compare characters
        cmp (X),y
        bne mismatch

        ; Increment X
        inx
        lda (X),y

        ; Increment X and branch back to loop2
        inx
        bne loop2

mismatch
        ; Strings are not anagrams
        lda #<not_anagram_message
        jsr print_string

        ; End program
        jmp end

check_lengths
        ; Check if both strings have the same length
        lda #<string2
        ldx #$00

check_length_loop
        lda (X),y

        ; Check if end of string2, branch to mismatch
        beq strings_equal

        ; Increment X
        inx
        beq check_lengths

strings_equal
        ; Strings have the same length, so they are anagrams
        lda #<anagram_message
        jsr print_string

end
        rts

print_string
        tya
print_loop
        lda (X),y
        beq return

        jsr $ffd2
        inx
        bne print_loop

return
        rts

string1
        .byte "listen",0
string2
        .byte "silent",0
anagram_message
        .byte "The strings are anagrams.",0
not_anagram_message
        .byte "The strings are not anagrams.",0

        .end start
