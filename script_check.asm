
    .org $0200

    LDA #0       ; Initialize accumulator with 0
    STA result

start:
    JMP displayMenu

addition:
    JSR getInput       ; Get user input for first number
    STA number1

    JSR getInput       ; Get user input for second number
    CLC
    ADC number1       ; Add the two numbers
    STA result

    JMP displayResult

subtraction:
    JSR getInput       ; Get user input for first number
    STA number1

    JSR getInput       ; Get user input for second number
    SEC
    SBC number1       ; Subtract the two numbers
    STA result

    JMP displayResult

multiplication:
    JSR getInput       ; Get user input for first number
    STA number1

    JSR getInput       ; Get user input for second number
    CLC
    LDA number1       ; Load the first number
    JSR multiply       ; Multiply the two numbers
    STA result

    JMP displayResult

division:
    JSR getInput       ; Get user input for first number
    STA number1

    JSR getInput       ; Get user input for second number
    SEC
    LDA number1       ; Load the first number
    JSR divide         ; Divide the two numbers
    STA result

    JMP displayResult

getInput:
    LDA #$00
    JSR $FFCF

    LSR       ; Divide by 10 to convert to ASCII
    STA input+2

    LSR
    STA input+1

    LSR
    STA input

    RTS

multiply:
    PHA       ; Save the first number
    LDA #0
    STA result2
    
loop:
    CLC
    ADC number2       ; Add the second number to result2
    DEC number1
    BNE loop
    
    PLA       ; Restore the first number
    RTS

divide:
    PHA       ; Save the first number
    LDA #0
    STA result2
    
    LDA #$01
    STA quotient
    
loop1:
    CLC
    ADC number2       ; Add the second number to result2
    BCC skip
    
    SEC
    SBC number1       ; Subtract the first number
    INC quotient
skip:
    DEC number1
    BNE loop1
    
    PLA       ; Restore the first number
    RTS

displayMenu:
    LDX #0
    LDA menuText,x
    JSR $FFD2
    INX
    TXA
    CMP #$04
    BNE displayMenu
    RTS

displayResult:
    LDA result
    JSR $FFD2
    RTS

menuText: .asciiz "Choose operation: 1 - Addition, 2 - Subtraction, 3 - Multiplication, 4 - Division"
result: .byte 0
result2: .byte 0
number1: .byte 0
number2: .byte 0
quotient: .byte 0
input: .byte 0,0,0
