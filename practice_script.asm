
        .org $0200

start   lda #0
        sta result    ; initialize result to 0

input   lda #0
        sta operand1  ; initialize operand1 to 0

        lda #0
        sta operand2  ; initialize operand2 to 0

        lda #0
        sta operation  ; initialize operation to 0

        lda #0
        sta temp       ; initialize temp to 0

        lda #$01
        sta $FC       ; stack pointer to $01 (0 is reserved for BRK)

input_op
        lda #'+'       ; ask for operation
        jsr print_chr
        
        lda #0
        jsr read_chr
        sta operation

        lda operands
        jsr clear_screen
        jsr print_str
        lda operation
        jsr print_chr

input_op1
        lda #'1'       ; ask for first operand
        jsr print_chr

        lda #0
        jsr read_int
        sta operand1

input_op2
        lda #'2'       ; ask for second operand
        jsr print_chr
        
        lda #0
        jsr read_int
        sta operand2

operation_switch
        lda operation
        cmp #'+'
        beq add_op

        lda operation
        cmp #'-'
        beq sub_op

        lda operation
        cmp #'*'
        beq mul_op

        lda operation
        cmp #'/'
        beq div_op

add_op
        lda operand1
        clc
        adc operand2
        sta result
        jmp display_result

sub_op
        lda operand1
        sec
        sbc operand2
        sta result
        jmp display_result

mul_op
        lda operand1
        clc
        adc #0
        sta temp

mul_op_loop
        lda operand2
        adc result
        sta result
        
        lda temp
        dec temp
        bne mul_op_loop

        jmp display_result

div_op
        lda operand1
        asl
        sta temp

div_op2
        lda temp
        sec
        sbc operand2
        sta temp
        
        lda result
        clc
        adc #1
        sta result

        lda temp
        bcc div_op2

        jmp display_result

display_result
        lda result
        jsr print_int

        lda msg_newline
        jsr print_str

        lda msg_result
        jsr print_str

        lda result
        jsr print_int

        jmp input_op

clear_screen
        lda #'C'
        jsr print_chr
        lda #'L'
        jsr print_chr
        lda #'S'
        jsr print_chr

        lda #$41
        ldy #$00
        lda #$20
        ldx #$11
        jsr $FF6A

        lda msg_newline
        jsr print_str

        rts

print_chr
        sta $FE
        jsr $FFD2
        rts

read_chr
        lda $FE
        rts

print_str
print_str_loop
        lda #$02
        jsr $FFD2
        inx
        lda (vars),x
        bne print_str_loop

        rts

print_int
        ldx #3
        sta $FE
print_int_loop
        lda digit_table, x
        jsr $FFD2
        dex
        bpl print_int_loop

        rts

read_int
        ldx #0
        lda #0
read_int_loop
        lda (operands,x)
        beq read_int_done
        tax
        clc
        lda operand1
        asl
        adc (operands),x
        sta operand1
        inx
        jmp read_int_loop

read_int_done
        rts

msg_newline
        .byte $0D, $0A, $00

msg_result
        .byte 'Result: ', $00

digit_table
        .byte '0', '0', '0', '0'

operands
operand1
operand2

result
operation
temp

        .padding $400

        .include "input.asm"
