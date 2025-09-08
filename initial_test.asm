
    .text
    .globl _start

_start:
    LDA #0         ; Initialize accumulator with 0
    STA result

    ; Get the first number
    JSR get_number
    STX num1
    STY num2

    ; Get the operation
    JSR get_operation
    LDX operation

    ; Perform the calculation based on the operation
    CPX #1          ; Check for addition
    BEQ addition
    CPX #2          ; Check for subtraction
    BEQ subtraction
    CPX #3          ; Check for multiplication
    BEQ multiplication
    CPX #4          ; Check for division
    BEQ division

    ; Invalid operation
    JSR invalid_operation
    BRA end

addition:
    LDA num1
    CLC
    ADC num2
    STA result
    BRA end

subtraction:
    LDA num1
    SEC
    SBC num2
    STA result
    BRA end

multiplication:
    LDA num1
    STA temp
    LDX #0
    LDY #0

mult_loop:
    LDA num2
    BEQ mult_end
    CLC
    ADC temp
    STA temp
    DEY
    BNE mult_loop

mult_end:
    LDA temp
    STA result
    BRA end

division:
    LDA num1
    STA quotient
    LDX #0

div_loop:
    LDA num2
    BEQ div_end
    SEC
    SBC quotient
    BCC div_end
    INC temp
    JMP div_loop

div_end:
    LDA temp
    STA result
    BRA end

get_number:
    LDA #0
    STA temp
    LDX #0

get_num_loop:
    ; Use system call to get input from user
    JSR $FFCF

    CMP #13         ; Check for Enter key
    BEQ num_end

    CMP #48         ; Check for ASCII '0'
    BLT get_num_loop

    CMP #57         ; Check for ASCII '9'
    BGT get_num_loop

    CLC
    ASL A
    ASL A
    ASL A
    ASL A
    ADC temp
    STA temp
    INX
    BRA get_num_loop

num_end:
    TYA
    STA result
    RTS

get_operation:
    LDX #0

get_op_loop:
    ; Use system call to get input from user
    JSR $FFCF

    CMP #43         ; Check for '+'
    BEQ op_end1

    CMP #45         ; Check for '-'
    BEQ op_end2

    CMP #42         ; Check for '*'
    BEQ op_end3

    CMP #47         ; Check for '/'
    BEQ op_end4

    BRA get_op_loop

op_end1:
    LDX #1
    RTS

op_end2:
    LDX #2
    RTS

op_end3:
    LDX #3
    RTS

op_end4:
    LDX #4
    RTS

invalid_operation:
    ; Print error message for invalid operation
    LDX #1
    JSR $FFD2
    RTS

end:
    ; Print the result
    LDY result
    JSR $FFD2

    ; Terminate the program
    BRK

    .data
num1:    .byte 0
num2:    .byte 0
result:  .byte 0
temp:    .byte 0
quotient:.byte 0
operation:.byte 0
