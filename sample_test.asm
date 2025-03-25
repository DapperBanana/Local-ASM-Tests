
    ; Count the number of vowels in a given string
    
    .org $0200    ; Start address
    
start:
    LDX #$00    ; Initialize index counter
    LDY #$00    ; Initialize vowel counter
    
loop:
    LDA message, X   ; Load character from message
    BEQ end      ; Exit loop if end of string is reached
    
    CMP #$41    ; Check for 'A'
    BEQ vowel    ; If A, increment vowel counter
    CMP #$45    ; Check for 'E'
    BEQ vowel    ; If E, increment vowel counter
    CMP #$49    ; Check for 'I'
    BEQ vowel    ; If I, increment vowel counter
    CMP #$4F    ; Check for 'O'
    BEQ vowel    ; If O, increment vowel counter
    CMP #$55    ; Check for 'U'
    BEQ vowel    ; If U, increment vowel counter
    
increment:
    INX        ; Move to next character in string
    BNE loop    ; Continue looping
    
vowel:
    INY        ; Increment vowel counter
    JMP increment    ; Continue looping
    
end:
    ; Vowel count is stored in Y register
    
    ; Your code here
    
message:
    .text "THIS IS A SAMPLE STRING WITH VOWELS"
