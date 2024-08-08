
        .org $0200

plaintext        .asciiz "HELLO, WORLD!"
ciphertext       .ds $20

key              .byte $03

start:
        ldx #$00        ; Initialize index
encrypt_loop:
        lda plaintext, x ; Load character from plaintext
        beq end_encrypt  ; Check for end of string
        cmp #$41         ; Check if uppercase
        bcc not_upper    ; Branch if not uppercase
        cmp #$5A         ; Check if within uppercase range
        bcs not_upper
        jsr encrypt      ; Encrypt uppercase letter
        bra next_char

not_upper:
        cmp #$61         ; Check if lowercase
        bcc not_letter   ; Branch if not letter
        cmp #$7A         ; Check if within lowercase range
        bcs not_letter
        jsr encrypt      ; Encrypt lowercase letter
        bra next_char

not_letter:
        sta ciphertext, x ; Copy non-letter character to ciphertext
        bra next_char

next_char:
        inx              ; Increment index
        bra encrypt_loop ; Loop

end_encrypt:
        lda #$00        ; Null-terminate ciphertext string
        sta ciphertext, x
        rts

encrypt:
        clc
        adc key          ; Add key value
        cmp #$5A         ; Check if within uppercase range
        bcc end_encrypt
        sbc #$1A         ; Subtract uppercase range
        bcc end_encrypt
        cmp #$7A         ; Check if within lowercase range
        bcc end_encrypt
        sbc #$1A         ; Subtract lowercase range
end_encrypt:
        rts

decrypt:
        sec
        sbc key          ; Subtract key value
        cmp #$41         ; Check if within uppercase range
        bcc end_decrypt
        sbc #$1A         ; Add uppercase range
        bcc end_decrypt
        cmp #$61         ; Check if within lowercase range
        bcc end_decrypt
        sbc #$1A         ; Add lowercase range
end_decrypt:
        rts
