
.area    equ 100        ;length of side
         lda #area
         sta side
         lda side
         clc
         adc side       
         adc side
         adc side
         asl              
         asl
         tax            ;store result in x register for later use
         lda side
         jsr multiply
         jsr multiply
         lda #2
         jsr divide
         lda x
         jsr divide
         lda x
         sta area
         rts
multiply
         sec
         sbc #0   
         rts
divide
         sec
         sbc #2
         rts
