
; 6502 Assembly Calculator Program

    .org $0200   ; Start address

    LDA #$00     ; Initialize accumulator to 0
    STA result

loop:
    ; Display menu options
    LDA #<menu
    LDY #>menu
    JSR displayText

    ; Get user input
    JSR getInput

    ; Perform operation based on user input
    CMP #$01
    BEQ add
    CMP #$02
    BEQ sub
    CMP #$03
    BEQ mul
    CMP #$04
    BEQ div
    CMP #$05
    BEQ exit

    ; Invalid option
    JMP loop

add:
    JSR getOperands
    CLC
    ADC num1
    STA result
    JMP loop

sub:
    JSR getOperands
    SEC
    SBC num1
    STA result
    JMP loop

mul:
    JSR getOperands
    LDA num1
    CLC
    ADC num1
    STA result
    JMP loop

div:
    JSR getOperands
    LDA num1
    SEC
    SBC num1
    STA result
    JMP loop

exit:
    RTS

displayText:
    LDX #$00
loop1:
    LDA (X),Y
    BEQ done
    JSR $FFD2
    INX
    JMP loop1
done:
    RTS

getInput:
    JSR $FFCF
    RTS

getOperands:
    LDX #$00
    LDA #$00
loop2:
    JSR getInput
    STA operand,X
    INX
    CPX #$02
    BNE loop2
    RTS

menu:
    .ascii "Calculator\0"
    .byte "$01. Add\0"
    .byte "$02. Subtract\0"
    .byte "$03. Multiply\0"
    .byte "$04. Divide\0"
    .byte "$05. Exit\0"

result:
    .byte $00
num1:
    .byte $00
operand:
    .byte $00
    .byte $00

    .end
