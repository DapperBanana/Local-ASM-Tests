
        .org $0200

list1   .byte $01, $02, $03, $04, $05
list1_end equ *

list2   .byte $03, $04, $05, $06, $07
list2_end equ *

result  .ds 5

start   lda #list1
        sta $f0
        lda #list1_end
        sta $f1

loop1   lda ($f0),y
        beq end1
        sta $fb
        lda #list2
        sta $f2
        lda #list2_end
        sta $f3
        
loop2   lda ($f2),y
        beq next2
        cmp $fb
        beq common
next2   iny
        iny
        cmp $f3
        beq loop1
        bne loop2

common  sta $fa
        inc $fa
        ldx $fa
        lda $fb
        sta result,x
        lda #list1
        sta $f2
        lda #list1_end
        
end1    lda #list2
        sta $f0
        lda #list2_end
        sta $f1
        dec $fa
        jmp loop1

end     brk

        .end
