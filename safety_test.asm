
        .org $2000
numbers .byte $03, $05, $07
result  .byte $00

        ldx #0
loop    lda numbers,x
        cmp $00
        beq end      ; check if reached end of list
        jsr calculate_lcm
        inx
        bra loop

end:
        lda result      ; result is stored at address $2002
        sta $2002

        rts

calculate_lcm:
        pha         ; save A register
        lda result
        ldy numbers,x

        jsr gcd       ; calculate GCD
        sta temp       ; store result in temp variable
        lda result
        clc
        lda temp
        jsr divide     ; divide result by GCD
        sta result

        lda result
        ldy numbers,x
        jsr multiply   ; multiply result by current number in list

        pla         ; restore A register
        rts

gcd:
        cmp #$00
        beq end_gcd
        sec
        sbc numbers,x
        jmp gcd

end_gcd:
        rts

divide:
        lsr
        bcc shift_done
        sec
        sbc temp

shift_done:
        ror
        cmp temp
        bcs divide

        rts

multiply:
        clc
        adc result
        sta result

        rts

temp    .byte $00
