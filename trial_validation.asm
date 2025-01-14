
ORG $0200  ; Start address of program

LDX #$08   ; Initialize X register with the number of bits in the binary number
LDA #$00   ; Initialize accumulator with 0
LDY #$00   ; Initialize Y register with the decimal value
CLC        ; Clear carry flag

loop:
LSR        ; Shift right to process each bit of the binary number
BCS setbit ; If carry is set, increment decimal value
DEY
BNE process
INC Y      ; Add 1 to the decimal value

process:
TXA        ; Transfer X register to accumulator
DEC X      ; Decrease bit count in X register
BPL loop   ; If X is positive, keep looping

done:
STA $0201  ; Store the decimal value at memory location $0201

BRK        ; End of program

setbit:
CLC        ; Clear carry flag
ADC Y      ; Add the decimal value to accumulator

jmp process ; Jump back to process the next bit
