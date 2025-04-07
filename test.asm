
.org $0200

START:
    LDX #0             ; Initialize index X to 0
LOOP:
    LDA MESSAGE,X      ; Load character at current index into A register
    CMP #'!'           ; Compare character to '!'
    BEQ SKIP_PUNCT     ; If character is '!', skip over remove step
    CMP #'?'           ; Compare character to '?'
    BEQ SKIP_PUNCT     ; If character is '?', skip over remove step
    CMP #','           ; Compare character to ','
    BEQ SKIP_PUNCT     ; If character is ',', skip over remove step
    CMP #'.'           ; Compare character to '.'
    BEQ SKIP_PUNCT     ; If character is '.', skip over remove step

REMOVE_PUNCT:
    STA MESSAGE,X      ; Store character back into string at current index 
    INX                ; Increment index
SKIP_PUNCT:
    INX                ; Increment index
    CPX #LENGTH        ; Compare current index to string length
    BNE LOOP           ; If not at end of string, continue loop

END:
    BRK                ; End program

MESSAGE:
    .asciiz "Hello, World! How are you doing?"
LENGTH = * - MESSAGE

    .end
