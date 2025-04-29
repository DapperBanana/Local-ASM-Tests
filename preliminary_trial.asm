
    .org $2000
    
encrypt_decrypt:
    LDX #0          ; Initialize index
loop:
    LDA text,X      ; Load character from text
    CMP #0          ; Check for end of string
    BEQ end        ; If end of string, exit loop
    
    SEC
    SBC #key        ; Perform Caesar cipher encryption/decryption
    STA text,X      ; Store encrypted/decrypted character back
    
    INX             ; Increment index
    JMP loop        ; Repeat for next character

end:
    RTS

text:
    .asciiz "HELLO, WORLD!"    ; Text to encrypt/decrypt
key:
    .byte 3                    ; Caesar cipher key

