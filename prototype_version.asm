
        .org    $0200
start   lda     #count
        sta     count
        
        ldx     #0
        lda     numbers,x
        sta     result
        
        inx
loop    lda     numbers,x
        cmp     result
        bcc     update
        inx
        bra     loop
        
update  sta     result
        lda     #0
        sta     lo
        lda     count
        sta     hi
        inx
        ldx     #0
reset   lda     numbers,x
        cmp     result
        bcc     skip
        adc     #1
        sta     hi
skip    dex
        bne     reset
        
        lda     count
        sec
        sbc     #2
        ldx     #0
        lda     lo
        clc
adjust  adc     numbers,x
        inx
        bne     adjust
        sta     lo
        lda     hi
        ldx     #0
        jsr     divide
        
done    hlt

divide  lsr     lo
        ror     hi
        bcc     nosub
        sbc     numbers,x
        inc     hi
nosub   dex
        bpl     divide
        rts

numbers .byte   $0A, $04, $06, $02, $08, $0F, $07
result  .byte   $00
lo      .byte   $00
hi      .byte   $00
count   .byte   7
