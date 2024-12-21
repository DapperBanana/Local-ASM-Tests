
    LDX #0          ; Initialize the counter
loop:
    LDA $0200,X     ; Load a character from the first string
    CMP $0300,X     ; Compare it with the corresponding character from the second string
    BEQ next_char   ; If they are equal, move to the next character
    INC $0500       ; Increment the Hamming distance counter
next_char:
    INX             ; Move to the next character
    LDY $0401       ; Load the length of the strings
    CPX $0400       ; Compare the counter with the length
    BNE loop        ; If not at the end, go to the next character

    BRK             ; End of program

org $0200
    .byte "hello",0  ; First string
org $0300
    .byte "jello",0  ; Second string
org $0400
    .byte $05        ; Length of the strings
org $0401
    .byte $05

org $0500
    .byte $00        ; Hamming distance counter
