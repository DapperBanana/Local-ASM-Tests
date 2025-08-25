
ORG $1000

START:
    LDX #$00         ; Initialize index for first string
    LDY #$00         ; Initialize index for second string
    
LOOP:
    LDA STRING1, X  ; Load character from first string
    CMP #0           ; Check if end of string reached
    BEQ END
    
    LDA STRING2, Y  ; Load character from second string
    CMP #0           ; Check if end of string reached
    BEQ END
    
    CMP STRING1, Y  ; Compare character from first string with character from second string
    BEQ MATCH       ; If characters match, branch to MATCH
    
    INX             ; Increment index for first string
    INY             ; Increment index for second string
    BRA LOOP
    
MATCH:
    STA RESULT, X   ; Store the common character in result string
    INX             ; Increment index for result string
    INY             ; Increment index for second string
    BRA LOOP

END:
    LDA #0           ; Null terminate the result string
    STA RESULT, X
    RTS

STRING1:
    .BYTE "HELLO", 0   ; First string
STRING2:
    .BYTE "WORLD", 0   ; Second string
RESULT:
    .BYTE $00          ; Result string

    END START
