
        .org $0600

start   lda #$00        ; Initialize random number generator
        sta $14
        lda $14
        tax

generate_password:
        jsr get_random   ; Get a random number
        and #$3F         ; Mask upper 2 bits to get alphanumeric character
        jsr print_char   ; Print character
        inx
        cpx #$0A         ; Check if password length is reached
        bne generate_password
        
        rts

print_char:
        cmp #$0A         ; Check if character is a number
        lda #$30
        sbc #$0A
        bcc print_character
        cmp #$1A         ; Check if character is a letter
        lda #$41
        sbc #$1A
        bcs print_character
        rts

print_character:
        adc #$20         ; Convert to ASCII character
        sta $FE         ; Output character
        rts

get_random:
        lda $14
        clc
        adc $14
        and #$7F
        tay
        sec
        sbc #$A9
        rol
        ror $14
        rts

        .end
