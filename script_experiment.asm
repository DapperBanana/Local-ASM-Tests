
    .org $0200    ; Start address of program
    LDX #$00     ; Initialize counter to zero
loop:
    LDA message,X  ; Load a character from the message
    CMP #65       ; Compare with 'A' (65)
    BCC not_vowel  ; If less than 'A', skip to not_vowel
    CMP #65+26    ; Compare with 'A' + 26 = 'Z'
    BCS not_vowel  ; If greater than 'Z', skip to not_vowel
    CMP #69       ; Compare with 'E' (69)
    BEQ vowel_found  ; If it's 'E', jump to vowel_found
    CMP #73       ; Compare with 'I' (73)
    BEQ vowel_found  ; If it's 'I', jump to vowel_found
    CMP #79       ; Compare with 'O' (79)
    BEQ vowel_found  ; If it's 'O', jump to vowel_found
    CMP #85       ; Compare with 'U' (85)
    BEQ vowel_found  ; If it's 'U', jump to vowel_found
not_vowel:
    INX           ; Increment counter
    INX           ; Skip next character
    CPX #strlen  ; Compare with length of the string
    BCS done      ; If end of the string, jump to done
    JMP loop      ; Continue looping
vowel_found:
    INX           ; Increment counter
    INX           ; Skip next character
    CPX #strlen  ; Compare with length of the string
    BCS done      ; If end of the string, jump to done
    JMP loop      ; Continue looping
done:
    ; End of program
    BRK

message:
    .asciiz "Hello, World!"  ; String to count vowels in
strlen = * - message         ; Calculate length of the string
