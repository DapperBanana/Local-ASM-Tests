
; 6502 Assembly program to count the number of vowels in a given string
; Input: String stored in memory starting at $C000
; Output: Number of vowels stored in memory at $C100

    .org $C000      ; Start of string
inputString
    .asciiz "hello world"  ; Example string

    .org $C100      ; Start of output variable
vowelCount
    .byte 0        ; Initialize vowel count to 0

    LDX #0         ; Initialize index X to 0
loop
    LDA inputString,X  ; Load character at index X
    BEQ end        ; If end of string, exit loop

    CMP #'a'       ; Compare with lowercase vowels
    BCC notVowel   ; If character is before 'a', it's not a vowel
    CMP #'z'
    BCS notVowel   ; If character is after 'z', it's not a vowel

    CMP #'a'       ; Check for lowercase vowels
    BEQ isVowel
    CMP #'e'
    BEQ isVowel
    CMP #'i'
    BEQ isVowel
    CMP #'o'
    BEQ isVowel
    CMP #'u'
    BEQ isVowel

    CMP #'A'       ; Check for uppercase vowels
    BEQ isVowel
    CMP #'E'
    BEQ isVowel
    CMP #'I'
    BEQ isVowel
    CMP #'O'
    BEQ isVowel
    CMP #'U'
    BEQ isVowel
    BRA notVowel   ; If character is not a vowel, skip increment

isVowel
    INC vowelCount  ; Increment vowel count

notVowel
    INX            ; Increment index
    BNE loop       ; Loop back to check next character

end
    STX $C101      ; Store the final vowel count
    BRK            ; Exit program
