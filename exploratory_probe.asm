
; Check if a given string is a valid JSON
;
; Input:
; - Address of the string in memory
; Output:
; - Carry flag set if valid JSON, clear otherwise

JSON_CHECK:
    LDA #$00           ; Initialize loop counter
    STA index
    LDA #$00           ; Initialize brace count
    STA braces

LOOP:
    LDA (input), Y     ; Load next character from string
    CMP #$5B           ; Check if character is '['
    BEQ INCREMENT_BRACES
    CMP #$7B           ; Check if character is '{'
    BEQ INCREMENT_BRACES
    CMP #$5D           ; Check if character is ']'
    BEQ DECREMENT_BRACES
    CMP #$7D           ; Check if character is '}'
    BEQ DECREMENT_BRACES

    INCREMENT_BRACES:
        CLC
        LDA braces
        ADC #$01       ; Increment brace count
        STA braces

    DECREMENT_BRACES:
        CLC
        LDA braces
        SEC
        SBC #$01       ; Decrement brace count
        STA braces

    INCREMENT_INDEX:
        CLC
        LDA index
        ADC #$01       ; Increment loop counter
        STA index

    CHECK_END_OF_STRING:
        LDA (input), Y    ; Load next character
        CMP #$00          ; Check if end of string
        BEQ END_OF_STRING
        JMP LOOP

END_OF_STRING:
    LDA braces         ; Check if brace count is zero
    BEQ VALID_JSON

INVALID_JSON:
    SEC               ; Set carry flag
    RTS

VALID_JSON:
    CLC               ; Clear carry flag
    RTS
