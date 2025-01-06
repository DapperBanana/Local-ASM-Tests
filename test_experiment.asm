
    LDA var1      ; Load the value of var1 into the accumulator
    STA temp      ; Store the value of var1 in a temporary variable
    LDA var2      ; Load the value of var2 into the accumulator
    STA var1      ; Store the value of var2 in var1
    LDA temp      ; Load the value of var1 (previously stored in temp) into the accumulator
    STA var2      ; Store the original value of var1 (in temp) in var2

var1    .BYTE $10    ; Variable 1 with initial value $10
var2    .BYTE $20    ; Variable 2 with initial value $20
temp    .BYTE $00    ; Temporary variable to store the value of var1

    .END
