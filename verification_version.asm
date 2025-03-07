
        .org $0200

        ; Accumulator
ACC     .byte $00

        ; Result
RESULT  .byte $00

        ; Input values
NUM1    .byte $00
NUM2    .byte $00

        ; Operation type
OP_TYPE .byte $00

        ; Constants
OP_ADD  .byte $01
OP_SUB  .byte $02
OP_MUL  .byte $03
OP_DIV  .byte $04

        ; Main program
START   lda #NUM1
        sta NUM1
        
        lda #NUM2
        sta NUM2
        
        lda #OP_TYPE
        sta OP_TYPE
        
        lda NUM1
        ldx NUM2
        ldy OP_TYPE
        
        cmp #OP_ADD
        bne SUB_CHECK
        
        ; Addition
        clc
        adc NUM2
        sta RESULT
        jmp PRINT_RESULT
SUB_CHECK
        cmp #OP_SUB
        bne MUL_CHECK
        
        ; Subtraction
        sec
        sbc NUM2
        sta RESULT
        jmp PRINT_RESULT
MUL_CHECK
        cmp #OP_MUL
        bne DIV_CHECK
        
        ; Multiplication
        lda NUM1
        lsr
        bcc MUL_ADD
        clc
        adc NUM1
MUL_ADD
        asl
        sta RESULT
        jmp PRINT_RESULT
DIV_CHECK
        cmp #OP_DIV
        bne PRINT_RESULT
        
        ; Division
        lda NUM1
        ldx #00
DIV_LOOP
        cmp NUM2
        bcc DIV_DONE
        sbc NUM2
        inx
        jmp DIV_LOOP
DIV_DONE
        sta RESULT
        jmp PRINT_RESULT
        
PRINT_RESULT
        lda RESULT
        jsr $ffd2  ; Print the result
        
        ; End program
        rts

        .end
