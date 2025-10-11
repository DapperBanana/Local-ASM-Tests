
LDA #$00      ; Load accumulator with 0
LDX #$00      ; Load X register with 0

LOOP:
    LDA INPUT,X   ; Load character from input string
    CMP #$61      ; Compare with lowercase 'a'
    BCC NOT_LOWER ; Branch if not lowercase
    CMP #$7B      ; Compare with lowercase 'z' + 1
    BCS NOT_LOWER ; Branch if not lowercase
    SEC
    SBC #$20      ; Convert to uppercase
    STA OUTPUT,X  ; Store converted character
    INX           ; Increment index
NOT_LOWER:
    INX           ; Increment index
    CPX LENGTH    ; Compare index with length
    BNE LOOP      ; Branch if not end of string

    LDA #$00      ; Load accumulator with 0
    STA OUTPUT,X  ; Null-terminate output string

INPUT:
    .asciiz "hello, world!"
LENGTH:
    .byte (*)-INPUT
OUTPUT:
    .ds 20

    .end
