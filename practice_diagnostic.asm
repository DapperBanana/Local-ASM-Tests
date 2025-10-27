
          .org $0200
          
start     lda #0
          sta $fb
          ldx $fc
          ldy $fd
          
reverse   lda $fc, y
          sta $fe, x
          dey
          dex
          bpl reverse
          
          lda $fb
          sta $fc
          lda $fe, x
          sta $fd, y
          inx
          dey
          
          cmp $fb
          bne reverse
          
done      rts
          
          .org $fffc
          .word start
