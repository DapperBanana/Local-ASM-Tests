
         processor 6502
         org $1000

start    lda $01      ; load side length of heptagon into accumulator
         sta side

         lda side
         clr_side         lda #$00
         sta area          lda #$00
         sta result

         ldx #7        ; heptagon has 7 sides
loop     lda side      ; get the side length
         clc
         adc area      ; add the previous calculated area
         sta area      ; store the updated area
         lda area
         asl           ; multiply by 2 for the area of a heptagon
         sta area

         dex
         bne loop

         lda area
         sta result

end      brk

clr_side lda #$00
         sta side
         rts
side     .byte 0
area     .byte 0
result   .byte 0

         end start
