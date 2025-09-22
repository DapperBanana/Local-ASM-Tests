
.segment "CODE"

    .org $0200

start:
    LDX #$00            ; Initialize index counter
    LDA message,X       ; Load first character of the string
    BEQ end             ; Check for end of string
    JSR toUpperCase     ; Convert character to uppercase
    STA result,X        ; Store the converted character
    INX                 ; Increment index counter
    INX                 ; Skip over lowercase character in lookup table
    INX
    INX
    INX
    INX
    INX
    INX
    BNE start           ; Continue processing next character

end:
    BRK

toUpperCase:   
    ; Convert character to uppercase (ASCII only)
    ; A = character
    ; Returns: A = uppercase character
    SEC
    SBC #$20            ; Subtract 32 to convert lowercase to uppercase
    CLC
    RTS

.segment "DATA"

message:
    .asciiz "hello, world!"  ; Input string
result:
    .ds 20                 ; Output string

