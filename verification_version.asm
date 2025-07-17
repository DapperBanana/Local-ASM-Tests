
ORG $0200

RESET:
    LDX #$00       ; Initialize counter for vowels
    LDY #$00       ; Initialize index for string
    
LOOP:
    LDA STR,Y      ; Load next character from input string
    BEQ DONE       ; If NULL terminator, done processing
    
    CMP #'A'       ; Check if character is 'A'
    BEQ IS_VOWEL   ; If equal to 'A', it is a vowel
    
    CMP #'E'       ; Check if character is 'E'
    BEQ IS_VOWEL   ; If equal to 'E', it is a vowel
    
    CMP #'I'       ; Check if character is 'I'
    BEQ IS_VOWEL   ; If equal to 'I', it is a vowel
    
    CMP #'O'       ; Check if character is 'O'
    BEQ IS_VOWEL   ; If equal to 'O', it is a vowel
    
    CMP #'U'       ; Check if character is 'U'
    BEQ IS_VOWEL   ; If equal to 'U', it is a vowel
    
    INY            ; Move to next character in string
    JMP LOOP       ; Check next character
    
IS_VOWEL:
    INY            ; Move to next character in string
    INX            ; Increment vowel counter
    JMP LOOP       ; Check next character
    
DONE:
    STX COUNT      ; Store the final count in memory
    BRK            ; Exit program
    
COUNT:
    .BYTE $00      ; Memory location to store the count
    
STR:
    .BYTE "HELLO, WORLD!", $00   ; Input string
    
    .END

