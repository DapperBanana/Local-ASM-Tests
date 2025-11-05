
.factorial
    LDA #0         ; initialize accumulator to 0
    STA result     ; store the result in memory location result
    LDA input      ; load the input number into the accumulator
    
.loop
    BEQ .done      ; if input number is 0, we are done
    PHA            ; push current accumulator value onto the stack
    SEC            ; set the carry flag
    SBC #1         ; subtract 1 from the input number
    STA input      ; store the updated input number
    JSR multiply   ; call the multiply subroutine
    PLA            ; pop the original accumulator value from the stack
    CLC            ; clear the carry flag
    ADC result     ; add the current result to accumulator
    STA result     ; store the updated result
    JMP .loop      ; repeat the loop
    
.done
    RTS            ; return from subroutine

.multiply
    LDA result     ; load the current result into accumulator
    ADC input      ; add the input number to accumulator
    STA result     ; store the updated result
    RTS            ; return from subroutine
    
input    .BYTE 5    ; input number
result   .BYTE 0    ; factorial result

    .END
