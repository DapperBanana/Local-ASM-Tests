
; Declare constants
JSON_WEB_TOKEN_MSG .ASC "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWUsImlhdCI6NDQ2MzQ1Mzc0fQ.X6tq4ZeBTprLrTN6W4ZenJX5Vr3zgO_CYKEf_7cXAw0"

; Start of program
        .org $8000

START   LDX #$00            ; Initialize index
LOOP    LDA JSON_WEB_TOKEN_MSG, X   ; Load character
        BEQ END             ; If end of string, exit
        CMP #'.             ; Check for period character
        BEQ VALID           ; If found, string is a JWT
        INX                 ; Increment index
        JMP LOOP            ; Continue looping

VALID   STA $FB             ; Store result (valid JWT)
        BRK

END     LDA #$00            ; Store result (not a valid JWT)
        STA $FB
        BRK

        .end START
