
        .org $0600

start   ldx #radius
        lda #2
        jsr multiply      ; multiply radius by 2
        tax
        
        lda #22
        jsr square        ; square the result
        tay
        
        lda #3
        jsr divide        ; divide by 3
        tay
        
        sta $01           ; store result in memory location $01

        rts

radius  .byte $05

multiply
        ; Multiply X with A and Save it in Y
        tax
        lda #0
loop    clc
        adc x
        dey
        bne loop
        rts

square
        ; Square A and Save it in Y
        tay
        lda #0
loop2   clc
        adc y
        dey
        bne loop2
        rts

divide
        ; Divide A by X and Save it in Y
        lda #0
loop3   sec
        sbc x
        dey
        bcc loop3
        rts
