
; Start of program
        .org $1000     ; Start program at memory address $1000

token_check:
        LDX #$00       ; Initialize index to 0
        LDY #$00       ; Initialize counter for number of periods found
        LDA #$00       ; Initialize flag for valid JWT
loop:
        LDA input,X    ; Load next character from input string
        BEQ end        ; If end of string is reached, exit loop
        
        CMP #','       ; Check if character is a comma
        BEQ error      ; If comma is found, token is not valid
        
        CMP #'.'       ; Check if character is a period
        BEQ increment  ; If period is found, increment counter
        
        INX            ; Increment index
        JMP loop       ; Continue checking characters in string
        
increment:
        INX            ; Increment index
        INY            ; Increment period counter
        JMP loop       ; Continue checking characters in string
        
end:
        CPY #$2        ; Check if two periods are found
        BNE error      ; If not, token is not valid
        
        LDA #$01       ; Set flag for valid JWT
        RTS            ; Return from subroutine
        
error:
        LDA #$00       ; Set flag for invalid JWT
        RTS            ; Return from subroutine
        
input:
        .byte "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6Ikp
