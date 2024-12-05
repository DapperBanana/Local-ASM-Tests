
MEMORY_START = $0200

        .org MEMORY_START

numeral      .byte $00
result       .byte $00

start:
        ldx #0
parse_loop:
        lda numeral,x
        beq finished
        cpx #6
        bcs finished

        ; Check for valid Roman numeral characters
        cmp #'I'
        beq add_one
        cmp #'V'
        beq add_five
        cmp #'X'
        beq add_ten
        cmp #'L'
        beq add_fifty
        cmp #'C'
        beq add_hundred
        cmp #'D'
        beq add_five_hundred
        cmp #'M'
        beq add_thousand
        jmp invalid_numeral

add_one:
        lda result
        clc
        adc #1
        sta result
        jmp next_numeral

add_five:
        lda result
        clc
        adc #5
        sta result
        jmp next_numeral

add_ten:
        lda result
        clc
        adc #10
        sta result
        jmp next_numeral

add_fifty:
        lda result
        clc
        adc #50
        sta result
        jmp next_numeral

add_hundred:
        lda result
        clc
        adc #100
        sta result
        jmp next_numeral

add_five_hundred:
        lda result
        clc
        adc #500
        sta result
        jmp next_numeral

add_thousand:
        lda result
        clc
        adc #1000
        sta result
        jmp next_numeral

next_numeral:
        inx
        jmp parse_loop

invalid_numeral:
        lda #'E'
        ; Output error message or handle error in some way
        jmp finished

finished:
        ; Finished processing the Roman numeral, result now contains the integer value
        ; The integer value will be stored in the result variable

        .end
