
; 6502 Assembly program to check if a given string is a valid JSON Web Token (JWT)

    .org $1000

check_jwt:
    lda #0          ; Initialize counter variable
    sta counter
    
loop:
    lda input, x    ; Load character at current position
    
    ; Check for end of string
    beq end_of_string
    
    ; Check if character is a valid JWT character
    cmp #33         ; Check if character is ASCII value of '!'
    bcc invalid_char ; Character is not valid
    
    cmp #126        ; Check if character is ASCII value of '~'
    bcs invalid_char ; Character is not valid
    
    inx             ; Increment index
    bne loop        ; Continue loop
    
end_of_string:
    lda #1          ; Set flag to indicate valid JWT
    rts

invalid_char:
    lda #0          ; Set flag to indicate invalid JWT
    rts

input:
    .byte "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkhhcmRmZmEifQ.Cxq7EFXfbxd6erOpK7m62ZawDYV4aJ5vRwkUPEjF_ng", 0
    
counter:
    .byte 0

    .end
