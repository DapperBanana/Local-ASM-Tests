
        .org $1000

data    .byte $05, $02, $08, $12, $04, $07     ; List of numbers
result  .byte $00                              ; Variable to store the median
count   .byte 6                                ; Number of elements in the list

        lda #0                                 ; Initialize index
        sta $00

        ldy #0                                 ; Initialize sum variable
        sta $01
        sta $02

loop    lda data, y                            ; Load next number from list
        clc
        adc $01                                ; Add to sum
        sta $01
        lda $00
        adc #$01
        sta $00

        lda data, y                            ; Load next number from list
        adc $02                                ; Add to sum
        sta $02

        iny                                     ; Increment index
        cmp count
        bne loop

        lda $01                                 ; Divide sum by number of elements
        lsr
        lsr
        sta $01

        lda $02
        lsr
        lsr
        sta $02

        clc
        adc $01                                ; Add both halves of sum together
        sta $01

        lda #$02                                ; Divide sum by 2 to find the median
        lsr
        sta $00

        lda $01                                 ; Store result in memory
        sta result

done    jmp done
