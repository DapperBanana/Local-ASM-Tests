
; Convert Binary to Decimal program

    .org $0200  ; Start program at memory address $0200

start:
    LDX #$08    ; Number of bits in binary number
    LDA #$00    ; Initialize result to 0
    STA result

convert_loop:
    ASL         ; Shift left
    ROL result  ; Rotate left result
    BCC skip    ; Branch if carry clear

    CLC         ; Clear carry
    LDA result  ; Add 1 to result
    ADC #$01
    STA result

skip:
    DEX         ; Decrement X
    BNE convert_loop  ; Branch to convert_loop if X is not zero

    ; Your binary number should be stored in memory starting at $0200
    LDA #$0200
    LDY #$00
    LDX #$00

    ; Loop to convert binary to decimal
convert_to_decimal:
    LDA $0200, Y
    BEQ done
    
    ASL
    ROL $0300,X
    INY
    INX
    BNE convert_to_decimal

done:
    JMP done   ; End program

result:
    .ds 1    ; Storage for the result (decimal number)
