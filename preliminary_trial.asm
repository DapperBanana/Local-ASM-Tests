
        .org $0200

start   lda #5          ; Load radius of cone (for example, 5)
        sta radius

        lda #10         ; Load height of cone (for example, 10)
        sta height

        jsr calculate_volume  ; Call subroutine to calculate volume

        lda volume      ; Load result into accumulator
        jsr print_result    ; Call subroutine to print result

end     rts

calculate_volume
        lda radius      ; Load radius into accumulator
        ldx radius      ; Copy radius to X register
        lda height      ; Load height into accumulator
        jsr multiply        ; Call subroutine to multiply radius * radius
        sta temp1

        ldx #6          ; Load constant 1/3 into X register
        lda temp1       ; Load result of radius * radius into accumulator
        jsr divide      ; Call subroutine to divide volume by 3
        sta volume      ; Store volume

        rts

multiply
        clc
        lda #$00        ; Clear accumulator
        loop
        adc temp1       ; Add temp1 to accumulator
        dex
        bne loop
        rts

divide
        ldx #0
        lda #$00
        ldy #$00
        loop
        clc
        lda volume
        adc temp1
        bcc no_carry
        inx
        asl temp1
        jmp loop
        no_carry
        dey
        jmp loop

print_result
        lda volume
        jsr print_value
        lda volume+1
        jsr print_value
        lda volume+2
        jsr print_value
        rts

print_value
        tax
        and #$F0
        lsr
        lsr
        lsr
        lsr
        ldx
        ora #$30
        jsr $fda2
        lda volume
        jsr $fda2
        lda #$2C
        jsr $fda2
        rts

radius  .byte 0
height  .byte 0
temp1   .byte 0
volume  .byte 0

        .end
