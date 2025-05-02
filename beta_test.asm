
        .org $0200

var1    .byte $0F       ; Variable 1 with initial value $0F
var2    .byte $A5       ; Variable 2 with initial value $A5

start   lda var1        ; Load the value of var1 into the accumulator
        eor var2        ; XOR the value of var2 with the accumulator
        sta var1        ; Store the result back into var1 (now var1 contains the swapped value)
        eor var2        ; XOR the value of var2 with the accumulator (to cancel out the previous XOR operation)
        sta var2        ; Store the result back into var2 (now var2 contains the swapped value)
        
end     jmp end         ; Infinite loop

        .end
