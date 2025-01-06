
; Assumptions:
; X register contains the address of the beginning of the string
; Y register contains the length of the string

START:
    LDA #'<'        ; Check if the string starts with "<"
    STA $C000       ; Store the character in a temporary memory location
    
    LDX #1          ; Initialize index to 1
CHECK_START:
    INX             ; Increment index
    LDY $C000,X     ; Load next character from the string 
    CPY #'?'        ; Check if the character is "?"
    BEQ CHECK_END   ; Branch to end if the character is "?"
    CPY #$00        ; Check if end of string
    BEQ END_CHECK   ; Branch to end check if end of string
    CPY #'<'        ; Check if the character is "<"
    BNE CHECK_START ; Branch back to CHECK_START if not "<"
    JMP CHECK_START ; Go back to CHECK_START

CHECK_END:
    LDA #'?'        ; Check if the last character is "?"
    CMP $C000,X     ; Compare with the last character in the string
    BEQ VALID_DOC   ; Branch to VALID_DOC if last character is "?"

END_CHECK:
    ; Invalid XML document with DTD
    RTS

VALID_DOC:
    ; Valid XML document with DTD
    RTS
