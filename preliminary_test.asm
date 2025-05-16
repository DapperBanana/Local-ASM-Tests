
; Assume input string is located at $1000
; Assume output flag is located at $FF
; Assume valid flag is located at $FE

.start
    LDA #$00        ; Initialize index to 0
    STA $FF
    STA $FE

.check_next_byte
    LDA $1000, X   ; Load byte from input string
    BEQ .end        ; If end of string, terminate
    CMP #'.'        ; Check if byte is a dot
    BEQ .check_octet ; If byte is a dot, check octet
    CMP #'0'        ; Check if byte is a digit between 0-9
    BCC .error      ; If byte is not a digit, error
    CMP #'9'
    BCS .error      ; If byte is not a digit, error

    INX             ; Increment index
    BNE .check_next_byte ; Continue checking next byte

.check_octet
    LDX $FF         ; Get current octet count
    INX             ; Increment index
    CMP #3          ; Check if there are more than 3 octets
    BCS .error      ; If more than 3 octets, error

    STX $FF         ; Store updated octet count

    LDA $1000, X    ; Load byte from input string
    CMP #'0'        ; Check if byte is a digit between 0-9
    BCC .error      ; If byte is not a digit, error
    CMP #'9'
    BCS .error      ; If byte is not a digit, error

    INX             ; Increment index
    BNE .check_octet ; Continue checking next byte

    LDA $1000, X    ; Load byte from input string
    CMP #'.'        ; Check if byte is a dot
    BEQ .check_next_byte ; Continue checking next byte
    BNE .error      ; If not a dot, error

.error
    STA $FE         ; Set valid flag to false

.end
    RTS             ; Return from subroutine
