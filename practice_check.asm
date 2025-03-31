
LDA #$00     ; Load accumulator with null terminator
STA $01FF    ; Set null terminator at end of input string
LDX #$00     ; Initialize index to 0

LOOP:
    LDA $0100, X  ; Load character from input string
    CMP #$61      ; Compare with 'a'
    BCC NOT_LOWER ; Branch if not lowercase
    CMP #$7A      ; Compare with 'z'
    BCS NOT_LOWER ; Branch if not lowercase
    SEC
    SBC #$20      ; Convert lowercase to uppercase
    STA $0100, X  ; Store back into input string
    
NOT_LOWER:
    INX           ; Increment index
    CPX #$FF      ; Check for end of string
    BNE LOOP      ; Loop if not end of string

    RTS           ; Return from subroutine
