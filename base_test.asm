
; Calculator program

; Define constants
ADD_OP = $01
SUB_OP = $02
MUL_OP = $03
DIV_OP = $04

; Initialize variables
num1 = $00
num2 = $01
result = $02
operation = $03

; Main program
    LDA #0
    STA result
    LDA #ADD_OP
    STA operation

; Input numbers
input_numbers:
    LDA #$00
    JSR read_input
    
    ; Store first number
    STA num1
    
    LDA #$01
    JSR read_input
    
    ; Store second number
    STA num2
    
    ; Perform selected operation
    LDA operation
    CMP #ADD_OP
    BEQ add_numbers
    CMP #SUB_OP
    BEQ sub_numbers
    CMP #MUL_OP
    BEQ mul_numbers
    CMP #DIV_OP
    BEQ div_numbers

; Addition function
add_numbers:
    LDA num1
    CLC
    ADC num2
    STA result
    JMP display_result

; Subtraction function
sub_numbers:
    LDA num1
    SEC
    SBC num2
    STA result
    JMP display_result

; Multiplication function
mul_numbers:
    LDA num1
    CLC
    ADC result
    TAX
    LDA num1
    JSR shift_left
    BCC mul_incr
    
mul_incr:
    INX
    DEX
    BNE mul_incr

    JMP display_result

shift_left:
    ASL
    ROL num2
    SEC
    SBC num1
    RTS

; Division function
div_numbers:
    LDA num1
    SEC
    SBC num2
    BMI div_end
    STA result
    INC result
    JMP display_result

div_end:
    LDA result
    STA result
    JMP display_result

; Display result
display_result:
    LDA result
    JSR print_result
    
; End program
    RTS

; Read input subroutine
read_input:
    LDA #$FF
    STA $FE
    JSR $FFCF
    LDA $FE
    RTS

; Print result subroutine
print_result:
    STA $FE
    LDA #$02
    JSR $FFD2
    RTS
