
; Count number of vowels in a given string

        .org $0600          ; Start address of the program

start   LDX #$00            ; Initialize counter for vowels
        LDA #$00            ; Initialize counter for string length
        LDY #$00            ; Initialize index for string traversal

nextChar
        LDA string, Y       ; Load the character at index Y
        BEQ done            ; If end of string, exit loop

        CMP #'A'            ; Compare with 'A'
        BMI nextVowel       ; If less than 'A', not a vowel
        CMP #'Z'            ; Compare with 'Z'
        BCS notVowel        ; If greater than 'Z', not a vowel

nextVowel
        CMP #'A'            ; Compare with 'A'
        BCC notVowel        ; If less than 'A', not a vowel
        CMP #'E'            ; Compare with 'E'
        BEQ isVowel         ; If equal to 'E', it is a vowel
        CMP #'I'            ; Compare with 'I'
        BEQ isVowel         ; If equal to 'I', it is a vowel
        CMP #'O'            ; Compare with 'O'
        BEQ isVowel         ; If equal to 'O', it is a vowel
        CMP #'U'            ; Compare with 'U'
        BEQ isVowel         ; If equal to 'U', it is a vowel
        CLC                 ; Reset carry flag
        INY                 ; Move to next character
        BNE nextChar        ; Continue loop

isVowel INX                 ; Increment vowel counter
        INY                 ; Move to next character
        BNE nextChar        ; Continue loop

notVowel
        INY                 ; Move to next character
        BNE nextChar        ; Continue loop

done    RTS                 ; Return from subroutine

string  .byte "HELLO, WORLD!", 0

        .org $FFFA          ; Interrupt vectors
        .word start         ; Reset vector
        .word start         ; BRK vector
        .word start         ; NMI vector
        .word start         ; IRQ/BRK vector
