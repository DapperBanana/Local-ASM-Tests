
START:
    LDX #0 ; Initialize index to 0
LOOP:
    LDY text,X ; Load character into Y register
    CPY #32 ; Check if character is lowercase
    BMI NOT_LOWER ; If character is not lowercase, skip
    CMP #97 ; Check if character is between 'a' and 'z'
    BCC NOT_LOWER ; If not, skip
    SEC ; Set carry flag
    SBC #32 ; Convert lowercase character to uppercase
    STY text,X ; Store character back in memory
NOT_LOWER:
    INX ; Move to the next character
    CPX #MAX_LEN ; Check if end of string has been reached
    BCC LOOP ; If not, continue loop
DONE:
    BRK ; Exit program

.text "hello, world" ; String to convert to title case
MAX_LEN = * - .text ; Length of the string

    .org $1000 ; Start of program
    JMP START ; Jump to start of program

text:
    .block MAX_LEN ; Reserve space for string in memory
