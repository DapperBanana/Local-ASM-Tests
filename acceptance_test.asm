
LDA $00    ; Load value of variable 1 into accumulator
EOR $01    ; XOR accumulator with value of variable 2
STA $00    ; Store the XOR result back into variable 1
EOR $01    ; XOR the accumulator with the new value of variable 1
STA $01    ; Store the result back into variable 2
