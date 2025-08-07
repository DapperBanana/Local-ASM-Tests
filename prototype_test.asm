
    .org $0200

start:
    LDA #7         ; Calculate the 7th term of the Fibonacci sequence
    STA n
    
    LDX #0         ; Initialize F(0)
    STX mem
    INX
    STX mem+1      ; Initialize F(1)
    
    LDA n
    JSR fib        ; Calculate the nth term of the Fibonacci sequence
    STA result
    
    BRK            ; End program
    
fib:
    LDX mem
    LDY mem+1
    CLC
    ADC mem
    STA temp
    LDA mem+1
    ADC temp
    STA result+1
    LDX mem
    LDA mem+1
    STX mem+2
    STA mem+3
    STY mem+4
    LDX mem+2
    LDA mem+3
    STX mem
    STA mem+1
    RTS
    
n:      .byte 0
mem:    .word 0
temp:   .byte 0
result: .word 0
