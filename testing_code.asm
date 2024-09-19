
    .org $0200
    
start:
    LDX #0              ; Initialize index for string
    LDY #0              ; Initialize count for vowels
    LDA message,X       ; Load first character from string
    BEQ end             ; If end of string, branch to end
    
loop:
    CMP #'A'            ; Compare character with 'A'
    BCC not_vowel       ; If character < 'A', not a vowel
    CMP #'Z'            ; Compare character with 'Z'
    BCC vowel_check     ; If character <= 'Z', continue to vowel check

not_vowel:
    CMP #'a'            ; Compare character with 'a'
    BCC not_vowel2      ; If character < 'a', not a vowel
    CMP #'z'            ; Compare character with 'z'
    BCS not_vowel2      ; If character > 'z', not a vowel
    
vowel_check:
    CMP #'A'            ; Compare character with 'A'
    BCC not_vowel2      ; If character < 'A', not a vowel
    CMP #'E'            ; Compare character with 'E'
    BCS not_vowel2      ; If character >= 'E', branch to vowel count
    INY                 ; Increment vowel count
    BRA continue
    
not_vowel2:
    CMP #'a'            ; Compare character with 'a'
    BCC not_vowel3      ; If character < 'a', not a vowel
    CMP #'e'            ; Compare character with 'e'
    BCS not_vowel3      ; If character >= 'e', branch to vowel count
    INY                 ; Increment vowel count
    BRA continue
    
not_vowel3:
    CMP #'I'            ; Compare character with 'I'
    BCS not_vowel4      ; If character >= 'I', branch to vowel count
    INY                 ; Increment vowel count
    BRA continue
    
not_vowel4:
    CMP #'i'            ; Compare character with 'i'
    BCS not_vowel5      ; If character >= 'i', branch to vowel count
    INY                 ; Increment vowel count
    BRA continue
    
not_vowel5:
    CMP #'O'            ; Compare character with 'O'
    BCS not_vowel6      ; If character >= 'O', branch to vowel count
    INY                 ; Increment vowel count
    BRA continue
    
not_vowel6:
    CMP #'o'            ; Compare character with 'o'
    BCS not_vowel7      ; If character >= 'o', branch to vowel count
    INY                 ; Increment vowel count
    BRA continue
    
not_vowel7:
    CMP #'U'            ; Compare character with 'U'
    BCS not_vowel8      ; If character >= 'U', branch to vowel count
    INY                 ; Increment vowel count
    BRA continue
    
not_vowel8:
    CMP #'u'            ; Compare character with 'u'
    BCS continue        ; If character >= 'u', not a vowel
    
vowel_count:
    INY                 ; Increment vowel count

continue:
    INX                 ; Move to next character in string
    LDA message,X       ; Load next character from string
    BEQ end             ; If end of string, branch to end
    BRA loop            ; Continue loop
    
end:
    STA result          ; Store the final vowel count
    BRK                 ; Halt the program
    
    .org $0300
    
message:    .asciiz "Hello, World!"   ; Input string
result:     .byte 0                   ; Vowel count
    
    .end start
