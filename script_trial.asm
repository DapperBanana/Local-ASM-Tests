
    .org $0200
    
    ; String to be counted
    STRING .asciiz "Hello, World!"
    
    ; Variables
    COUNT .byte 0
    
    ; Start of program
    LDX #$00         ; Initialize index register X
LOOP:
    LDA STRING, X   ; Load character from string into accumulator
    CMP #$00        ; Check if end of string (null terminator)
    BEQ DONE        ; If end of string, exit loop
    JSR IS_VOWEL    ; Check if character is a vowel
    BCC NOT_VOWEL   ; If character is not a vowel, skip incrementing count
    INC COUNT       ; Increment count of vowels
NOT_VOWEL:
    INX             ; Increment index to next character in string
    JMP LOOP        ; Continue looping
    
IS_VOWEL:
    CMP #$41        ; Check if character is 'A'
    BEQ VOWEL_FOUND 
    CMP #$45        ; Check if character is 'E'
    BEQ VOWEL_FOUND 
    CMP #$49        ; Check if character is 'I'
    BEQ VOWEL_FOUND 
    CMP #$4F        ; Check if character is 'O'
    BEQ VOWEL_FOUND 
    CMP #$55        ; Check if character is 'U'
    BCC NOT_VOWEL   ; If character is not a vowel, return with carry clear
VOWEL_FOUND:
    SEC             ; Set carry flag to indicate vowel found
    RTS             ; Return from subroutine
    
DONE:
    ; Display result
    LDA COUNT       ; Load count of vowels into accumulator
    STA $FF         ; Store result in memory location $FF
    
    ; End of program
    RTS             ; Return from program
