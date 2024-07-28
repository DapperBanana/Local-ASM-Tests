
.segment "CODE"
.org $0200

START:
    ; Initialize list
    LDX #0 ; Set index to 0
    LDA #10 ; Set list length
    STA LENGTH
    LDA #34 ; Set searched element
    STA SEARCH_ELEMENT
    LDA #0 ; Initialize the accumulator
    STA FOUND ; Initialize the found flag
    STA LEFT ; Initialize the left index
    LDA LENGTH
    SEC
    SBC #1
    STA RIGHT ; Initialize the right index

LOOP:
    ; Calculate middle index
    LDA LEFT
    CLC
    ADC RIGHT
    LSR
    STA MIDDLE

    ; Check if middle element is equal to the searched element
    LDA ELEMENTS, X
    CMP SEARCH_ELEMENT
    BEQ FOUND_ELEM

    ; Check if left index is greater than right index
    LDA LEFT
    CMP RIGHT
    BGE NOT_FOUND

    ; Compare middle element with searched element
    LDA ELEMENTS, X
    CMP SEARCH_ELEMENT
    BCC SET_LEFT
    JMP SET_RIGHT

SET_LEFT:
    ; Set left index to middle + 1
    LDA MIDDLE
    CLC
    ADC #1
    STA LEFT
    JMP LOOP

SET_RIGHT:
    ; Set right index to middle - 1
    LDA MIDDLE
    SEC
    SBC #1
    STA RIGHT
    JMP LOOP

FOUND_ELEM:
    ; Set found flag
    LDA #1
    STA FOUND

NOT_FOUND:
    ; End of search
    RTS

.segment "DATA"
.ORG $0300
LENGTH: .BYTE 0
SEARCH_ELEMENT: .BYTE 0
FOUND: .BYTE 0
LEFT: .BYTE 0
RIGHT: .BYTE 0
MIDDLE: .BYTE 0

ELEMENTS: .BYTE 10, 20, 30, 40, 50, 60, 70, 80, 90, 100

