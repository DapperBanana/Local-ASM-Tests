
        .org $1000

start   ldx #$00              ;initialize base length
        ldy #$00              ;initialize height

input   lda base_length      ;input base length
        sta $10              ;store it in memory location $10
        lda height           ;input height
        sta $11              ;store it in memory location $11

        lda $10              ;load base length
        ldx #$03              ;set loop counter

loop    cmp #$00              ;check if base length is 0
        beq output           ;if yes, jump to output

        clc
        lda $11              ;load height
        adc $10              ;add base length
        sta $11              ;store the result in height

        dex
        bne loop

output  lda $11              ;load the final result (area)
        sta area             ;store it in memory location 'area'

end     jmp end              ;infinite loop

        .org $2000

base_length .byte $06      ;base length of the tetrahedron
height      .byte $04      ;height of the tetrahedron
area        .byte $00      ;variable to store area
