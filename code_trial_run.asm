
; 6502 Assembly program to encrypt and decrypt text using the Caesar cipher

        .org $0200     ; Start address of the program
        .word START    ; Set the reset vector to the start of the program

PLAIN_TEXT .byte "HELLO, WORLD!",0  ; Plain text to be encrypted
CIPHER_TEXT .byte 16,"",0   ; Encrypted text and shift value
DECRYPTED_TEXT .byte 0

START:  
        LDX #0          ; Initialize X register to 0 (for indexing)
ENCRYPT_LOOP:
        LDA PLAIN_TEXT,X    ; Load the next character of the plain text
        BEQ END_ENCRYPT     ; Check for end of string
        JSR ENCRYPT_CHAR    ; Encrypt the character
        STA CIPHER_TEXT,X   ; Store the encrypted character
        INX                 ; Increment index
        JMP ENCRYPT_LOOP    ; Repeat for the next character

END_ENCRYPT:
        STX CIPHER_TEXT     ; Store the shift value at the beginning of the encrypted text

        LDX #0              ; Reset X register
DECRYPT_LOOP:
        LDA CIPHER_TEXT,X   ; Load the next character of the encrypted text
        BEQ END_DECRYPT     ; Check for end of string
        JSR DECRYPT_CHAR    ; Decrypt the character
        STA DECRYPTED_TEXT,X; Store the decrypted character
        INX                 ; Increment index
        JMP DECRYPT_LOOP    ; Repeat for the next character

END_DECRYPT:
        BRK                 ; End of program

ENCRYPT_CHAR:
        SEC                 ; Set carry flag
        SBC #65             ; Subtract 'A' to normalize character to range 0-25
        CLC                 ; Clear carry flag
        ADC CIPHER_TEXT     ; Add the shift value
        AND #$1F            ; Mask out any overflow
        ADC #65             ; Add 'A' back to get the encrypted character
        RTS

DECRYPT_CHAR:
        SEC                 ; Set carry flag
        SBC #65             ; Subtract 'A' to normalize character to range 0-25
        CLC                 ; Clear carry flag
        SBC CIPHER_TEXT     ; Subtract the shift value
        AND #$1F            ; Mask out any overflow
        ADC #65             ; Add 'A' back to get the decrypted character
        RTS

        .end
