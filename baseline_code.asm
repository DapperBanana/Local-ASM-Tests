
    LDA var1      ; Load value of var1 into accumulator A
    STA temp      ; Store value of var1 in memory location temp

    LDA var2      ; Load value of var2 into accumulator A
    STA var1      ; Store value of var2 in var1

    LDA temp      ; Load value of var1 (previously var2) from memory location temp
    STA var2      ; Store value of var1 (previously var2) in var2

    BRK           ; End program execution

var1   .BYTE   $10   ; Variable 1 with initial value 0x10
var2   .BYTE   $20   ; Variable 2 with initial value 0x20
temp   .BYTE   $00   ; Temporary variable to store value during swap
