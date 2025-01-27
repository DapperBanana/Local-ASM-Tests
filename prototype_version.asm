
START:
    LDX #0      ; Initialize index register X to 0
    LDA PHRASE,X   ; Load a character from English phrase
    CMP #0        ; Check if end of phrase
    BEQ END      ; Branch to end if end of phrase
    JSR TRANSLATE    ; Translate the character into Spanish
    INX         ; Increment index register X
    JMP START     ; Continue translating the next character

TRANSLATE:
    CMP 'H'      ; Check for English character 'H'
    BEQ H        ; Branch to translation for 'H'
    CMP 'E'      ; Check for English character 'E'
    BEQ E        ; Branch to translation for 'E'
    ; Add more translation rules here for additional characters
    JMP DEFAULT    ; Default translation if no match

H:
    LDA #'HOLA'    ; Load Spanish translation for 'H'
    JSR OUTPUT    ; Output the Spanish translation
    RTS

E:
    LDA #'HOLA'    ; Load Spanish translation for 'E'
    JSR OUTPUT    ; Output the Spanish translation
    RTS

DEFAULT:
    LDA #'?'      ; Load default translation character
    JSR OUTPUT    ; Output the default translation
    RTS

OUTPUT:
    STA TRANSLATED,X   ; Store the translated character
    RTS

PHRASE:
    .asciiz "HELLO WORLD" ; English phrase to be translated

TRANSLATED:
    .byte 0      ; Translated Spanish phrase

END:
    BRK        ; End of program
