
        .org $0200

list1   .byte 10, 20, 30, 40, 50
list2   .byte 5, 10, 15, 20, 25

n       .byte 5
sumx    .word 0
sumy    .word 0
sumxy   .word 0
sumx2   .word 0
sumy2   .word 0
corr    .word 0

        ldx #0
loop    lda list1,x
        clc
        adc sumx
        sta sumx
        lda list2,x
        clc
        adc sumy
        sta sumy

        lda list1,x
        clc
        adc list2,x
        sta temp
        clc
        adc sumxy
        sta sumxy
        lda temp
        clc
        adc temp
        sta temp
        clc
        adc sumx2
        sta sumx2

        lda list2,x
        clc
        adc list2,x
        sta temp
        clc
        adc sumy2
        sta sumy2
        lda temp
        clc
        adc temp
        sta temp
        clc
        adc sumy2
        sta sumy2

        inx
        cpx n
        bne loop

        lda sumx
        clc
        adc #0
        ldx n
        txa
        sec
        sbc #1
        jsr div

        lda sumy
        clc
        adc #0
        ldx n
        txa
        sec
        sbc #1
        jsr div

        lda sumxy
        clc
        adc #0
        ldx corr
        txa
        sec
        sbc #1
        jsr div

        lda sumx2
        jsr sqrt
        sta temp
        lda sumy2
        jsr sqrt
        clc
        adc temp
        jsr div
        
        sta corr

        jmp $

div     cmp #$01
        bcc done
        sbc #$01
        inx
        jsr div
        inc
done    rts

sqrt    cmp #$01
        bcc done
        sbc #$01
        inx
        jsr sqrt
        inc
        cmp #
        bcs done
        lda #
        clc

done    rts
temp    .byte 0
