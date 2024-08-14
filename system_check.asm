
; Start address of program: $0200
        jmp start

string1 .asciiz "listen"
string2 .asciiz "silent"
result  .byte 0 ; 0 if not anagrams, 1 if anagrams

start:
        ldx #0 ; Initialize index for string comparison

compare_loop:
        lda string1, x ; Load character from string1
        cmp string2, x ; Compare character with corresponding character from string2
        bne not_anagrams ; Branch if characters are not equal

        inx ; Increment index
        cpx #6 ; Check if end of string is reached
        bne compare_loop

        lda #1 ; Set result to 1 (anagrams)
        sta result
        jmp end_program

not_anagrams:
        lda #0 ; Set result to 0 (not anagrams)
        sta result

end_program:
        ; End of program

        rts
