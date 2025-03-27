
; Set 1: {1, 2, 3, 4, 5}
; Set 2: {3, 4, 5, 6, 7}

        .org $0200

        lda #0
        sta $00
        lda #5
Loop1   sta $01, x
        inx
        cpx #5
        bne Loop1

        lda #0
        sta $02
        lda #5
Loop2   sta $03, x
        inx
        cpx #5
        bne Loop2

        lda #3
Loop3   lda $01, x
        cmp $03, x
        beq Skip
        dex
        inx
        sta $02, x
Skip    inx
        cpx #10
        bne Loop3

        lda #0
Print   lda $02, x
        beq Done
        jsr $ffd2
        inx
        jmp Print

Done    rts
