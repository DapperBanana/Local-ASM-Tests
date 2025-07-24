
    .text
    .global _start
    
_start:
    ; Initialize variables
    LDX #0            ; Counter for vowels
    LDY #0            ; Index for string traversal
    LDA message,Y     ; Load first character from message
    
check_vowel:
    CMP #0             ; Check if end of string
    BEQ end           ; If end of string, exit program
    
    CMP #'A'
    BEQ is_vowel       ; If character is 'A', 'E', 'I', 'O', or 'U', it is a vowel
    CMP #'E'
    BEQ is_vowel
    CMP #'I'
    BEQ is_vowel
    CMP #'O'
    BEQ is_vowel
    CMP #'U'
    BEQ is_vowel
    
    INY                ; Move to next character in string
    LDA message,Y      ; Load next character
    JMP check_vowel    ; Check if next character is a vowel
    
is_vowel:
    INX                ; Increment vowel counter
    INY                ; Move to next character in string
    LDA message,Y      ; Load next character
    JMP check_vowel    ; Check if next character is a vowel
    
end:
    STA count         ; Store the count of vowels
    ; End of program
    
    .data
message:
    .asciiz "Hello, World!"  ; String to count vowels in
count: 
    .byte 0                  ; Variable to store vowel count
