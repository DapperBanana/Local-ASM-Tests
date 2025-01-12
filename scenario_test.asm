
        .org $0200                 ; Start address of program
input   .byte "HELLO, WORLD!", 0  ; Input string
output  .byte 0                   ; Output variable to store the count of vowels

start      
        LDX #0                    ; Initialize index register X to point to start of string
        LDY #0                    ; Initialize Y register to store the count of vowels

loop    
        LDA input,X               ; Load character at current index 
        BEQ done                  ; If end of string is reached, exit loop
        JSR check_vowel           ; Check if character is a vowel
        INX                       ; Move to next character
        BNE loop                  ; Repeat loop

done    
        STA output                ; Store the count of vowels in output variable
        BRK                       ; Exit program

check_vowel    
        CMP #"A"                  ; Compare with 'A'
        BCC not_vowel             
        CMP #"E"                  ; Compare with 'E'
        BCC not_vowel
        CMP #"I"                  ; Compare with 'I'
        BCC not_vowel
        CMP #"O"                  ; Compare with 'O'
        BCC not_vowel
        CMP #"U"                  ; Compare with 'U'
        BMI is_vowel

not_vowel
        RTS

is_vowel
        INY                       ; Increment count of vowels
        RTS
