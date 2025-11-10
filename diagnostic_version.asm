
        .org $0200
START:  LDX #0         ; Initialize index to zero
        LDA STRING,X   ; Load first character of string
        BEQ END        ; If string is empty, exit
CHECK:  CMP #'@'
        BEQ VALID      ; If character is '@', email is possibly valid
        CMP #'.'
        BEQ VALID      ; If character is '.', email is possibly valid
        CMP #' '
        BEQ INVALID    ; If character is space, email is invalid
        INX             ; Move to next character
        LDA STRING,X   ; Load next character
        BNE CHECK      ; Repeat until end of string
END:    RTS
VALID:  LDX #1         ; Set success flag to 1
        RTS
INVALID:LDX #0         ; Set success flag to 0
        RTS

STRING: .asciiz "test@example.com"  ; Input string to check
        .end
