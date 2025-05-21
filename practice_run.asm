
        .org    $0200

start   LDA     #10         ; Load the number to calculate factorial of
        STA     number

        LDX     number      ; Initialize X register with the number
        CPX     #0          ; Check if number is 0
        BEQ     done        ; If so, factorial is 1

        LDA     #1          ; Initialize accumulator with 1
loop    DEX                 ; Decrement X register
        BEQ     done        ; If X is 0, exit loop
        JSR     multiply    ; Call multiply subroutine
        JMP     loop        ; Repeat loop

done    BRK                 ; Terminate program

multiply
        CLC                 ; Clear carry flag
        ADC     result      ; Add current result to accumulator
        STA     result      ; Store new result
        RTS

number  .byte   0           ; Storage for the input number
result  .byte   1           ; Storage for the factorial result

        .end
