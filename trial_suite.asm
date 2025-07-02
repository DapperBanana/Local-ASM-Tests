
LDA #0
STA result
LDA input1
STA operand1
LDA input2
STA operand2

; Calculate addition
LDA operand1
CLC
ADC operand2
STA result

; Calculate subtraction
LDA operand1
SEC
SBC operand2
STA result

; Calculate multiplication
LDA #0
STA mul_result
LDA operand2
loop:
    BPL end_loop
    CLC
    ADC operand1
    DEC operand2
    JMP loop
end_loop:
STA mul_result
LDA mul_result
STA result

; Calculate division
LDA #0
STA div_result
LDA operand1
divide:
    SEC
    SBC operand2
    CMP #0
    BCC end_div
    INC div_result
    JMP divide
end_div:
STA div_result
LDA div_result
STA result

result:
