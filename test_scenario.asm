
    .org $8000

start:
    lda $1000   ; Load the address of the first string
    sta $01     ; Store it in memory location $01
    lda $2000   ; Load the address of the second string
    sta $02     ; Store it in memory location $02

check_length:
    lda ($01),x ; Load a character from the first string
    beq check_anagram ; If it's NULL, go to check_anagram
    inx          ; Increment index register X
    jmp check_length ; Repeat until end of string

check_anagram:
    lda ($02),x ; Load a character from the second string
    beq compare_strings ; If it's NULL, go to compare_strings
    inx          ; Increment index register X
    jmp check_anagram ; Repeat until end of string

compare_strings:
    lda $01     ; Load the address of the first string
    ldx #$00    ; Reset index register X
loop:
    lda ($01),x ; Load a character from the first string
    cmp ($02),x ; Compare it with a character from the second string
    bne not_anagram ; If they're not equal, strings are not anagrams
    inx          ; Increment index register X
    beq strings_match ; If we've reached the end of the string, strings are anagrams
    jmp loop     ; Repeat until end of string

not_anagram:
    lda #$00    ; Set flag to indicate strings are not anagrams
    jmp end

strings_match:
    lda #$01    ; Set flag to indicate strings are anagrams

end:
    rts         ; Return from subroutine
