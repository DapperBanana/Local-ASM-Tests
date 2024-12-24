
ORG $0200

START:
    LDX #0      ; Initialize index for string 1
    LDY #0      ; Initialize index for string 2
    LDA #0      ; Initialize distance matrix
    STA DIST

LOOP:
    LDA STR1, X  ; Load character from string 1
    BEQ END      ; If end of string 1, exit
    STA CHAR1

    LDX #0       ; Reset index for string 2

INNER_LOOP:
    LDA STR2, X  ; Load character from string 2
    BEQ NEXT     ; If end of string 2, go to next character in string 1
    STA CHAR2

    CMP CHAR1, CHAR2
    BEQ NEXT

    LDX #1
    LDA #1
    STA TEMP
    CLC
    ADC DIST, X
    LDA DIST
    ADC #1
    STA DIST

NEXT:
    INX
    CPX #MAX_LEN
    BNE INNER_LOOP

    INY
    CPY #MAX_LEN
    BNE LOOP

END:
    BRK

DIST: .BYTE 0     ; Distance matrix
STR1: .BYTE "HELLO"  ; First string
STR2: .BYTE "WORLD"  ; Second string

CHAR1: .BYTE 0
CHAR2: .BYTE 0

MAX_LEN: .BYTE 5

TEMP: .BYTE 0

    JMP START
