
ORG $1000

STRING1    .BYTE "LISTEN"
STRING2    .BYTE "SILENT"
RESULT     .BYTE 0

START      LDX #0        ; Initialize index
CHECK_ANAGRAM:
    LDA STRING1,X      ; Load character from first string
    CMP #0             ; Check if end of string
    BEQ DONE           ; If end of string, done checking
    STA TEMP           ; Store character in temporary variable
    JSR CHECK_CHAR     ; Check if character exists in second string
    INX                ; Increment index
    BRA CHECK_ANAGRAM  ; Continue checking characters

CHECK_CHAR:
    LDY #0             ; Initialize index for second string
CHECK_LOOP:
    LDA STRING2,Y      ; Load character from second string
    CMP TEMP           ; Compare with character from first string
    BEQ CHAR_MATCH     ; If characters match, continue checking next character
    INY                ; Increment index
    CMP #0             ; Check if end of second string
    BNE CHECK_LOOP     ; If not end of string, continue checking
    RTS                ; If end of string, return

CHAR_MATCH:
    LDA #'Y            ; Set flag to indicate character match
    RTS                ; Return

DONE:
    STA RESULT         ; Store result of anagram check
    RTS

TEMP       .BYTE 0

.END
