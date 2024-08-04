
    PROGRAM: COUNT_VOWELS
    ; Count the number of vowels in a given string
    ;
    ; Input: A null-terminated string in memory
    ; Output: The number of vowels in the string stored in X register
    
    ORG $1000          ; Start address of program memory
    
    STRING EQU $2000   ; Memory location where the string is stored
    
    LDA #0            ; Initialize counter for vowels
    STA $00
    
LOOP: LDA STRING, X  ; Load character from string
    BEQ END         ; If reached end of string, exit loop
    
    CMP #'A'        ; Compare with 'A'
    BCC CONSONANT   ; Branch if character is before 'A'
    CMP #'Z'        ; Compare with 'Z'
    BCS CONSONANT   ; Branch if character is after 'Z'
    
    CMP #'E'
    BEQ IS_VOWEL
    CMP #'I'
    BEQ IS_VOWEL
    CMP #'O'
    BEQ IS_VOWEL
    CMP #'U'
    BEQ IS_VOWEL
    CMP #'a'
    BEQ IS_VOWEL
    CMP #'e'
    BEQ IS_VOWEL
    CMP #'i'
    BEQ IS_VOWEL
    CMP #'o'
    BEQ IS_VOWEL
    CMP #'u'
    BEQ IS_VOWEL
    
CONSONANT: INX             ; Increment index to next character
    JMP LOOP        ; Continue looping
    
IS_VOWEL: INC $00         ; Increment vowel counter
    INX             ; Increment index to next character
    JMP LOOP        ; Continue looping
    
END: LDX $00            ; Load number of vowels into X register
    RTS              ; Return from subroutine
