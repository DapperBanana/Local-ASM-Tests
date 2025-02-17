
* = $0200

    LDX #0             ; Initialize index register
loop:
    LDA input,X        ; Load next character from input string
    BEQ valid_url      ; If null terminator, end of string reached
    CMP #'a'
    BCC not_valid_url  ; Not a valid URL, character too small
    CMP #'z'
    BCS not_valid_url  ; Not a valid URL, character too large
    CMP #'0'
    BCC not_valid_url  ; Not a valid URL, character too small
    CMP #'9'
    BCS not_valid_url  ; Not a valid URL, character too large
    CMP #'.'           ; Check for period symbol
    BEQ period_found   ; Period symbol found
    CMP #'-'           ; Check for hyphen symbol
    BEQ hyphen_found   ; Hyphen symbol found
    CMP #'_'           ; Check for underscore symbol
    BEQ underscore_found ; Underscore symbol found
    CMP #'/'           ; Check for forward slash symbol
    BEQ slash_found    ; Forward slash symbol found
    CMP #'?'           ; Check for question mark symbol
    BEQ question_found ; Question mark symbol found
    CMP #'&'           ; Check for ampersand symbol
    BEQ ampersand_found ; Ampersand symbol found
    INX                ; Move to next character in input string
    JMP loop           ; Repeat loop

not_valid_url:
    LDA #0             ; Invalid URL
    STA result
    RTS

valid_url:
    LDA #1             ; Valid URL
    STA result
    RTS

period_found:
    INX                ; Skip period symbol
    JMP loop

hyphen_found:
    INX                ; Skip hyphen symbol
    JMP loop

underscore_found:
    INX                ; Skip underscore symbol
    JMP loop

slash_found:
    INX                ; Skip forward slash symbol
    JMP loop

question_found:
    INX                ; Skip question mark symbol
    JMP loop

ampersand_found:
    INX                ; Skip ampersand symbol
    JMP loop

input:
    .text "https://www.example.com"
result:
    .byte 0
