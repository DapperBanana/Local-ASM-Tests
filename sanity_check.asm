
        .org $c000

main    ldx #$ff      ; Initialize random number generator seed
        stx random_seed
        
        lda #$06      ; Set password length to 6 characters
        ldx #$00
gen_pass
        jsr generate_char   ; Generate one random alphanumeric character
        sta password, x
        inx
        cpx #$06           ; Check if password has reached desired length
        bne gen_pass
        
        lda #$00      ; Null terminate the string
        sta password, x
        
done    lda #<password   ; Print password
        ldx #>password
        jsr print_string

        rts

generate_char
        lda random_seed  ; Generate random number between 0 and 61
        lsr
        lsr
        lsr
        lsr
        lsr
        lsr
        eor random_seed
        and #$3f
        sta rand_num

        lda rand_num
        cmp #$1a       ; Check if the character is a digit
        bcc not_digit
        clc
        adc #$07       ; Convert to letter
not_digit
        adc #$30       ; Convert to ASCII
        sta rand_char

        rts

print_string
        ldy #$00
loop    lda (x), y     ; Print character
        beq end
        jsr $ffd2      ; KERNAL routine for output
        iny
        bne loop
end     rts

password
        .ds 7          ; Array to store password
rand_char .byte 0      ; Variable to store random character
rand_num  .byte 0      ; Variable to store random number
random_seed .byte 0    ; Seed for random number generator
