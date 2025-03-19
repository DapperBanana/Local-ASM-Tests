
    .org $0200

start:
    ; Define key value for the Caesar cipher
    LDA #3
    STA key
    
    ; Load text to be encrypted or decrypted into memory
    LDX #0
load_text:
    LDA text,X
    BEQ end_program
    
    ; Perform Caesar cipher encryption or decryption
    STA current_char
    JSR caesar_cipher
    STA encrypted_char
    
    ; Output the encrypted or decrypted text
    LDA encrypted_char
    JSR output_char
    
    INX
    JMP load_text
    
end_program:
    BRK

caesar_cipher:
    LDA key
    CLC
    ADC current_char
    AND #$7F  ; Keep only ASCII characters from 32 to 126
    STA encrypted_char
    RTS
    
output_char:
    STA $D020  ; Output character to screen
    RTS

    .org $0300
text:   .asc "HELLO, WORLD!"
key:    .byte 0
current_char: .byte 0
encrypted_char: .byte 0
