
        .org $0600

celsius         .byte $10
fahrenheit      .byte 0

temp            .byte 0

        .text
        .proc main
        lda celsius
        jsr convert
        
        lda fahrenheit
        sta $fb
        
        jmp $fffc
        
        .endproc

        .proc convert
        ; Fahrenheit = Celsius * 9 / 5 + 32
        lda celsius
        clc
        adc celsius
        asl
        asl
        asl
        sta temp
        
        lda temp
        asl
        asl
        asl
        clc
        adc celsius
        sta temp
        
        lda temp
        clc
        adc #32
        sta fahrenheit
        
        rts
        .endproc
