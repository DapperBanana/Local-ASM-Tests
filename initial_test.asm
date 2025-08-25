
LDA #0              ; Initialize index pointer to 0
    STA $00
LOOP:
    LDA INPUT,X     ; Load character from input string
    CMP #65         ; Compare with ASCII value for 'a'
    BCC NOT_LOWERCASE    ; If character is not lowercase, skip to next character
    CMP #122        ; Compare with ASCII value for 'z'
    BCS NOT_LOWERCASE    ; If character is not lowercase, skip to next character
    SBC #32         ; Convert lowercase character to uppercase
    STA OUTPUT,X    ; Store converted character in output string
NOT_LOWERCASE:
    INX             ; Increment index pointer
    CPX #STRING_SIZE    ; Compare with the string size
    BNE LOOP        ; If index is not equal to the string size, continue loop
    RTS             ; Return from subroutine

INPUT:
    .BYTE "hello, world!",0
OUTPUT:
    .BYTE 20 DUP (?)
STRING_SIZE = * - INPUT - 1
