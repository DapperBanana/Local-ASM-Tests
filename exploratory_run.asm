
; Count number of vowels in a string

START	LDX #0                ; Initialize counter for vowels
        LDA #0                ; Initialize counter for string index
        STA INDEX
LOOP    LDA STRING, X         ; Load character from string
        BEQ END               ; If end of string, exit loop
        CMP #'A'              ; Compare character with 'A'
        BMI CONSONANT         ; If character is before 'A', check next character
        CMP #'Z'              ; Compare character with 'Z'
        BPL VOWEL             ; If character is after 'Z', check for vowels
        CMP #'a'              ; Compare character with 'a'
        BMI CONSONANT
        CMP #'z'              ; Compare character with 'z'
        BPL VOWEL
        BRA CONSONANT         ; If character is not a letter, check next character
VOWEL   CMP #0x41             ; Compare character with 'A'
        BCC VOWEL_2           ; If character is before 'A', check lowercase vowels
        CMP #0x5A             ; Compare character with 'Z'
        BCS VOWEL_2           ; If character is after 'Z', check lowercase vowels
CONSONANT INX                  ; Increment string index
        BRA LOOP              ; Continue looping
VOWEL_2 CMP #0x61             ; Compare character with 'a'
        BCC CONSONANT         ; If character is before 'a', not a vowel
        CMP #0x7A             ; Compare character with 'z'
        BCS CONSONANT         ; If character is after 'z', not a vowel
        INX                   ; Increment vowel counter
        BRA CONSONANT         ; Continue looping
END     STA RESULT            ; Store the result in RESULT
        BRK

STRING  .BYTE "This is a test string with vowels.", 0
INDEX   .BYTE 0
RESULT  .BYTE 0

        .ORG $FFFC
        .WORD START
