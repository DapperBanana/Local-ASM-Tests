
    .org $0600

reset:
    sei
    cld

    lda #$00
    sta $fb
    sta $fc

loop:
    lda $fb
    cmp #$08
    beq done
    
    jsr generate_random_char
    
    lda $fd
    sta $fb
    
    jmp loop

done:
    brk

generate_random_char:
    lda $00
    clc
    adc $fd
    sta $fd
    lda $fd
    and #$1f
    cmp #$0a
    bcc is_digit
    clc
    adc #$07
    
is_digit:
    adc #$30
    rts

    .org $fffc
    .word reset
