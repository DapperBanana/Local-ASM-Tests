
; Check if a given string is a valid URL in 6502 Assembly

        .org $0200

start   LDX #$00            ; Initialize index to 0
        LDY #$00            ; Initialize counter to 0

loop    LDA input, X        ; Load character into A
        CMP #$00            ; Check if end of string
        BEQ end             ; If end of string, exit

        CMP #'a'            ; Check if lowercase letter
        BCC not_valid
        CMP #'z'
        BCS check_uppercase
        
        CMP #'A'            ; Check if uppercase letter
        BCC not_valid
        CMP #'Z'
        BCS check_uppercase

        CMP #'0'            ; Check if number
        BCC not_valid
        CMP #'9'
        BCS check_other

        JSR check_other_char ; Check for other valid characters
        BCC not_valid

        INX                 ; Move to next character
        INY                 ; Increment counter
        JMP loop

check_uppercase
        CMP #'A'
        BCC not_valid
        CMP #'Z'
        BCS check_other

check_other_char
        CMP #'-'            ; Check for hyphen
        BEQ valid_char
        CMP #'_'            ; Check for underscore
        BEQ valid_char
        CMP #'.'            ; Check for period
        BEQ valid_char

not_valid
        LDA #$00            ; Set result to false
        RTS

valid_char
        INX                 ; Move to next character
        INY                 ; Increment counter
        RTS

end     LDA #$01            ; Set result to true
        STA result
        RTS

input   .asciiz "www.example.com"
result  .byte $00

        .end
