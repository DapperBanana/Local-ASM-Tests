
VOWEL_COUNT_START:
    LDX #0            ; Initialize vowel count to 0
    LDY #0            ; Initialize index of string to 0

LOOP:
    LDA STRING, Y     ; Load next character from string
    BEQ END_LOOP      ; If end of string, exit loop

    CMP #'A'          ; Compare with 'A'
    BCC NOT_VOWEL     ; If less than 'A', not a vowel
    CMP #'Z'          ; Compare with 'Z'
    BCS NOT_VOWEL     ; If greater than 'Z', not a vowel

    CMP #'A' + 5      ; Compare with 'E'
    BCC NOT_VOWEL     ; If less than 'E', not a vowel
    CMP #'E' + 5      ; Compare with 'I'
    BCS NOT_VOWEL     ; If greater than 'I', not a vowel

    CMP #'E' + 5      ; Compare with 'O'
    BCC NOT_VOWEL     ; If less than 'O', not a vowel
    CMP #'O' + 5      ; Compare with 'U'
    BCS NOT_VOWEL     ; If greater than 'U', not a vowel

    INX               ; Increment vowel count

NOT_VOWEL:
    INY               ; Increment index of string
    JMP LOOP          ; Continue looping

END_LOOP:
    ; The vowel count is stored in X register here, you can use it as needed

STRING:
    .asciiz "Hello, world!" ; Input string

    .end VOWEL_COUNT_START
