
        .inesprg 1
        .inesmir 1

        .org $8000

array   .byte 5,3,8,2,3,4,9,1,6,7
length  = *-array

        .org $c000

count   .byte 0
maxLen  .byte 0
maxIdx  .byte 0

start
        lda #0
        sta count
        lda #0
        sta maxLen

loop    lda count
        cmp length
        beq end

        lda #0
        sta maxIdx

subloop lda maxIdx
        cmp count
        beq next

        lda array,x
        sta $00

        lda maxLen
        sta $01

        dex
subloop2 lda array,x
        cmp $00
        bcc skip

        lda x
        sta $00
        
        lda $01
        clc
        adc #1
        sta $01

skip    dex
        bpl subloop2

        lda $01
        sta maxLen

        lda maxIdx
        cmp count
        bcc next

        lda count
        sta maxIdx

next    lda count
        clc
        adc #1
        sta count

        jmp loop

end     rts
