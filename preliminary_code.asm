
    .org $0600

start:
    lda #0
    sta valid_count
    lda #0
    sta input_index

loop:
    lda input_buffer, x
    beq end_of_string
    cmp #"0"
    bcc invalid
    cmp #"9"
    bcs invalid
    inc valid_count
    inx
    bne loop

end_of_string:
    lda valid_count
    cmp #16
    beq valid
    jmp invalid

valid:
    lda #"1"
    jsr print_char
    lda #" "
    jsr print_char
    lda #"V"
    jsr print_char
    lda #"A"
    jsr print_char
    lda #"L"
    jsr print_char
    lda #"I"
    jsr print_char
    lda #"D"
    jsr print_char
    lda #$0d
    jsr print_char
    lda #$0a
    jsr print_char
    jmp end

invalid:
    lda #"0"
    jsr print_char
    lda #" "
    jsr print_char
    lda #"I"
    jsr print_char
    lda #"N"
    jsr print_char
    lda #"V"
    jsr print_char
    lda #"A"
    jsr print_char
    lda #"L"
    jsr print_char
    lda #"I"
    jsr print_char
    lda #"D"
    jsr print_char
    lda #$0d
    jsr print_char
    lda #$0a
    jsr print_char

end:
    rts

print_char:
    sta $fe
    rts

input_buffer:
    .byte "1234567890123456", $00
    valid_count:
    .byte 0
    input_index:
    .byte 0

    .end
