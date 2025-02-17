
; Check if a given string is a valid IPv4 address
;
; Input: A = starting address of the string
; Output: Carry flag set if valid, cleared if invalid

START   LDA #$00        ; Initialize counter
        STA $02         ; Store in memory location $02
LOOP    LDA $A          ; Load character from string
        BEQ VALID       ; Branch if end of string reached
        CMP #'.'        ; Compare with period character
        BEQ CHECK       ; Branch if period found
        CMP #'0'        ; Compare with '0'
        BCC INVALID     ; Branch if character is not a number
        CMP #'9'        ; Compare with '9'
        BCS INVALID     ; Branch if character is not a number
        INC $02         ; Increment counter
        INX             ; Increment index
        JMP LOOP        ; Continue loop

CHECK   LDA $02         ; Load counter
        CMP #$04        ; Compare with 4 (IPv4 address has 4 octets)
        BNE INVALID     ; Branch if number of octets is not 4
        LDY #$00        ; Initialize octet counter
        LDX #$00        ; Initialize value of current octet
READ    LDA $A          ; Load character from string
        CMP #'.'        ; Compare with period character
        BEQ STORE       ; Branch if period found
        CMP #'0'        ; Compare with '0'
        BCC INVALID     ; Branch if character is not a number
        CMP #'9'        ; Compare with '9'
        BCS INVALID     ; Branch if character is not a number
        CLC             ; Clear carry
        ASL             ; Multiply by 2
        ADC #'0'        ; Convert to number character
        STA $00,Y       ; Store in temporary buffer
        INY             ; Increment octet counter
        JMP READ        ; Continue reading octet

STORE   LDA $00         ; Load first digit of octet
        STA $01         ; Store in temporary buffer
        LDA $00,$00     ; Load second digit of octet
        ASL             ; Shift left to multiply by 10
        ASL
        ASL
        ASL
        CLC
        ADC $01         ; Add to first digit
        STA $00,X       ; Store value of current octet
        INX             ; Increment X register
        INX             ; Increment X register
        INY             ; Increment octet counter
        LDA $00         ; Load next character
        CMP #'.'        ; Check if end of current octet
        BEQ NEXT        ; Branch if end
        JMP INVALID     ; Invalid character found

NEXT    LDA $A          ; Load next character
        CMP #'.'        ; Check if end of string
        BEQ VALID       ; Branch if end of string
        JMP INVALID     ; Invalid character found

VALID   SEC             ; Set carry flag
        RTS             ; Return

INVALID CLC             ; Clear carry flag
        RTS             ; Return
