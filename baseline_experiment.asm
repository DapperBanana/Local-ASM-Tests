
        .text
        .globl _start

_start:
        lda #4              ; Set shift amount to 4
        sta shift_amount

        jsr encrypt_text    ; Encrypt the text
        jsr decrypt_text    ; Decrypt the text

_done:
        brk

encrypt_text:
        ldx #0              ; Initialize index to 0

encrypt_loop:
        lda text, x         ; Load character from text
        cmp #0              ; Check for null terminator
        beq encrypt_done    ; If null terminator, done encrypting

        clc
        adc shift_amount    ; Add the shift amount
        sta encrypted_text, x ; Store encrypted character

        inx                 ; Increment index
        bne encrypt_loop    ; Loop back
encrypt_done:
        rts

decrypt_text:
        ldx #0              ; Initialize index to 0

decrypt_loop:
        lda encrypted_text, x ; Load character from encrypted text
        cmp #0              ; Check for null terminator
        beq decrypt_done    ; If null terminator, done decrypting

        sec
        sbc shift_amount    ; Subtract the shift amount
        sta decrypted_text, x ; Store decrypted character

        inx                 ; Increment index
        bne decrypt_loop    ; Loop back
decrypt_done:
        rts

.text
.align 2
text:
        .asciiz "Hello, World!"
        .byte 0

.align 2
encrypted_text:
        .space 20

.align 2
decrypted_text:
        .space 20

shift_amount:
        .byte 0
