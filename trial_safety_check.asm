
; 6502 Assembly program to check if a given string is a valid email address

START:
    LDX #0           ; Initialize index register X to 0
    LDY #0           ; Initialize index register Y to 0

READ_CHAR:
    LDA MESSAGE, Y   ; Load the next character from the string
    CMP #0           ; Check if end of string
    BEQ END          ; If end of string, exit the program

    CMP #65          ; Check if the character is lower-case alphabet
    BMI NOT_VALID    ; If character is not a lower-case alphabet, check if it is valid

    CMP #122         ; Check if the character is upper-case alphabet
    BPL NOT_VALID    ; If character is not an upper-case alphabet, check if it is valid

    CMP #48          ; Check if the character is a digit
    BCC NOT_VALID    ; If character is not a digit, check if it is valid

    CMP #57          ; Check if the character is a special character like '@' or '.'
    BCS NOT_VALID    ; If character is not a special character, check if it is valid
    
    INY              ; Move to the next character in the string
    JMP READ_CHAR    ; Repeat the process for the next character

NOT_VALID:
    LDA #0           ; Load 0 into the accumulator to indicate that the email address is not valid
    BRK              ; Exit the program

END:
    LDA #1           ; Load 1 into the accumulator to indicate that the email address is valid
    BRK              ; Exit the program

MESSAGE:
    .asciiz "example@example.com"  ; Define the email address string

    .end START        ; End of program
