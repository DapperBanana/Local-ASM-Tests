
    .org $0200

start:
    ; Clear memory
    lda #$00
    ldx #$00
    ldy #$00
    clear_memory_loop:
        sta result_table, x
        dex
        bpl clear_memory_loop

    ; Load string address
    lda #<input_string
    ldx #>input_string
    sta string_addr
    stx string_addr+1

    ; Loop through string
    lda (string_addr), y
    beq end_of_string
    cmp #$20  ; Check for space delimiter
    beq next_word
    inx
process_word:
    ; Increment word count
    clc
    lda result_table, x
    adc #$01
    sta result_table, x

    ; Continue processing word
    iny
    lda (string_addr), y
    bne process_word
    bne end_of_string

next_word:
    ; Skip spaces
    iny
    lda (string_addr), y
    cmp #$20
    beq end_of_string
    bne process_word

end_of_string:
    ; Print result table
    ldx #$00
print_result_table_loop:
    lda result_table, x
    beq end_program
    jsr print_number
    inx
    jmp print_result_table_loop

print_number:
    ; Convert number to ASCII and print
    clc
    lda #10
    jsr devide_by_10

    ror
    adc #48
    jsr print_ascii

    ror
    adc #48
    jsr print_ascii
    rts

devide_by_10:
    cmp #0
    bcc done_dividing
    sec
    sbc #10
    inc devide_by_10
    jmp devide_by_10

done_dividing:
    rts

print_ascii:
    sta $d020
    rts

end_program:
    rts

input_string:
    .asciiz "hello world hello stack overflow hello world stack"

result_table:
    .fill 255, 0
