
.org $0200

start:
    lda #0
    sta rand_seed ; Initialize random number generator seed
    ldx #0
    ldy #password_length ; Set password length
loop:
    jsr generate_random ; Get a random character
    sta password, y
    iny
    cpy #password_length
    bne loop
end:
    rts

generate_random:
    lda rand_seed
    clc
    adc #17 ; Random range (ASCII value of 'A' to 'Z')
    sta rand_seed
    and #$1F ; Mask to keep within range
    rts

rand_seed: .byte 0
password_length: .byte 8
password: .byte 8

.include "file.i"

