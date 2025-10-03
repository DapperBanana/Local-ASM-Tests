
    .org $0200

    ; Load the address of the start of the string into X register
    LDX #STRING
    
CHECK_CC:
    ; Load the first character of the string into the accumulator
    LDA (X),Y
   
    ; Check if the character is a digit
    CMP #'0'
    BCC INVALID
    CMP #'9'
    BCS INVALID

    ; Increment X register to move to the next character in the string
    INX

    ; Check if we have reached the end of the string
    CPX #STRING_LENGTH
    BCC CHECK_CC

    ; If we reach this point, the string is a valid credit card number
    JMP VALID

INVALID:
    ; If we reach this point, the string is not a valid credit card number
    JMP INVALID

VALID:
    ; Valid credit card number
    JMP $

    .org $1000

STRING:
    .byte $31, $32, $33, $34, $35, $36, $37, $38, $39, $30
STRING_LENGTH = ($ - STRING)
