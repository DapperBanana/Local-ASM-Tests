
ORG $1000 ; Start address of the program

START LDX #$07 ; Number of bits
LDY #$00 ; Initialize result to 0

loop LDA $2000, X ; Load a bit of the binary number
BEQ end ; If the bit is 0, go to the end
CLC ; Clear the carry flag
ADC Y ; Add the current result
STA $3000, Y ; Store the result
INY ; Increment the result index
end DEX ; Decrement the bit index
BNE loop ; Loop until all bits are processed

END RTS ; End of the program

; Binary number to convert
DB $01, $01, $00, $01, $00, $01, $00, $00 ; 10010001 in binary
