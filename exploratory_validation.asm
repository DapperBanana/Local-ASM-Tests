
    ; Basic Calculator Program
    
    .org $0200
    
start:
    lda #0
    sta result
    
input_numbers:
    ; Read input numbers
    lda #prompt_input_1
    jsr print_string
    jsr get_input
    sta num_1
    
    lda #prompt_input_2
    jsr print_string
    jsr get_input
    sta num_2
    
    ; Display menu
    lda #menu
    jsr print_string
    
    lda #0
    sta operation
    jsr get_operation
    
    ; Perform operation
    cmp #1
    beq add_numbers
    cmp #2
    beq sub_numbers
    cmp #3
    beq mul_numbers
    cmp #4
    beq div_numbers
    
    ; Invalid operation, display error message
    lda #error_message
    jsr print_string
    
    jmp restart
    
add_numbers:
    clc
    lda num_1
    adc num_2
    sta result
    jmp display_result
    
sub_numbers:
    lda num_1
    sbc num_2
    sta result
    jmp display_result
    
mul_numbers:
    lda num_1
    asl
    tay
    lda num_2
    jsr multiply
    jmp display_result
    
div_numbers:
    lda num_1
    ldy #0
    cpx #0
    beq division_by_zero
    divide_loop:
        cmp num_2
        bcc divide_end
        sbc num_2
        iny
        jmp divide_loop
    divide_end:
        sta result
        sty result+1
        jmp display_result
    
display_result:
    lda #result_string
    jsr print_string
    lda result+1
    beq skip_first_digit
    jsr print_digit
    
skip_first_digit:
    lda result
    jsr print_digit
    
    jmp restart
    
division_by_zero:
    lda #divide_by_zero_error
    jsr print_string
    jmp restart
    
restart:
    lda #restart_message
    jsr print_string
    lda #restart_prompt
    jsr print_string
    jmp input_numbers
    
multiply:
    sta temp
    ldy #0
    multiply_loop:
        asl
        bcc skip_shift
        clc
        adc num_1
        skip_shift:
            dey
            bne multiply_loop
            lda temp
            rts
    
print_string:
    ldy #0
    print_loop:
        lda (message),y
        beq print_end
        jsr print_char
        iny
        jmp print_loop
    print_end:
        rts
    
print_char:
    lda #0
    sta $D018
    sta $D011
    sta $D012
    sta $D013
    
    lda #$d018
    jsr $FFDD
    
    lda (message),y
    jsr $FFDD
    
    rts
    
print_digit:
    jsr print_char
    sec
    lda #10
    sbc #48
    jmp print_char
    
get_input:
    jsr get_char
    cmp #$30
    bcc get_input
    cmp #$39
    bcs get_input
    beq store_number
    rts
    
store_number:
    sta temp
    lda #0
    sta num_1
    ldy #0
    load_digits_loop:
        lda temp
        cmp #$0
        beq load_digits_end
        asl
        tay
        dey
        clc
        adc num_1
        sta num_1
        jmp load_digits_loop
    load_digits_end:
        rts
    
get_operation:
    jsr get_char
    cmp #$30
    bcc get_operation
    cmp #$34
    bcs get_operation
    rts
    
get_char:
    lda #$0
    sta $D00D
    lda #$01
    sta $D011
    lda #$08
    sta $D01F
    lda #$02
    sta $D011
    lda #$d011
    lda $d012
    rts
    
    .org $fffc
    .word start
    
    .org $0300
    
    message: .byte "Enter first number: "
    prompt_input_1: .byte 0
    prompt_input_2: .byte "Enter second number: "
    prompt_input_3: .byte "Enter operation (1 - add, 2 - sub, 3 - mul, 4 - div): "
    result_string: .byte "Result: "
    restart_message: .byte "Do you want to restart? (y/n): "
    restart_prompt: .byte "Input: "
    error_message: .byte "Invalid operation!"
    divide_by_zero_error: .byte "Division by zero error!"
    num_1: .byte 0
    num_2: .byte 0
    operation: .byte 0
    temp: .byte 0
    result: .byte 0,0
    
    add_numbers: .byte "Add numbers"
    sub_numbers: .byte "Subtract numbers"
    mul_numbers: .byte "Multiply numbers"
    div_numbers: .byte "Divide numbers"
    menu: .byte "1. Add\n2. Subtract\n3. Multiply\n4. Divide\nEnter your choice: "
