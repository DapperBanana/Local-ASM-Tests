
ORG $0200

START:
    LDX #0        ; Initialize index for first string
    LDY #0        ; Initialize index for second string
    
LOOP:
    LDA STR1,X    ; Load character from first string
    BEQ DONE      ; If end of string, exit loop
    STA CHAR      ; Store character temporarily
    
INNER_LOOP:
    LDA STR2,Y    ; Load character from second string
    BEQ CONTINUE  ; If end of string, move to next character in first string
    CMP CHAR      ; Compare character with temporary character
    BEQ FOUND     ; If characters match, print character
    INY           ; Move to next character in second string
    JMP INNER_LOOP

FOUND:
    JSR $FFD2     ; Output common character
    INY           ; Move to next character in first string
    
CONTINUE:
    INX           ; Move to next character in second string
    JMP LOOP

DONE:
    BRK           ; End of program

    .ORG $FD2
CHAR: .BYTE $00    ; Temporary character storage

    .ORG $0300
STR1: .BYTE "HELLO", 0
STR2: .BYTE "WORLD", 0

    .END START
