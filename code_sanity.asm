
.INCLUDE "6502.inc"

ORG $1000

START:
    LDX #0      ; Initialize index
    LDY #0      ; Initialize index
    STX PTR     ; Store index X in PTR
READ_LOOP:
    LDA TEXT,Y  ; Load character in A
    BEQ END     ; If end of text, exit loop
    CMP #$20    ; Compare A with space
    BEQ SPACE   ; If space, go to SPACE
    STA BUFFER,X ; Store character in buffer
    INX         ; Increment index
    BRA READ_LOOP ; Continue reading text
SPACE:
    LDA BUFFER   ; Load buffer in A
    CMP #"T"     ; Compare A with "T"
    BEQ TRANSLATE ; If match, translate
    CMP #"H"     ; Compare A with "H"
    BEQ TRANSLATE ; If match, translate
    CMP #"E"     ; Compare A with "E"
    BEQ TRANSLATE ; If match, translate
    BRA READ_LOOP ; Continue reading text
TRANSLATE:
    LDA #$45      ; Load 'E' in A
    STA OUTPUT,Y  ; Store 'E' in OUTPUT
    INY           ; Increment index
    LDA #$4C      ; Load 'L' in A
    STA OUTPUT,Y  ; Store 'L' in OUTPUT
    INY           ; Increment index
    LDA #$4F      ; Load 'O' in A
    STA OUTPUT,Y  ; Store 'O' in OUTPUT
    INY           ; Increment index
    LDA #$20      ; Load space in A
    STA OUTPUT,Y  ; Store space in OUTPUT
    INY           ; Increment index
    BRA READ_LOOP ; Continue reading text
END:
    RTS

PTR: .BYTE 0
BUFFER: .DS 20
OUTPUT: .DS 20
TEXT: .ASC "HELLO WORLD"

.END
