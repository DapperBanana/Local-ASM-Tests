
; Caesar cipher encryption and decryption program in 6502 Assembly language
; Encrypts and decrypts text using a shift of 3 characters

        .org $0200

        LDX #0          ; Initialize index register to 0
LOOP    LDA TEXT,X      ; Load a character from the input text
        BNE CHECK_UPPER ; Check if the character is not null terminator
        RTS            ; Return if null terminator is found
CHECK_UPPER
        CMP #$41        ; Check if the character is in uppercase range
        BCC CHECK_LOWER ; Branch to check lowercase
        CMP #$5B
        BCS SHIFT       ; Branch if character is not in uppercase range
        SEC             ; Set carry flag
        SBC #$41        ; Subtract 65 from uppercase character
        LDA #$41        ; Reset to 'A'
        CLC             ; Clear carry flag
        ADC #3          ; Add 3 to ASCII value (Caesar cipher shift)
        BPL STORE       ; Branch if positive
        /* rol */               ; Rotate left through carry
        ROR
STORE   STA CIPHER,X    ; Store encrypted character
        INX             ; Increment index
        JMP LOOP        ; Jump back to beginning of loop
CHECK_LOWER
        CMP #$61        ; Check if the character is in lowercase range
        BCC SHIFT       ; Branch to shift if out of range
        CMP #$7B
        BCS SHIFT
        SEC
        SBC #$61
        LDA #$61
        CLC
        ADC #3
        BPL STORE
        ROR
        JMP STORE
SHIFT   STA CIPHER,X
        INX
        JMP LOOP
CRYPTKEY
        .byte 0x03      ; Crypt key (shift)
TEXT    .byte 'HELLO, WORLD!', 0  ; Input text
CIPHER  .ds 14         ; Output text

        .end
