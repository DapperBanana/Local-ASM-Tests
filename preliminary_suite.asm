
    .org $200

token_check:
    LDX #$00        ; Initialize index for loop

loop:
    LDA input,X     ; Load a character from the input string
    CMP #127        ; Check if character is ASCII valid
    BEQ invalid     ; If character is invalid, branch to invalid
    CMP #0          ; Check if character is end of string
    BEQ valid       ; If character is end of string, branch to valid

    INX             ; Increment index
    JMP loop        ; Repeat loop

valid:
    LDA #$01        ; Set return value to 1 (valid token)
    RTS

invalid:
    LDA #$00        ; Set return value to 0 (invalid token)
    RTS

input:
    .byte "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWJqZWN0Ijo4fQ.8y1z7f_Q69xuZjsmxR7TGgQ0aQH3fKUJ4w6uQC0uPLM",0
