
        .org $1000
START:  LDX #0             ; Initialize index
LOOP:   LDA STRING,X       ; Load next character from string
        BEQ VALID          ; Branch to VALID if end of string
        CMP #"0"           ; Compare with ASCII '0'
        BCC INVALID        ; Branch to INVALID if less than '0'
        CMP #"9"           ; Compare with ASCII '9'
        BCS INVALID        ; Branch to INVALID if greater than '9'
        INX                ; Increment index
        CPX #16            ; Check length of string (16 digits)
        BNE LOOP           ; Branch back to LOOP if not yet 16 digits
VALID:  LDA #$01           ; Set valid flag to 1
        RTS                ; Return from subroutine
INVALID:
        LDA #$00           ; Set valid flag to 0
        RTS                ; Return from subroutine

STRING: .byte "1234567890123456", 0 ; Example credit card number

        .end
