
        .org $1000   ; Start executing at memory address $1000

password_length = $08   ; Length of the password
random_seed     = $FF   ; Random seed value

        lda #password_length
        sta length_counter

generate_password:
        lda random_seed
        adc #$73       ; Random value between 'A' and 'Z'
        sta random_seed
        
        cmp #$5B
        bcc generate_digit

generate_uppercase:
        sta password, x
        inx
        dec length_counter
        bne generate_password
        
        lda #8
        sta length_counter
        bra generate_password

generate_digit:
        lda random_seed
        adc #$30       ; Random value between '0' and '9'
        sta random_seed
        bra generate_uppercase

password:
        .block $08

        .end
