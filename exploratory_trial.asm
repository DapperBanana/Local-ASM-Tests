
            .org $0600

start       ldx #$07        ; set up the loop counter
            ldy #$00        ; set up the result accumulator
loop        lda number,x   ; load the next bit of the binary number
            cmp #$01
            beq add         ; skip if bit is 0
            jsr multiply    ; multiply accumulator by 2
            jsr add_bit     ; add 1 to the accumulator
add         jsr multiply    ; multiply accumulator by 2
            dex             ; decrement the loop counter
            bpl loop        ; repeat until all bits have been processed

done        rts

number      .byte %11011010

multiply    clc
            asl y           ; multiply accumulator by 2
            rts

add_bit     clc
            adc #$01        ; add 1 to the accumulator
            rts
