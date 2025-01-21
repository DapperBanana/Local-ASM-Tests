
; Check if a given string is a valid email address
; Assume the string is stored in memory starting at address $2000
; The result will be stored in the accumulator: 1 if valid email address, 0 otherwise

LDA #$00          ; Initialize accumulator to 0
LDX #$00          ; Initialize index X to 0
LDY #$00          ; Initialize index Y to 0

check_email:
LDA $2000, X     ; Load current character into A
CMP #$20          ; Check if character is a space
BEQ not_valid     ; If yes, not a valid email address
CMP #$40          ; Check if character is '@'
BEQ check_domain  ; If yes, check domain part
CMP #$2E          ; Check if character is a period
BEQ check_domain  ; If yes, check domain part
CMP #$30          ; Check if character is a digit
BCC not_valid     ; If no, not a valid email address
CMP #$39
BCS valid_char    ; If yes, valid character

invalid_char:
LDX #1            ; Set index X to 1 to indicate invalid character
JMP end_check

valid_char:
INX              ; Increment index X
CPX #64           ; Check if index X is greater than 64 characters
BCC check_email   ; If no, continue checking email

valid_email:
LDA #1            ; Set accumulator to 1 to indicate valid email address

end_check:
RTS

check_domain:
LDA $2000, X     ; Load current character into A
CMP #$2E          ; Check if character is a period
BEQ invalid_char  ; If yes, invalid character
JMP check_email   ; Continue checking email

not_valid:
LDA #$00          ; Set accumulator to 0 to indicate not a valid email address
JMP end_check     ; End checking email
