
ORG $0200
    LDX #$00         ; Initialize X to 0
    LDA #$ff         ; Initialize A to ff

generate_password:
    INX              ; Increment X
    JSR $FFCE        ; Get a random number
    AND #$1f         ; Mask the lower 5 bits
    ORA #$30         ; Convert to ASCII digit
    STA $0200, X     ; Store the character

    CPX #10          ; Check if desired length is reached
    BNE generate_password  ; If not, generate another character

    RTS              ; Return from subroutine
