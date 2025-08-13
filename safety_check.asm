
    .text
    .globl _start

_start:
    lda #5          ; load length of the rectangle
    sta length

    lda #10         ; load width of the rectangle
    sta width

    lda length
    clc
    adc width       ; add length and width
    sta area        ; store the result in area

    lda length
    adc length      ; calculate 2 times the length
    sta perimeter   ; store the result in perimeter

    lda width
    adc width       ; calculate 2 times the width
    sta perimeter+1 ; store the result in perimeter+1

    jsr print_area  ; print the area
    jsr print_perimeter  ; print the perimeter

    jmp $           ; infinite loop

print_area:
    lda area
    ldx #2
    jsr print_value
    rts

print_perimeter:
    lda perimeter
    ldx #2
    jsr print_value
    lda perimeter+1
    ldx #2
    jsr print_value
    rts

print_value:
    sta temp_value
    ldx #0
print_digit:
    lda temp_value
    jvc skip_sub
    dec temp_value
    inx
    jmp print_digit
skip_sub:
    lda #'0'
    jsr $ffd2
    clc
    lda x
    adc #'0'
    jsr $ffd2
    rts

    .data
length: .byte 0
width:  .byte 0
area:   .byte 0
perimeter: .byte 0, 0
temp_value: .byte 0
