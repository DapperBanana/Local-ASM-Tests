
.186
.CPU 6502

    ORG $1000
START:
    LDX #$00        ; Initialize index
    LDA str,X      ; Load first character of string
    BEQ IS_ISOGRAM  ; If string is empty, it is an isogram
LOOP:
    LDY #$00        ; Initialize inner index
CHECK_DUPLICATE:
    INY             ; Increment inner index
    BEQ IS_ISOGRAM  ; If end of string is reached, it is an isogram
    LDA str,X      ; Load next character of string
    CPY X           ; Compare inner index with outer index
    BEQ LOOP        ; If duplicate found, string is not an isogram
    CMP str,Y      ; Compare characters
    BEQ LOOP        ; If duplicate found, string is not an isogram
    BNE CHECK_DUPLICATE ; Continue checking for duplicates
IS_ISOGRAM:
    RTS             ; Return

str:
    .ASC "hello"    ; Input string

    .END
