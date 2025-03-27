
    .org $1000
start:
    lda #$00
    sta count
    ldx #$00
    ldy #$00

next_char:
    lda input_buffer, x
    beq end_of_string
    cmp #'<'
    beq start_tag
    inx
    jmp next_char

start_tag:
    lda input_buffer, x
    cmp #'!'
    bne invalid_xml
    inx
    lda input_buffer, x
    cmp #'D'
    bne invalid_xml
    inx
    lda input_buffer, x
    cmp #'O'
    bne invalid_xml
    inx
    lda input_buffer, x
    cmp #'C'
    bne invalid_xml
    inx
    lda input_buffer, x
    cmp #'T'
    bne invalid_xml
    inx
    lda input_buffer, x
    cmp #'Y'
    bne invalid_xml
    inx
    lda input_buffer, x
    cmp #'P'
    bne invalid_xml
    inx
    lda input_buffer, x
    cmp #'E'
    bne invalid_xml

    ; Check for closing tag
    inx
    lda input_buffer, x
    cmp #'['
    bne invalid_xml
    inx
    lda input_buffer, x
    cmp #'C'
    bne invalid_xml
    inx
    lda input_buffer, x
    cmp #'L'
    bne invalid_xml
    inx
    lda input_buffer, x
    cmp #'O'
    bne invalid_xml
    inx
    lda input_buffer, x
    cmp #'S'
    bne invalid_xml
    inx
    lda input_buffer, x
    cmp #'E'
    bne invalid_xml
    inx
    lda input_buffer, x
    cmp #' '
    bne invalid_xml
    inx

    ; Check for closing tag
    lda input_buffer, x
    cmp #']'
    bne invalid_xml
    inx
    lda input_buffer, x
    cmp #']'
    bne invalid_xml
    inx
    lda input_buffer, x
    cmp #'>'
    bne invalid_xml

    jmp valid_xml

invalid_xml:
    lda #$01
    jsr end_program

valid_xml:
    lda #$00

end_program:
    sta $0200
    lda #$ff
    ldy #$00
    rts

end_of_string:
    lda #$00
    jsr end_program

input_buffer:
    .byte "<!DOCTYPE [CLOSE ]]>"

count:
    .byte $00

    .end start
