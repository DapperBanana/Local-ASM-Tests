
; Swap two variables without using a temporary variable

        .org $0200

var1    .byte  $0A        ; Variable 1
var2    .byte  $23        ; Variable 2

        LDA var1         ; Load var1 into the accumulator
        EOR var2         ; XOR var1 with var2
        STA var1         ; Store the result in var1
        EOR var2         ; XOR the accumulator with var2
        STA var2         ; Store the result in var2
        EOR var1         ; XOR the accumulator with var1
        STA var1         ; Store the result in var1

        ; End of program
        BRK
