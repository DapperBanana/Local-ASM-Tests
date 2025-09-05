
        .org $0200

start   lda #0          ; initialize variables
        sta dividend
        sta divisor

        ldx #5          ; first number
        ldy #15         ; second number

loop    lda dividend    ; divide
        cmp divisor
        bcc lbl1
        jmp lbl2

lbl1    sec
        sbc dividend    ; subtract
        jmp loop

lbl2    sta dividend    ; swap
        lda divisor
        sta dividend
        lda #0
        sta divisor

        lda #remainder   ; check if remainder is zero
        cmp #0
        beq done

        jmp loop

done    lda dividend    ; display GCD
        sta $0300
        lda divisor
        sta $0301

        rts

dividend .byte 0
divisor  .byte 0
remainder .byte 0

        .org $FFFA
        .dw start       ; reset vector
