
START:
    LDX #0           ; Initialize counter for vowels
    LDY #0           ; Initialize index for string

LOOP:
    LDA MESSAGE, Y   ; Load character from string into A register
    BEQ END          ; If null terminator, end program
    CMP #$41         ; Compare with 'A'
    BCC NOT_VOWEL    ; If less than 'A', not a vowel
    CMP #$5A         ; Compare with 'Z'
    BCS NOT_VOWEL    ; If greater than 'Z', not a vowel
    CMP #$45         ; Compare with 'E'
    BEQ INCREMENT    ; If equal to 'E', increment counter for vowels
    CMP #$49         ; Compare with 'I'
    BEQ INCREMENT    ; If equal to 'I', increment counter for vowels
    CMP #$4F         ; Compare with 'O'
    BEQ INCREMENT    ; If equal to 'O', increment counter for vowels
    CMP #$55         ; Compare with 'U'
    BEQ INCREMENT    ; If equal to 'U', increment counter for vowels

NOT_VOWEL:
    INY              ; Move to next character in string
    JMP LOOP         ; Continue loop

INCREMENT:
    INX              ; Increment counter for vowels
    INY              ; Move to next character in string
    JMP LOOP         ; Continue loop

END:
    STX RESULT       ; Store the final count of vowels in RESULT
    BRK

MESSAGE:
    .asciiz "apple"  ; String to count vowels from
RESULT:
    .byte 0          ; Placeholder for result

    .org $FFFC
    .word START       ; Set reset vector to start of program
