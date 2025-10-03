
        .text
        .globl _start

_start:
        ; Prompt user to enter length
        lda #<length_msg   ; low byte of length_msg address
        ldx #>length_msg   ; high byte of length_msg address
        jsr print_string

        ; Read user input for length
        lda #0
        jsr read_number
        sta length

        ; Prompt user to enter width
        lda #<width_msg    ; low byte of width_msg address
        ldx #>width_msg    ; high byte of width_msg address
        jsr print_string

        ; Read user input for width
        lda #0
        jsr read_number
        sta width

        ; Calculate area = length * width
        lda length
        sta result
        ldy #0
        lda width
        clc
        adc result
        sta result
        lda length
        adc result

        ; Display the result
        lda #<result_msg   ; low byte of result_msg address
        ldx #>result_msg   ; high byte of result_msg address
        jsr print_string

        lda result
        jsr print_number

        ; Exit program
        lda #0
        jsr exit

length:     .byte 0
width:      .byte 0
result:     .byte 0

length_msg: .asciiz "Enter the length: "
width_msg:  .asciiz "Enter the width: "
result_msg: .asciiz "The area of rectangle is: "

        .include "io_functions.s"
