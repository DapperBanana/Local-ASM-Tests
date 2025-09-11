
            .org $2000

inputString  .asciiz "HELLO"
isIsogram    .byte 0

            ldx #0
loop        lda inputString, x
            beq done
            inx
checkRepeat cpx #6
            beq isogramFound
            lda inputString, x
            ldy x
compare     cpy x
            bne checkRepeat
            jmp notIsogram
isogramFound inc isIsogram
            jmp loop
notIsogram  lda #0
            jmp done
done        rts
