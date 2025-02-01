
    ; 6502 Assembly program to count the number of vowels in a given string
    
    .org $0200        ; Set memory address to $0200
    LDA $0301         ; Load the address of the input string
    LDY #$00          ; Initialize Y register for counting vowels
    LDX #$00          ; Initialize X register for looping through the string
    
check_vowel:
    LDA ($0300),X     ; Load character from the input string into A
    CMP #$41          ; Compare A with 'A'
    BCC not_upper     ; Branch if A is not an uppercase letter
    CMP #$5A          ; Compare A with 'Z'
    BCC is_vowel      ; Branch if A is an uppercase letter
    
not_upper:
    CMP #$61          ; Compare A with 'a'
    BCC not_lower     ; Branch if A is not a lowercase letter
    CMP #$7A          ; Compare A with 'z'
    BCS not_vowel     ; Branch if A is not a lowercase vowel
    
is_vowel:
    CMP #$41          ; Compare A with 'A'
    BCS count_vowel   ; Branch if A is an uppercase vowel
    
not_lower:
    CMP #$61          ; Compare A with 'a'
    BCC not_vowel     ; Branch if A is not a lowercase vowel
    
count_vowel:
    INY               ; Increment the Y register count of vowels
    
not_vowel:
    INX               ; Increment the X register for next character
    CPX #$FF          ; Compare X with FF
    BNE check_vowel   ; Branch if we haven't reached end of string
    
    STY $0302         ; Store the number of vowels in memory location $0302
    RTS               ; Return from subroutine
