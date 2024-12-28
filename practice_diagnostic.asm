
.segment "CODE"

    .proc process_data
    process_data:
        lda #0
    loop:
        ldx $2000
        jsr print_char
        inx
        stx $2000
        lda $2000
        bne loop
        rts

    .proc print_char
    print_char:
        ; Print character in accumulator
        sta $d010
        rts

.segment "DATA"
    .ds 256  ; Data buffer

.segment "VECTORS"
    .dw $0000 ; Reset vector

.end
