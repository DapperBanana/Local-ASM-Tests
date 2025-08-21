
; Check for valid credit card number
; Input: Address of the string in memory
; Output: Carry flag set if valid, clear if not valid

start:
    LDA #$00            ; initialize counter
    STA counter
loop:
    LDA (input), Y      ; load character from string
    CMP #0              ; check for null terminator
    BEQ end            ; if null terminator, end loop
    CMP #'0'            ; check if character is a digit
    BCC invalid        ; if not a digit, invalidate
    CMP #'9'
    BCS invalid
    INY                  ; move to next character
    BNE loop
    JMP loop

invalid:
    CLC                  ; clear carry flag to indicate invalid
    RTS

end:
    SEC                  ; set carry flag to indicate valid
    RTS

input:
    .byte "1234567812345678", 0       ; example credit card number

counter:
    .byte $00
