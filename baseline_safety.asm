
    .org $0200

sentence      .byte "Hello World", 0
              .byte 0
reversed      .byte 0

start         lda #<sentence
              ldx #>sentence
              ldy #<reversed
              ldx #>reversed

loop          lda (x),y
              beq end
              iny
              cpy #0
              bne loop
              dey
              jsr reverse_word
              iny
              ldx #>sentence
              jsr find_next_word
              jmp loop

end           lda #>reversed
              jsr print_reverse

              rts

reverse_word  stx temp
              dex
              dey

reverse_loop  lda (x),y
              sty temp
              lda temp,x
              sta (x),y
              sta temp,x
              dey
              bne reverse_loop

              rts

find_next_word iny
              lda (x),y
              cpy #0
              bne find_next_word

              rts

print_reverse lda (x),y
              beq print_end
              jsr putchar
              iny
              bne print_reverse
              
print_end     rts

putchar       lda #14
              jsr $ffd2
              rts
              
temp          .byte 0
