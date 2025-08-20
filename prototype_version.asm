
    .text
    .globl _start

_start:
    ; Prompt the user to enter the length of the top base
    lda #msg_top_base
    jsr print_string
    lda #0
    jsr get_input

    ; Store the top base length in a memory location
    sta top_base_length

    ; Prompt the user to enter the length of the bottom base
    lda #msg_bottom_base
    jsr print_string
    lda #0
    jsr get_input

    ; Store the bottom base length in a memory location
    sta bottom_base_length

    ; Prompt the user to enter the height of the trapezoidal prism
    lda #msg_height
    jsr print_string
    lda #0
    jsr get_input

    ; Store the height in a memory location
    sta height

    ; Calculate the area of the trapezoidal prism
    lda top_base_length
    clc
    adc bottom_base_length
    lsr
    mul height

    ; Print the result
    lda #msg_result
    jsr print_string

    lda area
    jsr print_num

    ; Exit the program
    lda #0x60
    jsr $FFD2

    ; Define memory locations
top_base_length: .byte 0
bottom_base_length: .byte 0
height: .byte 0
area: .word 0

; Subroutine to print a null-terminated string
print_string:
    sta $fe
loop:
    lda ($fe),y
    beq done
    jsr $FFD2
    iny
    bne loop
done:
    rts

; Subroutine to get user input
get_input:
    ldx #0
read_loop:
    jsr $FFCF
    cmp #$0d
    beq done
    sta input_buffer,x
    inx
    cpx #buffer_size
    bne read_loop
done:
    lda #0
    sta input_buffer,x
    rts

; Subroutine to print a number in memory
print_num:
    ldx #5
next_digit:
    lda #0
    clc
    lsr
    ror area+1
    lsr
    ror area
    ror area
    adc #48
    sta num_buffer,x
    dex
    cpx #0
    bpl next_digit
    ldx #0
print_loop:
    lda num_buffer,x
    beq done_print
    jsr $FFD2
    inx
    bne print_loop
done_print:
    rts

; Define string messages
msg_top_base: .asciiz "Enter the length of the top base: "
msg_bottom_base: .asciiz "Enter the length of the bottom base: "
msg_height: .asciiz "Enter the height of the trapezoidal prism: "
msg_result: .asciiz "The area of the trapezoidal prism is: "

    .end
