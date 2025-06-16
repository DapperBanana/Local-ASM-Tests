
        .org $2000

OP1     .dsb 1 ; operand 1
OP2     .dsb 1 ; operand 2
RESULT  .dsb 1 ; result

        .org $FFFC
        .dw START

START   lda #OP1_PROMPT
        jsr PRINT_STRING

        lda #0
        jsr READ_NUMBER
        sta OP1

        lda #OP2_PROMPT
        jsr PRINT_STRING

        lda #0
        jsr READ_NUMBER
        sta OP2

        lda #ADD_PROMPT
        jsr PRINT_STRING

        lda #'a'
        jsr GET_CHAR

        cmp #'a'
        beq ADD

        lda #'s'
        jsr GET_CHAR

        cmp #'s'
        beq SUBTRACT

        lda #'m'
        jsr GET_CHAR

        cmp #'m'
        beq MULTIPLY

        lda #'d'
        jsr GET_CHAR

        cmp #'d'
        beq DIVIDE

ADD     lda OP1
        clc
        adc OP2
        sta RESULT
        jmp DISPLAY_RESULT

SUBTRACT lda OP1
        sec
        sbc OP2
        sta RESULT
        jmp DISPLAY_RESULT

MULTIPLY lda OP1
        ldx #0
MULTIPLY_LOOP
        clc
        lda OP1
        adc RESULT
        sta RESULT
        dex
        bne MULTIPLY_LOOP
        jmp DISPLAY_RESULT

DIVIDE  lda OP1
        sec
        sbc OP2
        sta RESULT
        jmp DISPLAY_RESULT

DISPLAY_RESULT
        lda RESULT
        jsr PRINT_DECIMAL
        rts

; Subroutines

PRINT_STRING
        sta $02
        ldx #0
PRINT_CHAR_LOOP
        lda [$02],x
        beq PRINT_DONE
        jsr $FFD2
        inx
        bne PRINT_CHAR_LOOP
PRINT_DONE
        rts

PRINT_DECIMAL
        ldx #0
        stx $02
        clc
PRINT_DECIMAL_LOOP
        lda RESULT
        asl
        rol $02
        bcc PRINT_DECIMAL_NO_INC
        adc #'0'
        jsr $FFD2
        inx
PRINT_DECIMAL_NO_INC
        dex
        cpx #8
        bne PRINT_DECIMAL_LOOP
        rts

READ_NUMBER
        ldy #0
READ_NUMBER_LOOP
        lda #'0'
        jsr $FFD2
        tya
        adc #$FF
        tay
        lda $01
        cmp #'0'
        bpl READ_NUMBER_LOOP
        rts

GET_CHAR
        lda $01
        beq GET_CHAR
        rts

OP1_PROMPT .text "Enter first number: "
OP2_PROMPT .text "Enter second number: "
ADD_PROMPT .text "Select operation (a for add, s for subtract, m for multiply, d for divide): "

        .end
