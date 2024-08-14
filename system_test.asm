
; Program to Encrypt and Decrypt text using Caesar cipher

        .org $0200
        .cpu 6502

start:  LDX #$00               ; Initialize index to 0
        LDA text,X             ; Load a character from text
        BEQ end                ; If character is null, exit
        SEC                     ; Set carry flag
        SBC #$10               ; Subtract 16 to encrypt
        STA encryptedText,X    ; Store encrypted character
        INC X                   ; Increment index
        JMP start               ; Continue encrypting

end:    STX length             ; Store length of text
        LDA #$00               ; Initialize index to 0
        LDX #$00               ; Initialize index to 0

decrypt: 
        LDA encryptedText,X    ; Load encrypted character
        BEQ final              ; If character is null, exit
        CLC                     ; Clear carry flag
        ADC #$10                ; Add 16 to decrypt
        STA decryptedText,X     ; Store decrypted character
        INC X                   ; Increment index
        JMP decrypt            ; Continue decrypting

final:  BRK                     ; Exit program

text:   .ascii "Hello, World!"  ; Text to encrypt
encryptedText: .blkw 100        ; Encrypted text
decryptedText: .blkw 100        ; Decrypted text
length: .byte 0                 ; Length of text

        .end
