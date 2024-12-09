
        .org $0200
input:  .byte "HELLO, WORLD!"
output: .byte 16 dup (0)

        .org $0300
        .array key_tab 256, 1

start:  lda #$00          ; Load accumulator with zero
        sta $0400         ; Clear screen
        ldx #$03          ; Set key value
        lda #$0200        ; Load address of input text
        sta $01           ; Lower byte of address
        lda #$02          ; Load high byte of address
        sta $02
loop:   lda ($01), x      ; Load character from input text
        cmp #$00          ; Check for null terminator
        beq done          ; Exit loop if end of string
        jsr encrypt       ; Encrypt the character
        sta ($02), x      ; Store the encrypted character
        inx               ; Increment index
        bra loop          ; Continue loop
done:   lda #$0300        ; Load address of output text
        ldx #$00
        lda ($02), x      ; Load encrypted character
        cmp #$00          ; Check for null terminator
        beq print         ; Exit loop if end of string
        jsr decrypt       ; Decrypt the character
        sta ($02), x      ; Store the decrypted character
        inx               ; Increment index
        bra done          ; Continue loop

encrypt:ldy key_tab, x   ; Load key value
        clc               ; Clear carry flag
        adc #$41          ; Add ASCII value of 'A'
        cmp #$5B          ; Check if character is beyond 'Z'
        bcc wrap          ; Wrap around if beyond 'Z'
        jmp store

decrypt:ldy key_tab, x   ; Load key value
        sec               ; Set carry flag
        sbc #$41          ; Subtract ASCII value of 'A'
        cmp #$20          ; Check if character is below 'A'
        bcc wrap          ; Wrap around if below 'A'
        jmp store

wrap:   sbc #$1A          ; Subtract 26 to wrap around
store:  ror               ; Rotate right to get ASCII value
        ror               ; of encrypted/decrypted character
        ror
        ror
        sta $03           ; Store the result
        lda $03           ; Load the result
        rts               ; Return

print:  lda #$0300
        ldx #$00
print_loop:
        lda ($02), x      ; Load character from output text
        jsr $ffd2         ; Print character to screen
        inx               ; Increment index
        cmp #$00          ; Check for null terminator
        bne print_loop    ; Continue loop
        rts

        .org $0400
        .array key_tab 256, 1
