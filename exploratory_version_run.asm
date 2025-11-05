
.org $0200

array    .byte $03, $09, $12, $25, $32, $48, $51, $67, $74, $89

start    lda #0          ; initialize low index
         sta low
        
         lda #9          ; initialize high index
         sta high

         lda #32         ; search element
         sta search

loop     lda low
         clc
         adc high
         asl
         tax             ; calculate mid = (low + high)/2
        
         lda array, x    ; load mid element
         cmp search
         beq found       ; element found
        
         bcc below_mid
        
         lda high
         clc
         adc #1
         sta low
         jmp loop
        
below_mid lda x

         sta high
         dec high
         jmp loop

found    lda search
         sta result

done     brk

result   .byte 0

low      .byte 0
high     .byte 0
search   .byte 0

.end
