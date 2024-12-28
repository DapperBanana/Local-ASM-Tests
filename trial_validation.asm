
        .org $0200
var1    .byte $05   ; Variable 1
var2    .byte $0A   ; Variable 2

        LDA var1     ; Load the value of var1 into the accumulator
        EOR var2     ; XOR the value of var1 with var2
        STA var2     ; Store the result in var2
        EOR var2     ; XOR the value of var2 with the result
        STA var1     ; Store the result in var1

        BRK         ; End of program

        .org $FFFA
        .word $0200   ; Reset vector
