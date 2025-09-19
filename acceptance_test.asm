
    .org $0200

str1_ptr        .dw $0300
str2_ptr        .dw $0310
str3_ptr        .dw $0320
str4_ptr        .dw $0330
str5_ptr        .dw $0340

result          .ds 25

entry:
    ldx #0

loop:
    lda str1_ptr,x
    cmp #$00
    beq done

    lda str2_ptr,x
    cmp #$00
    beq done

    cmp str1_ptr,x
    bne done

    lda str3_ptr,x
    cmp #$00
    beq done

    cmp str1_ptr,x
    bne done

    lda str4_ptr,x
    cmp #$00
    beq done

    cmp str1_ptr,x
    bne done

    lda str5_ptr,x
    cmp #$00
    beq done

    cmp str1_ptr,x
    bne done

    sta result,x

    inx
    jmp loop

done:
    lda #'$00'
    sta result,x

    rts
